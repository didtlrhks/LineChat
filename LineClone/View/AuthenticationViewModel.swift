//
//  AuthenticatedViewModel.swift
//  LineClone
//
//  Created by 양시관 on 1/12/24.
//

import Foundation


enum AuthenticationState {
    case unauthenticated
    case authenticated
    
}




class AuthenticatedViewModel : ObservableObject {
    
    @Published var authenticationState : AuthenticationState = .unauthenticated
    
    private var container : DIContainer
    init(container: DIContainer) {
        self.container = container
        
        
    }
    
}
