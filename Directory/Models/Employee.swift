//
//  Employee.swift
//  Directory
//
//  Created by Edward Arribasplata on 12/2/22.
//

import SwiftUI

/// JSON response.
struct Employees: Codable {
    var employees:[Employee]
}

/// Object found within JSON response.
struct Employee: Codable, Equatable {
    var id:String { uuid }
    
    var uuid:String
    var full_name:String?
    var phone_number:String?
    var email_address:String?
    var biography:String?
    var photo_url_small:String?
    var photo_url_large:String?
    var team:String?
    var employee_type:String?
}

// Computed Variables.
extension Employee {
    var unwrapped_full_name:String {
        full_name ?? "Unknown Name"
    }
    
    var unwrapped_biography:String {
        biography ?? "No biography"
    }
    
    var is_reachable: Bool {
        has_phone || has_email
    }
    
    var has_phone: Bool {
        phone_number != nil
    }
    
    var has_email: Bool {
        email_address != nil
    }
}

/// Enum classifying employees based on reimbursment methods
enum EmployeeType: String, CaseIterable {
    case FULL_TIME, PART_TIME, CONTRACTOR
}
