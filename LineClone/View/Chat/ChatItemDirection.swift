//
//  ChatItemDirection.swift
//  LineClone
//
//  Created by 양시관 on 1/20/24.
//
import Swift
import SwiftUI

enum ChatItemDirection {
    case left
    case right
    
    var backgroundColor: Color {
        switch self {
        case .left:
            return .chatColorOhter
        case .right:
            return .chatColorMe
        }
    }
    
    var overlayAlignment: Alignment {
        switch self {
        case .left:
            return .topLeading
        case .right:
            return .topTrailing
        }
    }
    
    var overlayImage: Image {
        switch self {
        case .left:
            return Image(decorative: "bubble_tail-left")
        case .right:
            return Image(decorative: "bubble_tail-right")
        }
    }
}
