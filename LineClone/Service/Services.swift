//
//  Services.swift
//  LineClone
//
//  Created by 양시관 on 1/12/24.
//

import Foundation


protocol ServiceType {
    var authService : AuthenticationServiceType{get set}
}


class Services : ServiceType {
    var authService: AuthenticationServiceType
    
    init() {
        self.authService = AuthenticationService()
    }
}

class StubService: ServiceType {
    var authService: AuthenticationServiceType = StubAuthenticationService()
    
    
}
