//
//  UserDBRepository.swift
//  LineClone
//
//  Created by 양시관 on 1/14/24.
//

import Foundation
import Combine
import FirebaseDatabase

import Foundation
import Combine

protocol UserDBRepositoryType {
    func addUser(_ object: UserObject) -> AnyPublisher<Void, DBError> //이함수를 설명을 해보면 object에 라고 이름을 지정해놓은 매개변수에다가 UserObject를 받아와서AnyPublisher 형태로 리턴을 해줄거고 성공하면 Void 를 반환 그게아니라면 error을 반환해준다.
    func addUserAfterContact(users: [UserObject]) -> AnyPublisher<Void, DBError>// 연락처에서 가져온 User정보를 받아올거고 그 유저정보가 담겨서오고 성공하면 void 안되면 error 를 반환해주는거임
    func getUser(userId: String) -> AnyPublisher<UserObject, DBError>
    func getUser(userId: String) async throws -> UserObject
    func loadUsers() -> AnyPublisher<[UserObject], DBError> // 이거의 의도는 데이터베이스에서 user의 모든 정보를 load해오는 역할을 할거임ㄴ
    func updateUser(userId: String, key: String, value: Any) -> AnyPublisher<Void, DBError>// 업데이트를 해주는거임 userid 랑 key, value를 매개로받아서 사용할거고 성공하면 void, 실패하면 error 를 반환해주는역할을 함
    func updateUser(userId: String, key: String, value: Any) async throws
    func filterUsers(with queryString: String) -> AnyPublisher<[UserObject], DBError> // 이거 역할은 받아오는 user들의 정보를 필터해주는 역할을 해야하기 때문에 with 로 받아야하는 녀석들만을 정해서 받아와서 필터를 걸어서 성공하면 그 유저의 유저정보들을 뿌려주는 역할을 담당하고 queryString: 필터링에 사용할 검색 쿼리 문자열을 나타냅니다. 이 문자열은 사용자 이름, 속성 등과 일치하거나 일부 일치해야 하는 검색 조건을 나타냅니다.
}
// 프로토콜을 정해서 함수하나당 어떻게 함수의 결과값과 에러가 튀어나오는지를 파악해서 써놓고 그에 대한 관련 함수를 밑에서 모두 선언해주는거지
class UserDBRepository: UserDBRepositoryType {

    private let reference: DBReferenceType
    
    init(reference: DBReferenceType) {
        self.reference = reference
    }
    
    func addUser(_ object: UserObject) -> AnyPublisher<Void, DBError> {
        Just(object)// 저스트는 일단 간단하게 제공자라고 생각하면 댐 즉 지금 object를 뱉고있는 거지  데이터인거야 이제 밑부터는 이 데이터를 어떻게 처리할지를 알게되는거임
            .compactMap { try? JSONEncoder().encode($0) }// 자그럼 위에서 나온 object 를 jsonencoder 를 통해서 json형식으로 인코딩을 하는거야 try? 로 인코딩이 성공하면 json 을 데이터를 밷는 거고 그게 아니면 nil을 밷게 되는거임
            .compactMap { try? JSONSerialization.jsonObject(with: $0, options: .fragmentsAllowed) }// 자 그럼 위에 스트림을 이어서 생각을 해보면 json 을 받아와서 이번엔 역직렬화 즉 디코딩을 하는거임 실패하면 nil 배출 그럼 여기까지 object 가 just로 데이터화 됬고 그게 json화 됬고 그게 역직렬화를 통해 데이터베이스에 저장할수 있는 형식이 된거지 이제 그 데이터에 넣는과정을 밑에서 하는거야
            .flatMap { value in // json 화된 친ㄱ가 value 에 있는거고 이거를 이용하여 값을 저장하는 역할을 하는거임
                self.reference.setValue(key: DBKey.Users, path: object.id, value: value)//elf.reference.setValue(...)는 데이터베이스에 값을 저장하는 비동기 작업을 수행하고, 이를 flatMap 연산자를 사용하여 스트림으로 변환합니다. 이 스트림은 성공하면 Void 값을 반환하고, 실패하면 DBError를 반환합니다. 여기서 스트림으로 변환한다는 뜻은 이제 이 데이터를 가공해서 이벤트나 데이터베이스에서 사용할수이쏘록 변환을 해준다는 뜻을 얘기를 하는거지
            }
            .eraseToAnyPublisher() // 이제 여기서 리턴을 해주는거임
        // 그럼 이 함수를 다 탔고 user를 추가해주는 역할을 할 수 가 있는거지용~
        
    }
    
