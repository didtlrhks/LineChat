//
//  HomeViewModel.swift
//  LineClone
//
//  Created by 양시관 on 1/14/24.
//

import Foundation


class HomeViewModel : ObservableObject {
    
    
    enum Action {
        case getUser
    }
    @Published var myUser : User?
    @Published var users: [User] = []
    
    private var container : DIContainer
    private var userId : String
    
    init(container : DIContainer,userId : String){
        self.container = container
        self.userId = userId
    }
    
    func send(action: Action) {
        switch action {
        case .getUser:
            
            return
        }
    }
}

