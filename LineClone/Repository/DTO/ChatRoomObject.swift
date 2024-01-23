//
//  ChatRoomObject.swift
//  LineClone
//
//  Created by 양시관 on 1/17/24.
//

import Foundation

import Foundation

struct ChatRoomObject: Codable {
    var chatRoomId: String
    var lastMessage: String?
    var otherUserName: String
    var otherUseId: String
}

extension ChatRoomObject {
    func toModel() -> ChatRoom {
        .init(chatRoomId: chatRoomId,
              lastMessage: lastMessage,
              otherUserName: otherUserName,
              otherUseId: otherUseId)
    }
}

extension ChatRoomObject {
    static var stub1: ChatRoomObject {
        .init(chatRoomId: "chatRoom1_id",
              otherUserName: "user2",
              otherUseId: "user2_id")
    }
}
