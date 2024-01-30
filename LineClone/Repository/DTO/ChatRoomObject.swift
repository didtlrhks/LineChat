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
// 여기에서도 마찬가지로 ChatRoomObject 구조체를 코더블 프로토콜을 따르게 설정해서 밑에 내용들이 json 직렬화(인코딩 ) 역직렬화 (디코딩) 등의 작업을 해줄수있게 해주는 역할을 함
extension ChatRoomObject {
    func toModel() -> ChatRoom {
        .init(chatRoomId: chatRoomId,
              lastMessage: lastMessage,
              otherUserName: otherUserName,
              otherUseId: otherUseId)
    }
}//여기에서는 ChatRoomobject를 ChatRoom으로 보내주는 역할을 함

extension ChatRoomObject {
    static var stub1: ChatRoomObject {
        .init(chatRoomId: "chatRoom1_id",
              otherUserName: "user2",
              otherUseId: "user2_id")
    }
}//이건 예상되는 내용의 값들을 넣어준것뿐임 
