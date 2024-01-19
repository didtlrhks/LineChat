//
//  ChatListViewModel.swift
//  LineClone
//
//  Created by 양시관 on 1/19/24.
//

import Foundation
import Combine

class ChatListViewModel : ObservableObject {
    enum Action
    {
        case load
    }
    
    @Published var chatRoom: [ChatRoom] = []
    private var container : DIContainer
    private var subscription = Set<AnyCancellable>()
     let userId : String
    
    init(container: DIContainer, userId: String) {
        self.container = container
        self.userId = userId
    }
    
    func send(action: Action){
        switch action {
        case .load :
            container.services.chatRoomService.loadChatRooms(myUserId: userId)
                .sink{
                    completion in
                } receiveValue : {
                    [weak self] chatRooms in
                    self?.chatRoom = chatRooms
                }.store(in: &subscription)
        }
    }
}