    func addUserAfterContact(users: [UserObject]) -> AnyPublisher<Void, DBError> {
        Publishers.Zip(users.publisher, users.publisher)
            .compactMap { origin, converted in
                if let converted = try? JSONEncoder().encode(converted) {
                    return (origin, converted)
                } else {
                    return nil
                }
            }
            .compactMap { origin, converted in
                if let converted = try? JSONSerialization.jsonObject(with: converted, options: .fragmentsAllowed) {
                    return (origin, converted)
                } else {
                    return nil
                }
            }
            .flatMap { origin, converted in
                self.reference.setValue(key: DBKey.Users, path: origin.id, value: converted)
            }
            .last()
            .eraseToAnyPublisher()
    }
    
    func getUser(userId: String) -> AnyPublisher<UserObject, DBError> {
        reference.fetch(key: DBKey.Users, path: userId)
            .flatMap { value in
                if let value {
                    return Just(value)
                        .tryMap { try JSONSerialization.data(withJSONObject: $0) }
                        .decode(type: UserObject.self, decoder: JSONDecoder())
                        .mapError { DBError.error($0) }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: .emptyValue).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getUser(userId: String) async throws -> UserObject {
        guard let value = try await reference.fetch(key: DBKey.Users, path: userId) else {
            throw DBError.emptyValue
        }
        
        let data = try JSONSerialization.data(withJSONObject: value)
        let userObject = try JSONDecoder().decode(UserObject.self, from: data)
        return userObject
    }

    func loadUsers() -> AnyPublisher<[UserObject], DBError> {
        reference.fetch(key: DBKey.Users, path: nil)
            .flatMap { value in
                if let dic = value as? [String: [String: Any]] {
                    return Just(dic)
                        .tryMap { try JSONSerialization.data(withJSONObject: $0) }
                        .decode(type: [String: UserObject].self, decoder: JSONDecoder())
                        .map { $0.values.map { $0 as UserObject} }
                        .mapError { DBError.error($0) }
                        .eraseToAnyPublisher()
                } else if value == nil {
                    return Just([]).setFailureType(to: DBError.self).eraseToAnyPublisher()
                } else {
                    return Fail(error: .invalidatedType).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    func updateUser(userId: String, key: String, value: Any) async throws  {
        try await reference.setValue(key: DBKey.Users, path: "\(userId)/\(key)", value: value)
    }
    
    func updateUser(userId: String, key: String, value: Any) -> AnyPublisher<Void, DBError> {
        reference.setValue(key: key, path: "\(userId)/\(key)", value: value)
    }
    
    func filterUsers(with queryString: String) -> AnyPublisher<[UserObject], DBError> {
        reference.filter(key: DBKey.Users, path: nil, orderedName: "name", queryString: queryString)
            .flatMap { value in
                if let dic = value as? [String: [String: Any]] {
                    return Just(dic)
                        .tryMap { try JSONSerialization.data(withJSONObject: $0) }
                        .decode(type: [String: UserObject].self, decoder: JSONDecoder())
                        .map { $0.values.map { $0 as UserObject} }
                        .mapError { DBError.error($0) }
                        .eraseToAnyPublisher()
                } else if value == nil {
                    return Just([]).setFailureType(to: DBError.self).eraseToAnyPublisher()
                } else {
                    return Fail(error: .invalidatedType).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
