//
//  UserDBRepository.swift
//  LineClone
//
//  Created by 양시관 on 1/14/24.
//

import Foundation
import Combine
import FirebaseDatabase

protocol UserDBRepositoryType {
    func addUser(_ object: UserObject) -> AnyPublisher<Void,DBError>
    func getUser(userId : String) -> AnyPublisher<UserObject, DBError>
    func loadUser() -> AnyPublisher<[UserObject], DBError>
    
}

class UserDBRepository: UserDBRepositoryType {
    
    var db : DatabaseReference = Database.database().reference()
    
    func addUser(_ object : UserObject) -> AnyPublisher<Void, DBError>{
        
        Just(object)
            .compactMap{try? JSONEncoder().encode($0) }
            .compactMap{try? JSONSerialization.jsonObject(with: $0, options: .fragmentsAllowed) }
            .flatMap {
                value in
                Future<Void , Error> {
                    [weak self] promise in
                    self?.db.child(DBKey.Users).child(object.id).setValue(value) {
                        error, _ in
                        if let error {
                            promise(.failure(error))
                            
                        }else {
                            promise(.success(()))
                        }
                    }
                }
            }
            .mapError{ DBError.error($0)}
            .eraseToAnyPublisher()
     
                    
    }
    
    func getUser(userId: String) -> AnyPublisher<UserObject, DBError> {
        Future<Any?, DBError> { [weak self] promise in
            self?.db.child(DBKey.Users).child(userId).getData { error, snapshot in
                if let error {
                    promise(.failure(DBError.error(error)))
                } else if snapshot?.value is NSNull {
                    promise(.success(nil))
                    
                } else {
                    promise(.success(snapshot?.value))
                }
            }
        }.flatMap {
            value in
            if let value {
                    return Just(value)
                    .tryMap { try JSONSerialization.data(withJSONObject: $0)}
                    .decode(type: UserObject.self, decoder: JSONDecoder())
                    .mapError{DBError.error($0)}
                    .eraseToAnyPublisher()
            } else {
                return Fail(error: .emptyValue).eraseToAnyPublisher()
            }
        }
        .eraseToAnyPublisher()
        }
    
    
    func loadUser() -> AnyPublisher<[UserObject], DBError> {
        Future<Any?, DBError> { [weak self] promise in
            self?.db.child(DBKey.Users).getData {
                error , snapshot in
                if let error {
                    promise(.failure(DBError.error(error)))
                } else if snapshot?.value is NSNull {
                    promise(.success(nil))
                } else {
                    promise(.success(snapshot?.value))
                }

            }
        }
        .flatMap{ value in
            if let dic = value as? [String: [String : Any]] {
                return Just(dic)
                    .tryMap { try JSONSerialization.data(withJSONObject: $0)}
                    .decode(type: [String: UserObject].self, decoder: JSONDecoder())
                    .map{ $0.values.map {$0 as UserObject}}
                    .mapError{DBError.error($0)}
                    .eraseToAnyPublisher()
            }else if value == nil {
                return Just([]).setFailureType(to: DBError.self).eraseToAnyPublisher()
            }else {
                return Fail(error: .invalidatedType).eraseToAnyPublisher()
            }
        }
        .eraseToAnyPublisher()
    }
    }



