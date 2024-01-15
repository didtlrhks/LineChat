//
//  Services.swift
//  LineClone
//
//  Created by 양시관 on 1/12/24.
//

import Foundation


protocol ServiceType {
    var authService : AuthenticationServiceType{get set}
    var userServices : UserServiceType{get set}
  //  var contactService : ContactSerViceType {get set}
}


class Services : ServiceType {
    var authService: AuthenticationServiceType
    var userServices: UserServiceType
    
    init() {
        self.authService = AuthenticationService()
        self.userServices = UserService(dbRepository: UserDBRepository())
    }
}

class StubService: ServiceType {
    var authService: AuthenticationServiceType = StubAuthenticationService()
    var userServices: UserServiceType = StubUserService()
    
}
