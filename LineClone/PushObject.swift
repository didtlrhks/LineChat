//
//  PushObject.swift
//  LineClone
//
//  Created by 양시관 on 1/24/24.
//

import Foundation



import Foundation

struct PushObject: Encodable {
    var to: String
    var notification: NotificationObject
    
    struct NotificationObject: Encodable {
        var title: String
        var body: String
    }
}
