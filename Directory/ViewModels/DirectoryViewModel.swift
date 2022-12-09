//
//  DirectoryViewModel.swift
//  Directory
//
//  Created by Edward Arribasplata on 12/2/22.
//

import Foundation
import SwiftUI

protocol DirectoryViewModelProtocol: ObservableObject {
    var employees: [Employee]? { get set }
    var filteredEmployees: [Employee] { get }
    var teams: [String] { get }
    
    var isLoading: Bool { get set }
    var has_error: Bool { get set }
    var error_message:String { get set }
    
    func fetch_employees() async
    func sortByNameDes()
    func loading()
    func loaded()
}


class DirectoryViewModel: DirectoryViewModelProtocol {
    @AppStorage("selectedTeam") var selectedTeam = "All Teams"
    
    @Published var employees:[Employee]?
    @Published var isLoading: Bool = false
    @Published var has_error = false
    @Published var error_message = ""
    
    private let endpoint = EndpointManager()
    
    var filteredEmployees: [Employee] {
        if let employees = employees {
            return employees.filter({
                if selectedTeam == "All Teams"{
                    return true
                } else {
                    return ($0.team ?? "") == selectedTeam
                }
            })
        }
        return []
    }
    
    var teams:[String] {
        if let employees = employees {
            let uniqueTeamsFound = Set(employees.compactMap({$0.team}))
            let sortedUniqueTeams = uniqueTeamsFound.sorted(by: {$0 < $1})
            return sortedUniqueTeams
        }
        return ["All Teams"]
    }
    
    // Fetch all employees from endpoint.
    @MainActor
    func fetch_employees()async {
        loading()
        do {
            self.employees = try await endpoint.fetchEmployees(urlString: endpoint.url_string_employees)
            sortByNameDes()
            loaded()
        } catch {
            loaded()
            self.error_message = error.localizedDescription
            self.has_error = true
        }
    }
    
    // Sort employees by name from A to Z
    func sortByNameDes() {
        self.employees = self.employees?.sorted(by: {
            $0.unwrapped_full_name < $1.unwrapped_full_name
        })
    }
    
    func loading() {
        isLoading = true
    }
    
    func loaded() {
        isLoading = false
    }
}
