//
//  ChatViewModel.swift
//  LineClone
//
//  Created by 양시관 on 1/20/24.
//

import Foundation
import Combine


class ChatViewModel : ObservableObject {
    enum Action {
        case load
        case addChat(String)
    }
    
    @Published var chatDataList : [ChatData] = []
    @Published var myUser : User?
    @Published var otherUser : User?
    @Published var message : String = ""
    
    private let chatRoomId : String
    private let myUserId :String
    private let otherUserId : String
    
    private var container : DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer,chatRoomId: String, myUserId : String, otherUserId: String) {
        self.container = container
        self.chatRoomId = chatRoomId
        self.myUserId = myUserId
        self.otherUserId = otherUserId
        
//        updateChatDateList(.init(chatId: "chat1_id", userId: "user1_id",message: "Hello", date: Date()))
//        updateChatDateList(.init(chatId: "chat2_id", userId: "user2_id",message: "Hello", date: Date()))
//        updateChatDateList(.init(chatId: "chat3_id", userId: "user1_id",message: "Hello", date: Date()))
    }
    
    
    func updateChatDateList(_ chat : Chat) {
        let key = chat.date.toChatDataKey
        
        if let index = chatDataList.firstIndex(where: {$0.dateStr == key}){
            chatDataList[index].chats.append(chat)
        }else {
            
            let newChatData : ChatData = .init(dateStr: key, chats: [chat])
                chatDataList.append(newChatData)
        }
    }
    
    func getDirection(id: String ) -> ChatItemDirection {
        myUserId == id ? .right : .left
    }
    
    func send(action : Action) {
        switch action {
        case .load:
            Publishers.Zip(container.services.userServices.getUser(userId:myUserId),
                           container.services.userServices.getUser(userId: otherUserId))
            .sink{
                completion in
                
            }
        receiveValue: {
            [weak self] myUser,otherUser in
            self?.myUser = myUser
            self?.otherUser = otherUser
        }.store(in: &subscriptions)
            
        case let .addChat(message):
            let chat : Chat = .init(chatId: UUID().uuidString, userId: myUserId, message: message,date: Date())
            container.services.chatService.addChat(chat, to: chatRoomId)
                .sink{
                    completion in
                    
                } receiveValue: { [weak self] _ in
                    
                    self?.message = ""
                }.store(in: &subscriptions)
        }
    }
    
}
