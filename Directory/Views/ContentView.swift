//
//  ContentView.swift
//  Directory
//
//  Created by Edward Arribasplata on 12/2/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = DirectoryViewModel()
    
    var body: some View {
        DirectoryView()
            .environmentObject(vm)
            .alert(isPresented: $vm.has_error) {
                Alert(
                    title: Text("Directory unreachable"),
                    message: Text(vm.error_message),
                    dismissButton: .cancel())
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
