//
//  NavigationRouter.swift
//  LineClone
//
//  Created by 양시관 on 1/17/24.
//

import Foundation

class NavigationRouter : ObservableObject {
    
    @Published var destinations : [NavigationDestination] = []
    
    func push(to view: NavigationDestination) {
        destinations.append(view)
    }
    
    func pop() {
        _ = destinations.popLast()
    }
    
    func popToRootView(){
        destinations = []
    }
    
}
