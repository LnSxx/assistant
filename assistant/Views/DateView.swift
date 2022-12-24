//
//  DateView.swift
//  assistant
//
//  Created by Leonid Semenov on 22.12.2022.
//

import SwiftUI

struct DateView: View {
    let date: Date
    var dateFormatted: String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "EEEE, dd MMMM"
        return dateFormatterGet.string(from: date)
    }
    
    var body: some View {
        Text(dateFormatted)
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        DateView(date: Date.now)
    }
}
