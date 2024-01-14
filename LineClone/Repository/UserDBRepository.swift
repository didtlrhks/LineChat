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
    
    
}
