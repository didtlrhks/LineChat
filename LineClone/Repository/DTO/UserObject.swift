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
}

extension UserObject {
    func toModel() -> User {
        .init(id: id,
              name: name,
              phoneNumber: phoneNumber,
              profileURL: profileURL,
              description: description,
              fcmToken: fcmToken // 초기화해주고 
        )
    }
}
