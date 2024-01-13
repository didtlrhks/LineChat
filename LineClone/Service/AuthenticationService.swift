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
import AuthenticationServices


enum AuthenticationError : Error {
    case clientIDError
    case tokenError
    case invalidated
}

protocol AuthenticationServiceType {
    func signInWithGoogle() -> AnyPublisher<User, ServiceError>
}

class AuthenticationService: AuthenticationServiceType {
    
    
    func signInWithGoogle() -> AnyPublisher<User, ServiceError> {
        Future { [weak self] promise in
            self?.signInWithGoogle { result in
                switch result {
                case let .success(user):
                    promise(.success(user))
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
        }.eraseToAnyPublisher()
    }
}
  

extension AuthenticationService {
    
    private func signInWithGoogle(completion: @escaping (Result<User, Error>) -> Void){
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
        
                GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController){[weak self]
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
                    print(accessToken)
                    let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        
                    self?.authenticateUserWithFirebase(credential: credential, completion: completion)
                }
            }
        
            private func authenticateUserWithFirebase(credential : AuthCredential, completion : @escaping (Result<User, Error>) -> Void){
                Auth.auth().signIn(with: credential){
                    result , error in
                    if let error {
                        completion(.failure(error))
                        return
                    }
        
                    guard let result else{
                        completion(.failure(AuthenticationError.invalidated))
                        return
                    }
        
                    let firebaseUser = result.user
                    let user : User = .init(id:firebaseUser.uid,
                                            name: firebaseUser.displayName ?? "",
                                            phoneNumber: firebaseUser.phoneNumber,
                                            profileURL: firebaseUser.photoURL?.absoluteString)
        
                    completion(.success(user))
        
        
        
                    }
            }
        }


class StubAuthenticationService : AuthenticationServiceType{
    func signInWithGoogle() -> AnyPublisher<User,ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}





//private func signInWithGoogle(completion: @escaping (Result<User, Error>) -> Void) {
//        guard let clientID = FirebaseApp.app()?.options.clientID else {
//            completion(.failure(AuthenticationError.clientIDError))
//            return
//        }
//
//        let config = GIDConfiguration(clientID: clientID)
//        GIDSignIn.sharedInstance.configuration = config
//
//        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//              let window = windowScene.windows.first,
//              let rootViewController = window.rootViewController else {
//            return
//        }
//
//        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] result, error in
//            if let error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let user = result?.user, let idToken = user.idToken?.tokenString else {
//                completion(.failure(AuthenticationError.tokenError))
//                return
//            }
//
//            let accessToken = user.accessToken.tokenString
//            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
//
//            self?.authenticateUserWithFirebase(credential: credential, completion: completion)
//        }
//    }
//
//    private func handleSignInWithAppleCompletion(_ authorization: ASAuthorization,
//                                                 nonce: String,
//                                                 completion: @escaping (Result<User, Error>) -> Void) {
//        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
//              let appleIDToken = appleIDCredential.identityToken else {
//            completion(.failure(AuthenticationError.tokenError))
//            return
//        }
//
//        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
//            completion(.failure(AuthenticationError.tokenError))
//            return
//        }
//
//        let credential = OAuthProvider.credential(withProviderID: "apple.com",
//                                                  idToken: idTokenString,
//                                                  rawNonce: nonce)
//
//        authenticateUserWithFirebase(credential: credential) { result in
//            switch result {
//            case var .success(user):
//                user.name = [appleIDCredential.fullName?.givenName, appleIDCredential.fullName?.familyName]
//                    .compactMap { $0 }
//                    .joined(separator: " ")
//                completion(.success(user))
//            case let .failure(error):
//                completion(.failure(error))
//            }
//        }
//    }
//
//    private func authenticateUserWithFirebase(credential: AuthCredential, completion: @escaping (Result<User, Error>) -> Void) {
//        Auth.auth().signIn(with: credential) { result, error in
//            if let error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let result else {
//                completion(.failure(AuthenticationError.invalidated))
//                return
//            }
//
//            let firebaseUser = result.user
//            let user: User = .init(id: firebaseUser.uid,
//                                   name: firebaseUser.displayName ?? "",
//                                   phoneNumber: firebaseUser.phoneNumber,
//                                   profileURL: firebaseUser.photoURL?.absoluteString)
//
//            completion(.success(user))
//        }
//    }




























//
//
//
//enum AuthenticationError : Error {
//    case clientIDError
//    case tokenError
//    case invalidated
//}
//
//protocol AuthenticationServiceType {
//    func signInWithGoogle() -> AnyPublisher<User, ServiceError>
//}
//
//class AuthenticationService : AuthenticationServiceType{
//    
//    func signInWithGoogle() -> AnyPublisher<User, ServiceError> {
//        
//        Future { [weak self] promise in
//            self?.signInWithGoogle {
//                result in
//                switch result {
//                case let .success(user):
//                    promise(.success(user))
//                case let .failure(error):
//                    promise(.failure(.error(error)))
//                }
//            }
//            
//        }.eraseToAnyPublisher()
//    }
//    }
//
//
//extension AuthenticationService {
//    private func signInWithGoolge(completion : @escaping (Result<User,Error>) -> Void){
//        guard let clientID = FirebaseApp.app()?.options.clientID else {
//            completion(.failure(AuthenticationError.clientIDError))
//            return
//        }
//
//private func signInWithGoogle(completion: @escaping (Result<User, Error>) -> Void){
//    guard let clientID = FirebaseApp.app()?.options.clientID else {
//        completion(.failure(AuthenticationError.clientIDError))
//        return
//    }
//
//        let config = GIDConfiguration(clientID: clientID)
//        GIDSignIn.sharedInstance.configuration = config
//        
//        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//                let window = windowScene.windows.first,
//                let rootViewController = window.rootViewController else {
//            return
//        }
//        
//        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController){[weak self]
//            result , error in
//            if let error {
//                completion(.failure(error))
//                return
//            }
//            
//            guard let user = result?.user, let idToken = user.idToken?.tokenString else {
//                completion(.failure(AuthenticationError.tokenError))
//                return
//                
//            }
//            
//            let accessToken = user.accessToken.tokenString
//            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
//            
//            
//            self?.authenticateUserWithFirebase(credential: credential, completion: completion)
//        }
//    }
//    
//    private func authenticateUserWithFirebase(credential : AuthCredential, completion : @escaping (Result<User, Error>) -> Void){
//        Auth.auth().signIn(with: credential){
//            result , error in
//            if let error {
//                completion(.failure(error))
//                return
//            }
//            
//            guard let result else{
//                completion(.failure(AuthenticationError.invalidated))
//                return
//            }
//            
//            let firebaseUser = result.user
//            let user : User = .init(id:firebaseUser.uid,
//                                    name: firebaseUser.displayName ?? "",
//                                    phoneNumber: firebaseUser.phoneNumber,
//                                    profileURL: firebaseUser.photoURL?.absoluteString)
//            
//            completion(.success(user))
//                       
//            
//            
//            }
//    }
//}
//
//
//class StubAuthenticationService : AuthenticationServiceType{
//    func signInWithGoogle() -> AnyPublisher<User,ServiceError> {
//        Empty().eraseToAnyPublisher()
//    }
//}
//
//
//
