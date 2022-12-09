//
//  EmployeePhotoView.swift
//  Directory
//
//  Created by Edward Arribasplata on 12/2/22.
//

import SwiftUI

struct EmployeePhotoView: View {
    
    @StateObject private var manager = CachedImageViewModel()
    
    var employee:Employee
    var size:CGFloat
    
    var placeholder: some View {
        ZStack{
            Color(uiColor: .systemGray5).edgesIgnoringSafeArea(.all)
            Image(systemName: "person.fill").font(.system(size: size/2)).foregroundColor(Color(uiColor: .systemGray3))
        }
    }
    
    var body: some View {
        switchPhaseState(state: manager.currentState)
            .frame(width:size, height:size)
            .clipped()
            .renderedCorners
            .task {
                await manager.load(urlString: employee.photo_url_small ?? "")
            }
    }
    
    @ViewBuilder
    func switchPhaseState(state:CachedImageViewModel.CurrrentState?) -> some View {
        switch state {
        case .loading:
            ZStack{
                Color(uiColor: .systemGray5).edgesIgnoringSafeArea(.all)
                ProgressView()
            }
        case .success(let data):
            if let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                placeholder
            }
        case .failed(_):
            placeholder
        default:
            placeholder
        }
    }
}

struct EmployeePhotoView_Previews: PreviewProvider {
    static var url = "https://s3.amazonaws.com/sq-mobile-interview/photos/8ab10188-74d0-4843-9eb2-1938571f6830/small.jpg"
    static var employee:Employee = Employee(uuid: UUID().uuidString, full_name: "Steve Jobs", photo_url_small:url )
    static var previews: some View {
        VStack{
            Spacer()
            EmployeePhotoView(employee: employee, size: 300)
            Spacer()
        }
        .padding()
        .background(Color.secondary)
    }
}
