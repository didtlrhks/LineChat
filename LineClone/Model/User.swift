//
//  User.swift
//  LineClone
//
//  Created by 양시관 on 1/13/24.
//

import Foundation


import Foundation

struct User: Identifiable {
    var id: String
    var name: String
    var phoneNumber: String?
    var profileURL: String?
    var description: String?
    var fcmToken: String? // fcm 토큰을 저장하려고 만듬 왜냐면 상대방한테 알람이가야되니까 
}

extension User {
    func toObject() -> UserObject {
        .init(id: id,
              name: name,
              phoneNumber: phoneNumber,
              profileURL: profileURL,
              description: description,
              fcmToken: fcmToken
        )
    }
}

extension User {
    static var stub1: User {
        .init(id: "user1_id", name: "김하늘")
    }
    
    static var stub2: User {
        .init(id: "user2_id", name: "김코랄")
    }
}
