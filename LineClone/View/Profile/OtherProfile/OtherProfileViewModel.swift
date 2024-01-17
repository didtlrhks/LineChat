//
//  OtherProfileViewModel.swift
//  LineClone
//
//  Created by 양시관 on 1/17/24.
//

import Foundation



@MainActor
class OtherProfileViewModel: ObservableObject {
    
    @Published var userInfo: User?
    
    private let userId: String
    private let container: DIContainer
    
    init(container: DIContainer, userId: String) {
        self.container = container
        self.userId = userId
    }
    
    func getUser() async {
        if let user = try? await container.services.userServices.getUser(userId: userId) {
            userInfo = user
        }
    }
}
