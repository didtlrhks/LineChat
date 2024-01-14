//
//  User.swift
//  LineClone
//
//  Created by 양시관 on 1/13/24.
//

import Foundation


struct User {
    var id : String
    var name : String
    var phoneNumber : String?
    var profileURL : String?
    var description : String?
}

extension User {
    static var stub1 : User {
        .init(id : "user_id1", name: "김진영")
    }
    static var stub2 : User {
        .init(id : "user_id2", name: "양시관")
    }
}
