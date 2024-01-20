//
//  NavigationDestination.swift
//  LineClone
//
//  Created by 양시관 on 1/17/24.
//

import Foundation


enum NavigationDestination: Hashable {
    case chat(chatRoomId : String, myUserId : String, otherUserId : String)
    case search
    
}
