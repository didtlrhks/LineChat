//
//  Chat.swift
//  LineClone
//
//  Created by 양시관 on 1/20/24.
//

import Foundation


struct Chat : Hashable,Identifiable {
    var chatId: String
    var userId : String
    var message : String?
    var photoURL : String?
    var date : Date
    var id : String{ chatId }
}
