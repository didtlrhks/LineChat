//
//  AuthenticatedViewModel.swift
//  LineClone
//
//  Created by 양시관 on 1/12/24.
//

import Foundation
import Combine

import Foundation
import Combine
import AuthenticationServices

enum AuthenticationState {
    case unauthenticated
    case authenticated
}

class AuthenticationViewModel: ObservableObject {
    
    enum Action {
        case checkAuthenticationState
        case googleLogin
    //    case appleLogin(ASAuthorizationAppleIDRequest)
     //   case appleLoginCompletion(Result<ASAuthorization, Error>)
        case requestPushNotification
        case setPushToken
        case logout
    }
    
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var isLoading = false
    
    var userId: String?
    
    private var currentNonce: String?
    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action: Action) {
        switch action {
        case .checkAuthenticationState:
            if let userId = container.services.authService.checkAuthenticationState() {
                self.userId = userId
                self.authenticationState = .authenticated
            }
            
        case .googleLogin:
            isLoading = true
            
            container.services.authService.signInWithGoogle()
                .flatMap { user in
                    self.container.services.userService.addUser(user)
                }
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.isLoading = false
                    }
                } receiveValue: { [weak self] user in
                    self?.isLoading = false
                    self?.userId = user.id
                    self?.authenticationState = .authenticated
                }.store(in: &subscriptions)
//
//        case let .appleLogin(request):
//            let nonce = container.services.authService.handleSignInWithAppleRequest(request)
//            currentNonce = nonce
//
//        case let .appleLoginCompletion(result):
//            if case let .success(authorization) = result {
//                guard let nonce = currentNonce else { return }
//
//                container.services.authService.handleSignInWithAppleCompletion(authorization, none: nonce)
//                    .flatMap { user in
//                        self.container.services.userService.addUser(user)
//                    }
//                    .sink { [weak self] completion in
//                        if case .failure = completion {
//                            self?.isLoading = false
//                        }
//                    } receiveValue: { [weak self] user in
//                        self?.isLoading = false
//                        self?.userId = user.id
//                        self?.authenticationState = .authenticated
//                    }.store(in: &subscriptions)
//
//            } else if case let .failure(error) = result {
//                isLoading = false
//                print(error.localizedDescription)
//            }
            
        case .requestPushNotification: // 여기에서 노티피케이션을 사용해도 되냐는 요청을 받는거임  그리고 setPushtoken 으로 가서 
            container.services.pushNotificationService.requestAuthorization { [weak self] granted in
                guard granted else { return }
                self?.send(action: .setPushToken)
            }
            
        case .setPushToken:
            container.services.pushNotificationService.fcmToken
                .compactMap { $0 }
                .flatMap { fcmToken -> AnyPublisher<Void, Never> in
                    guard let userId = self.userId else { return Empty().eraseToAnyPublisher() }
                    return self.container.services.userService.updateFCMToken(userId: userId, fcmToken: fcmToken)
                        .replaceError(with: ())
                        .eraseToAnyPublisher()
                }
                .sink { _ in
                }.store(in: &subscriptions)
            
        case .logout:
            container.services.authService.logout()
                .sink { completion in
                    
                } receiveValue: { [weak self] _ in
                    self?.authenticationState = .unauthenticated
                    self?.userId = nil
                }.store(in: &subscriptions)

        }
    }
}
