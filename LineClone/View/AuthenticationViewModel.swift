//
//  AuthenticatedViewModel.swift
//  LineClone
//
//  Created by 양시관 on 1/12/24.
//

import Foundation
import Combine


enum AuthenticationState {
    
    case unauthenticated
    case authenticated
    
}




class AuthenticatedViewModel : ObservableObject {
    
    enum Action {
        case googleLogin
        case checkAuthenticationState
        case logout
    }
    
    @Published var authenticationState : AuthenticationState = .unauthenticated
   @Published var isLoading = false
    
    
    var userId : String?
    private var container : DIContainer
    private var subscriptions = Set<AnyCancellable>()
    init(container: DIContainer) {
        self.container = container
        
        
    }
    
    func send(action: Action) {
        switch action {
            
        case .checkAuthenticationState :
     if let userId = container.services.authService.checkAuthenticationState() {
                self.userId = userId
                self.authenticationState = .authenticated
            }
        case .googleLogin :
            isLoading = true
            container.services.authService.signInWithGoogle()
            
                .flatMap{
                    user in
                    self.container.services.authService.signInWithGoogle()
                }
                .sink{ [weak self] completion in
                    
                    if case .failure = completion {
                        self?.isLoading = false
                    }
                }
            receiveValue : { [weak self]
                        user in
                self?.isLoading = false
                self?.userId = user.id
                self?.authenticationState = .authenticated
                        
                    }.store(in: &subscriptions)
                
    
            
            
            
            
        case .logout:
            container.services.authService.logout()
                .sink {
                    completion in
                    
                } receiveValue : { [weak self] _ in
                    self?.authenticationState = .unauthenticated
                    self?.userId = nil
                    
                    
                }.store(in : &subscriptions)
        }
    
    }
    
}
