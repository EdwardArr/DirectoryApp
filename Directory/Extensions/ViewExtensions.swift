//
//  ViewExtensions.swift
//  EmployeeDirectory
//
//  Created by Edward Arribasplata on 12/2/22.
//

import Foundation
import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
            clipShape( RoundedCorner(radius: radius, corners: corners) )
        }
    
    var renderedCorners: some View {
        self
            .cornerRadius(12.0, corners: [.topRight, .topLeft])
    }
    
    var roundedRectangleBackground: some View {
        self
            .background(Color(uiColor: .secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12.0, style: .continuous))
    }
    
    
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
