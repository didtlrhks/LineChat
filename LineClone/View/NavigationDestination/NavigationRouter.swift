//
//  NavigationRouter.swift
//  LineClone
//
//  Created by 양시관 on 1/17/24.
//

import Foundation
import Combine

protocol NavigationRoutable {
    var destinations: [NavigationDestination] { get set }
    
    func push(to view: NavigationDestination)
    func pop()
    func popToRootView()
}

class NavigationRouter: NavigationRoutable, ObservableObjectSettable {
    
    var objectWillChange: ObservableObjectPublisher?
    
    var destinations: [NavigationDestination] = [] {
        didSet {
            objectWillChange?.send()
        }
    }
    
    func push(to view: NavigationDestination) {
        destinations.append(view)
    }
    
    func pop() {
        _ = destinations.popLast()
    }
    
    func popToRootView() {
        destinations = []
    }
}
