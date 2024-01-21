//
//  ChatService.swift
//  LineClone
//
//  Created by 양시관 on 1/21/24.
//

import Foundation
import Combine

protocol ChatServiceType {
    func addChat(_ chat: Chat,to chatRoomId : String ) -> AnyPublisher<Chat,ServiceError>
}

class ChatService : ChatServiceType {
    private let dbRepository : ChatDBRepositoryType
    
    init(dbRepository: ChatDBRepositoryType) {
        self.dbRepository = dbRepository
    }
    
    func addChat(_ chat: Chat, to chatRoomId: String) -> AnyPublisher<Chat, ServiceError> {
        
        var chat = chat
        chat.chatId = dbRepository.childByAutoId(chatRoomId: chatRoomId)
        
        return dbRepository.addChat(chat.toObject(), to: chatRoomId)
            .map{chat}
            .mapError{ServiceError.error($0)}
            .eraseToAnyPublisher()
    }
}

class StubChatService : ChatServiceType {
    func addChat(_ chat: Chat, to chatRoomId: String) -> AnyPublisher<Chat, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}
