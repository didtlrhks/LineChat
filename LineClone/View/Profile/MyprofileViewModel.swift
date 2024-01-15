//
//  MyprofileViewModel.swift
//  LineClone
//
//  Created by 양시관 on 1/15/24.
//

import Foundation

class MyprofileViewModel : ObservableObject {
    @Published var userInfo : User?
    private var container : DIContainer
    private let userId : String
    
    init(container: DIContainer,userId : String) {
        self.container = container
        self.userId =  userId
    }
}
