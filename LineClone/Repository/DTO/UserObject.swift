//
//  UserObject.swift
//  LineClone
//
//  Created by 양시관 on 1/14/24.
//

import Foundation


import Foundation

struct UserObject: Codable {
    var id: String
    var name: String
    var phoneNumber: String?
    var profileURL: String?
    var description: String?
    var fcmToken: String? // 유저정보에도 저장을 해주고
//    //유저 오브젝트라는 구조체를만들고 codable 프로토콜을 사용해서
//    Codable 프로토콜은 Swift에서 데이터를 직렬화(인코딩)하고 역직렬화(디코딩)하는 데 사용되는 프로토콜입니다. 구조체나 클래스가 Codable 프로토콜을 채택하면 해당 타입의 인스턴스를 JSON 형식으로 인코딩하거나 JSON 데이터를 해당 타입의 인스턴스로 디코딩할 수 있습니다. 이는 네트워크 통신에서 데이터를 주고받거나 데이터를 파일로 저장하고 불러올 때 유용합니다.
//
//    예를 들어, UserObject 인스턴스를 JSON 형식의 데이터로 변환하고 저장하려면 인코딩을 사용할 수 있으며, 이후에 해당 JSON 데이터를 읽어와 UserObject로 디코딩할 수 있습니다. 이를 통해 데이터를 간단하게 다룰 수 있고, 서버와 클라이언트 간에 데이터를 주고받을 때 데이터 형식을 일치시키는 데 도움이 됩니다.
}

extension UserObject {
    func toModel() -> User {
        .init(id: id,
              name: name,
              phoneNumber: phoneNumber,
              profileURL: profileURL,
              description: description,
              fcmToken: fcmToken // 초기화해주고 
        )// 함수 toModel은 User 에다가 init에서 초기화해준 내용의 값들을 추기화해주는 기능을 extensiond으로 추가해준 것들이고 이함수는 UserObject를 User로 변환해주는거를 말한다 .
    }
}
