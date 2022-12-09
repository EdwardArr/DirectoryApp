//
//  EmployeeCardView.swift
//  EmployeeDirectory
//
//  Created by Edward Arribasplata on 12/2/22.
//

import SwiftUI

struct EmployeeCardView: View {
    var employee: Employee
    var size: CGFloat
    
    var body: some View {
        VStack(alignment:.leading, spacing:20) {
            employeePhoto
            employeeCardTextContent
        }
        .roundedRectangleBackground
    }
}


// Employee photo.
extension EmployeeCardView {
    var employeePhoto: some View {
        EmployeePhotoView(employee: employee, size: size)
    }
}

// Employee name, bio and contact.
extension EmployeeCardView {
    var employeeCardTextContent: some View {
        VStack(alignment:.leading, spacing:10) {
            employeeNameAndBio
            if employee.is_reachable {
                Divider()
                contactRow
            }
        }.padding([.bottom, .horizontal])
    }
}

// Employee name and bio.
extension EmployeeCardView {
    var employeeNameAndBio: some View {
        VStack(alignment:.leading, spacing:5) {
            employeeName
            employeeBio
        }
    }
    
    var employeeName: some View {
        Text(employee.unwrapped_full_name).employeeNameStyle
    }
    
    var employeeBio: some View {
        Text(employee.unwrapped_biography).employeeBiographyStyle
    }
}

// Contact buttons on card.
extension EmployeeCardView {
    var contactRow: some View {
        HStack(spacing:20){
            if employee.has_email {
                emailButton
            }
            if employee.has_phone {
                phoneButton
            }
        }
    }
    
    var emailButton: some View {
        Button(action: {
            handleEmailButtonAction()
        }, label: {
            Image(systemName: "envelope").font(.title3).foregroundColor(.blue)
        })
        .buttonStyle(.plain)
    }
    
    func handleEmailButtonAction() {
        let mailtoString = "mailto:\(employee.email_address ?? "")".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let mailtoUrl = URL(string: mailtoString!)!
        if UIApplication.shared.canOpenURL(mailtoUrl) {
                UIApplication.shared.open(mailtoUrl, options: [:])
        }
    }
    
    var phoneButton: some View {
        Button(action: {
            handlePhoneButtonAction()
        }, label: {
            Image(systemName: "phone").font(.title3).foregroundColor(.blue)
        })
        .buttonStyle(.plain)
    }
    
    func handlePhoneButtonAction() {
        let phone = "tel://"
        let phoneNumberFormatted  = phone + (employee.phone_number ?? "")
        guard let url = URL(string: phoneNumberFormatted) else { return }
        UIApplication.shared.open(url)
    }
}

struct EmployeeCardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing:20){
            Spacer()
            EmployeeCardView(employee:Employee(uuid:UUID().uuidString, full_name: "Steve Jobs", biography: "Co-Founder of Apple."), size: 300 )
            Spacer()
        }
        .padding(.horizontal)
        .background(Color.secondary.edgesIgnoringSafeArea(.all))
    }
}
