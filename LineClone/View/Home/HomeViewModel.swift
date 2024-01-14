//
//  HomeViewModel.swift
//  LineClone
//
//  Created by 양시관 on 1/14/24.
//

import Foundation
import Combine


class HomeViewModel : ObservableObject {
    
    
    enum Action {
        case getUser
    }
    @Published var myUser : User?
    @Published var users: [User] = []
    
    private var container : DIContainer
    private var userId : String
    private var subscriptions = Set<AnyCancellable>()
    
    init(container : DIContainer,userId : String){
        self.container = container
        self.userId = userId
    }
    
    func send(action: Action) {
        switch action {
        case .getUser:
            
            container.services.userServices.getUser(userId: userId)
                .sink {
                    completion in
                } receiveValue: { [weak self] user in
                    self?.myUser = user
                }.store(in: &subscriptions)
        }
    }
}

