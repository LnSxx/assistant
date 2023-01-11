//
//  ExpenseCategoryTag.swift
//  assistant
//
//  Created by Leonid Semenov on 04.01.2023.
//

import SwiftUI

struct ExpenseCategoryTag: View {
    let category: ExpenseCategory
    var body: some View {
        Text(category.getName())
            .font(.caption)
            .foregroundColor(.white)
            .padding(5)
            .padding(.leading)
            .padding(.trailing)
            .background(category.getTagColor())
            .cornerRadius(.infinity)
        
    }
}

struct ExpenseCategoryTag_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseCategoryTag(category: .healthcare)
    }
}
