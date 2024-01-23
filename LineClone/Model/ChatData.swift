//
//  ChatData.swift
//  LineClone
//
//  Created by 양시관 on 1/20/24.
//

import Foundation

import Foundation

struct ChatData: Hashable, Identifiable {
    var dateStr: String
    var chats: [Chat]
    var id: String { dateStr }
}
