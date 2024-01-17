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
    func addUserAfterContact(users : [User]) -> AnyPublisher<Void, ServiceError>
    func getUser(userId: String) -> AnyPublisher<User, ServiceError>
    func getUser(userId: String) async throws -> User
    func loadUser(id : String) -> AnyPublisher<[User],ServiceError>
    func updateProfileURL(userId: String, urlString : String) async throws
    func updateDescription(userId:String,description : String) async throws
  
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
    
    
    func addUserAfterContact(users : [User]) -> AnyPublisher<Void, ServiceError> {
        dbRepository.addUserAfterContact(users: users.map { $0.toObject()})
            .mapError {.error($0)}
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
    
    func getUser(userId: String) async throws -> User {
        let userObject = try await dbRepository.getUser(userId: userId)
        return userObject.toModel()
    }
    
    func loadUser(id : String) -> AnyPublisher<[User],ServiceError> {
        dbRepository.loadUser()
            .map{ $0.map {$0.toModel()}
                    .filter{$0.id != id}
            }
            .mapError{ .error($0)}
            .eraseToAnyPublisher()
    }
    
    func updateDescription(userId:String,description : String) async throws {
        try await dbRepository.updateUser(userId: userId, key: "description", value: description)
    }
    
    func updateProfileURL(userId: String, urlString: String) async throws {
        try await dbRepository.updateUser(userId: userId, key: "profileURL", value: urlString)
    }
}


class StubUserService : UserServiceType {
    func addUser(_ user: User) -> AnyPublisher<User, ServiceError>{
        Empty().eraseToAnyPublisher()
    }
    
    func getUser(userId: String) -> AnyPublisher<User, ServiceError> {
        Just(.stub1).setFailureType(to: ServiceError.self).eraseToAnyPublisher() // 유저 정보가져오기 로그인정보
    }
    
    func loadUser(id : String) -> AnyPublisher<[User],ServiceError> {
        Just([.stub1,.stub2]).setFailureType(to: ServiceError.self).eraseToAnyPublisher() 
    }
    
    func addUserAfterContact(users : [User]) -> AnyPublisher<Void, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    func getUser(userId: String) async throws -> User {
        return .stub1
    }
    
    func updateDescription(userId:String,description : String) async throws {
      
    }
    
    func updateProfileURL(userId: String, urlString: String) async throws {
    //    try await dbRepository.updateUser(userId: user, key: "profileURL", value: urlString)
    }
}
