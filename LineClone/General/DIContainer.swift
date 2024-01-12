//
//  DIContainer.swift
//  LineClone
//
//  Created by 양시관 on 1/12/24.
//

import Foundation


class DIContainer : ObservableObject {
    
    
    var services : ServiceType
    
    
    init(services: ServiceType) {
        self.services = services
    }
}
