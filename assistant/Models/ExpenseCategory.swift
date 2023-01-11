//
//  ExpenseCategoryModel.swift
//  assistant
//
//  Created by Leonid Semenov on 29.12.2022.
//

import Foundation
import SwiftUI

enum ExpenseCategory: Int, CaseIterable, Hashable {
    case housing
    case transportation
    case utilities
    case healthcare
    case insurance
    case personal
    case dept
    case education
    case giftsDonations
    case entertainment
    case other
}

extension ExpenseCategory {
    func getName() -> String {
        switch self {
        case .housing:
            return "Housing"
        case .transportation:
            return "Transportation"
        case .utilities:
            return "Utilities"
        case .healthcare:
            return "Healthcare"
        case .insurance:
            return "Insurance"
        case .personal:
            return "Personal"
        case .dept:
            return "Dept"
        case .education:
            return "Education"
        case .giftsDonations:
            return "Gifts/Donations"
        case .entertainment:
            return "Entertainment"
        case .other:
            return "Other"
        }
    }
    
    func getTagColor() -> Color {
        return .cyan
    }
}
