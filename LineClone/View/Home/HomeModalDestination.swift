//
//  HomeModalDestination.swift
//  LineClone
//
//  Created by 양시관 on 1/15/24.
//

import Foundation


enum HomeModalDestination : Hashable,Identifiable {
    case myProfile
    case otherProfile(String)
    
    var id : Int {
        hashValue
    }
}
