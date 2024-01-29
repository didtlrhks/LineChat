//
//  UploadProvider.swift
//  LineClone
//
//  Created by 양시관 on 1/17/24.
//
//일단 import 부터 보게 되면 firebasestorage 나 combine async await 기능들을 사용하기 위해서 이런 프로토콜들을 따른다고 설명하는거임
import Foundation
import Combine
import FirebaseStorage
import FirebaseStorageCombineSwift


import Foundation
import Combine
import FirebaseStorage
import FirebaseStorageCombineSwift

enum UploadError: Error { // 열거형으로 UploadError 을 선언하고 Error 타입으로 설명을 해놓음 // 파일업로드 부분에서 오류가 날수있는 부분들을 정의를 해놓은거임
    case error(Error)
}

protocol UploadProviderType { // 프로토콜을 정의를해준다 이거는 UploadProviderType 을 지정을 해놓고 이제 이런 프로토콜을 따를때 이렇게 사용한다를 아는거임
    func upload(path: String, data: Data, fileName: String) -> AnyPublisher<URL, UploadError>//AnyPublisher은 다른 퍼블리셔를 감싸서 값은 잘 보내주되 , 타입정보를 숨길수있어서 더 안전하다 여기서 URL 은 성공했을경우에 출력되는값인거고 실패했을때는 uploadError 를 보내주는거임 여기서는 enum으로 정의한값이 나가는거지
    func upload(path: String, data: Data, fileName: String) async throws -> URL // async 는 비동기처리방식을 따른다는것이고 비동기를 따른다는 뜻은 쓰레드를 병렬적으로 처리한다는 뜻이고 이함수보다 중요한 일이있다면 그거먼저해줘라는 뜻을 가진다 그래서 쓰레드를 돌리면서 실행을 멈추지않고 다른 녀석을 계속 일을 시키는것을 말한다 .throws 는 뭔가 문제가 생겼을 경우에 error 를 던진다라는 의미를 가진다 ,만약 성공적으로 함수가 처리된다면 URL을 반환한다는 의미를 말한다.
    //둘중 하나만 사용해도 가능한거임
}

class UploadProvider: UploadProviderType {  // UploadProviderType 이 프로토콜을 따르는 class 를 구현해줌 왜냐면 upload 함수를 사용한다고 하면 이 프로토콜을 따라야한다고 명시를 해주는것임
    
    let storageRef = Storage.storage().reference() // 파이어베이스 스토리지를 초기화해주는 역할을 한다 
    
    func upload(path: String, data: Data, fileName: String) -> AnyPublisher<URL, UploadError> {
        let ref = storageRef.child(path).child(fileName)
        
        return ref.putData(data)
            .flatMap { _ in
                ref.downloadURL()
            }
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }
    
    func upload(path: String, data: Data, fileName: String) async throws -> URL {
        let ref = storageRef.child(path).child(fileName)
        let _ = try await ref.putDataAsync(data)
        let url = try await ref.downloadURL()
        
        return url
    }
}
