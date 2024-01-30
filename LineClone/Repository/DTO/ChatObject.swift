//
//  ChatObject.swift
//  LineClone
//
//  Created by 양시관 on 1/21/24.
//

import Foundation

import Foundation

struct ChatObject: Codable {
    var chatId: String
    var userId: String
    var message: String?
    var photoURL: String?
    var date: TimeInterval
}

extension ChatObject {
    func toModel() -> Chat {
        .init(chatId: chatId,
              userId: userId,
              message: message,
              photoURL: photoURL,
              date: Date(timeIntervalSince1970: date))
    }
}
//여기도 전에 Dto 와 마찬가지로 코더블을 사용해주고 이를 익스텐션해서 초기설정에서 값들을 Chat으로 던져주는 역할을 함
