//
//  DBError.swift
//  LineClone
//
//  Created by 양시관 on 1/14/24.
//

import Foundation


enum DBError : Error {
    case error(Error)
    case emptyValue
}
