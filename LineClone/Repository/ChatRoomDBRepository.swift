//
//  ChatRoomDBRepository.swift
//  LineClone
//
//  Created by 양시관 on 1/17/24.
//

import Foundation
import Combine
import FirebaseDatabase


protocol ChatRoomDBRepositoryType {
    func getChatRoom(myUserId: String, otherUserId: String) -> AnyPublisher<ChatRoomObject?, DBError>
    func addChatRoom(_ object: ChatRoomObject, myUserId: String) -> AnyPublisher<Void, DBError>
    func loadChatRooms(myUserId: String) -> AnyPublisher<[ChatRoomObject], DBError>
//    func updateChatRoomLastMessage(chatRoomId: String, myUserId: String, myUserName: String, otherUserId: String, lastMessage: String) -> AnyPublisher<Void, DBError>
}

class ChatRoomDBRepository: ChatRoomDBRepositoryType {
    
    // private let reference: DBReferenceType
    var db: DatabaseReference = Database.database().reference()
    
    func getChatRoom(myUserId: String, otherUserId: String) -> AnyPublisher<ChatRoomObject?, DBError> {
        Future<Any?, DBError> {
            [weak self] promise in
            self?.db.child(DBKey.ChatRooms).child(myUserId).child(otherUserId).getData {
                error, snapshot in
                if let error {
                    promise(.failure(DBError.error(error)))
                }else if snapshot?.value is NSNull {
                    promise(.success(nil))
                }else {
                    promise(.success(snapshot?.value))
                }
            }
        }.flatMap {
            value in
            if let value{
                return Just(value)
                    .tryMap{try JSONSerialization.data(withJSONObject: $0)}
                    .decode(type: ChatRoomObject?.self,decoder : JSONDecoder())
                    .mapError {DBError.error($0)}
                    .eraseToAnyPublisher()
            } else {
                return Just(nil).setFailureType(to: DBError.self).eraseToAnyPublisher()
            }
        }
        .eraseToAnyPublisher()
    }
    
    func addChatRoom(_ object: ChatRoomObject, myUserId: String) -> AnyPublisher<Void, DBError> {
        Just(object)
            .compactMap{ try? JSONEncoder().encode($0)}
            .compactMap{ try? JSONSerialization.jsonObject(with: $0, options : .fragmentsAllowed) }
            .flatMap{ value in
                Future<Void, Error> {
                    [weak self] promise in
                    self?.db.child(DBKey.ChatRooms).child(myUserId).child(object.otherUserId).setValue(value) {
                        error , _ in
                        if let error {
                            promise(.failure(error))
                        }else {
                            promise(.success(()))
                        }
                    }
                }
                
            }
            .mapError {DBError.error($0)}
            .eraseToAnyPublisher()
        
    }
    
    
    func loadChatRooms(myUserId: String) -> AnyPublisher<[ChatRoomObject], DBError> {
        Future<Any?,DBError>{
            [weak self] promise in
            self?.db.child(DBKey.ChatRooms).child(myUserId).getData() {
                error , snapshot in
                if let error {
                    promise(.failure(DBError.error(error)))
                } else if snapshot?.value is NSNull {
                    promise(.success(nil))
                }else {
                    promise(.success(snapshot?.value))
                }
            }
        }
        .flatMap {
            value in
            if let dic = value as? [String : [String: Any]]{
                return Just(dic)
                    .tryMap{try JSONSerialization.data(withJSONObject: $0)}
                    .decode(type: [String : ChatRoomObject].self, decoder: JSONDecoder())
                    .map{ $0.values.map{ $0 as ChatRoomObject}}
                    .mapError{DBError.error($0)}
                    .eraseToAnyPublisher()
            } else if value == nil {
                return Just([]).setFailureType(to: DBError.self).eraseToAnyPublisher()
            } else {
                return Fail(error : .invalidatedType).eraseToAnyPublisher()
            }
        }
        .eraseToAnyPublisher()
    }
}


   

