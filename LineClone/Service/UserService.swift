//
//  UserService.swift
//  LineClone
//
//  Created by 양시관 on 1/14/24.
//

import Foundation
import Combine


protocol UserServiceType {
    func addUser(_ user: User) -> AnyPublisher<User, ServiceError>
    func getUser(userId: String) -> AnyPublisher<User, ServiceError>
}

class UserService : UserServiceType {
    private var dbRepository : UserDBRepositoryType
    
    init(dbRepository : UserDBRepositoryType) {
        self.dbRepository = dbRepository
        }
    func addUser(_ user: User) -> AnyPublisher<User, ServiceError>{
        dbRepository.addUser(user.toObject())
            .map{ user }
            .mapError{.error($0)}
            .eraseToAnyPublisher()
    }
    
    func getUser(userId: String) -> AnyPublisher<User, ServiceError>{
        dbRepository.getUser(userId: userId)
            .map{
                $0.toModel()
            }
            .mapError {.error($0)}
            .eraseToAnyPublisher()
    }
}

class StubUserService : UserServiceType {
    func addUser(_ user: User) -> AnyPublisher<User, ServiceError>{
        Empty().eraseToAnyPublisher()
    }
    
    func getUser(userId: String) -> AnyPublisher<User, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}
