//
//  DirectoryView.swift
//  Directory
//
//  Created by Edward Arribasplata on 12/2/22.
//

import SwiftUI

struct DirectoryView: View {
    @AppStorage("selectedTeam") var selectedTeam = "All Teams"
    @EnvironmentObject var vm: DirectoryViewModel
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                List {
                    TeamMenuView()
                        .listSectionSeparator(.hidden)
                        .listRowBackground(Color(uiColor: .systemGroupedBackground))
                    ForEach(vm.filteredEmployees, id:\.id) { employee in
                        EmployeeCardView(employee: employee, size: geometry.size.width-40)
                            .listRowSeparator(.hidden)
                    }
                    .listRowBackground(Color(uiColor: .systemGroupedBackground))
                }
                .navigationTitle("Directory")
                .listStyle(.plain)
                .listItemTint(Color(uiColor: .systemGroupedBackground))
                .background(Color(uiColor: .systemGroupedBackground).edgesIgnoringSafeArea(.all))
            }
            .id(selectedTeam) // Force GeometryReader to redraw.
            .transition(.opacity)
            .task {
                await vm.fetch_employees()
            }
            .refreshable {
                await vm.fetch_employees()
            }
        }
        .overlay {
            if !vm.isLoading && vm.filteredEmployees.isEmpty {
                Text("No employees found").foregroundColor(.secondary)
            }
            
            if vm.isLoading && vm.filteredEmployees.isEmpty {
                ProgressView()
            }
        }
    }
}

struct DirectoryView_Previews: PreviewProvider {
    static var previews: some View {
        DirectoryView().environmentObject(DirectoryViewModel())
    }
}
