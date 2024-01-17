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
        case load
        case requestContacts
        case presentMyProfileView
        case presentOtherProfileView(String)
        case goToChat(User)
       
        
    }
    @Published var myUser : User?
    @Published var users: [User] = []
    @Published var phase : Phase = .notRequest
    @Published var modalDestination : HomeModalDestination?
    
    private var container : DIContainer
     var userId : String
    private var subscriptions = Set<AnyCancellable>()
    
    init(container : DIContainer,userId : String){
        self.container = container
        self.userId = userId
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            phase = .loading
            
            container.services.userServices.getUser(userId: userId)
                .handleEvents(receiveOutput :
                                { [weak self] user in
                    self?.myUser = user
                })
                .flatMap{
                    user in
                    self.container.services.userServices.loadUser(id: user.id)
                }
                .sink { [weak self]completion in
                    if case .failure = completion {
                        self?.phase = .fail
                        
                    }
                } receiveValue: { [weak self] users in
                    self?.phase = .success
                    self?.users = users
                }.store(in: &subscriptions)
 
            
        case .requestContacts:
            container.services.contactService.fetchContacts()
                .flatMap {
                    users in
                    self.container.services.userServices.addUserAfterContact(users: users)
                }
                .flatMap { _ in
                    self.container.services.userServices.loadUser(id: self.userId)
                }
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.phase = .fail
                    }
                }receiveValue: { [weak self] users in
                    self?.phase = .success
                    self?.users = users
                }.store(in: &subscriptions)
            
            
            
            
        case .presentMyProfileView:
            modalDestination = .myProfile
            
            
            
        case let .presentOtherProfileView(userId):
            modalDestination = .otherProfile(userId)
            
        case let .goToChat(otherUser) :
            
            return 
        }
        
        
 
    
    }
}

