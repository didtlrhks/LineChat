//
//  ChatRoom.swift
//  LineClone
//
//  Created by 양시관 on 1/17/24.
//

import Foundation
import SwiftUI


struct ChatRoom : Hashable {
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


extension ChatRoom {
    static var stub1: ChatRoom {
        .init(chatRoomId: "chatRoom1_id", otherUserName: "김하늘", otherUserId: "user1_id")
    }
    
    static var stub2: ChatRoom {
        .init(chatRoomId: "chatRoom2_id", otherUserName: "김코랄", otherUserId: "user2_id")
    }
}
