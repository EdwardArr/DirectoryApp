//
//  TextExtension.swift
//  EmployeeDirectory
//
//  Created by Edward Arribasplata on 12/2/22.
//

import SwiftUI

extension Text {
    var employeeNameStyle: Self {
        self
            .font(.headline)
    }
    
    var employeeBiographyStyle: Self {
        self
            .font(.subheadline)
            .foregroundColor(.secondary)
    }
}
