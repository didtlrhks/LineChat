//
//  HomeViewModel.swift
//  LineClone
//
//  Created by 양시관 on 1/14/24.
//

import Foundation


class HomeViewModel : ObservableObject {
    @Published var myUser : User?
    @Published var users: [User] = [.stub1, .stub2]
}
