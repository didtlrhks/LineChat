//
//  ChatRoom.swift
//  LineClone
//
//  Created by 양시관 on 1/17/24.
//

import Foundation
import SwiftUI


struct ChatRoom : Codable {
    var chatRoomId: String
    var lastMessage : String?
    var otherUserName : String
    var otherUserId: String
}

extension ChatRoom {
    func toObject() -> ChatRoomObject {
        .init(chatRoomId: chatRoomId,
              lastMessage: lastMessage,
              otherUserName: otherUserName,
              otherUserId: otherUserId)
    }
}
