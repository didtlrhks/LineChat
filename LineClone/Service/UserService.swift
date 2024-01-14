//
//  UserService.swift
//  LineClone
//
//  Created by 양시관 on 1/14/24.
//

import Foundation

protocol UserServiceType {
    
}

class UserService : UserServiceType {
    private var dbRepository : UserDBRepositoryType
    
    init(dbRepository : UserDBRepositoryType) {
        self.dbRepository = dbRepository
        }
}

class StubUserService : UserServiceType {
    
}
