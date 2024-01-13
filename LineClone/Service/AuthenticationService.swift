//
//  AuthenticationService.swift
//  LineClone
//
//  Created by 양시관 on 1/12/24.
//

import Foundation
import Combine
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

enum AuthenticationError : Error {
    case clientIDError
    case tokenError
}

protocol AuthenticationServiceType {
    func signInWithGoogle() -> AnyPublisher<User,ServiceError>
}

class AuthenticationService : AuthenticationServiceType{
    func signInWithGoogle() -> AnyPublisher<User,ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}

extension AuthenticationService {
    private func signInWithGoolge(completion : @escaping (Result<User,Error>) -> Void){
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            completion(.failure(AuthenticationError.clientIDError))
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let window = windowScene.windows.first,
                let rootViewController = window.rootViewController else {
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController){
            result , error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                completion(.failure(AuthenticationError.tokenError))
                return
                
            }
            
            let accessToken = user.accessToken.tokenString
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        }
    }
}


class StubAuthenticationService : AuthenticationServiceType{
    func signInWithGoogle() -> AnyPublisher<User,ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}
