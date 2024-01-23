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
    var fcmToken: String?
}

extension UserObject {
    func toModel() -> User {
        .init(id: id,
              name: name,
              phoneNumber: phoneNumber,
              profileURL: profileURL,
              description: description,
              fcmToken: fcmToken
        )
    }
}
