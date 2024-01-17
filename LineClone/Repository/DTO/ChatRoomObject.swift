//
//  ChatRoomObject.swift
//  LineClone
//
//  Created by 양시관 on 1/17/24.
//

import Foundation


struct ChatRoomObject: Codable {
    var chatRoomId : String
    var lastMessage : String?
    var otherUserName : String
    var otherUserId : String
}


extension ChatRoomObject {
    func toModel() -> ChatRoom {
        .init(chatRoomId: chatRoomId,
              lastMessage: lastMessage,
              otherUserName: otherUserName,
              otherUserId : otherUserId
        )
    }
}
