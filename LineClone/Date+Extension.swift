//
//  Date+Extension.swift
//  LineClone
//
//  Created by 양시관 on 1/20/24.
//

import Foundation

extension Date{
    
    var toChatDataKey: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy.MM.dd E"
        return formatter.string(from: self)
    }
}
