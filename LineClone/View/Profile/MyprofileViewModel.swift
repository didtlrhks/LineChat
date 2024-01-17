//
//  MyprofileViewModel.swift
//  LineClone
//
//  Created by 양시관 on 1/15/24.
//

import Foundation
import PhotosUI
import SwiftUI

class MyprofileViewModel : ObservableObject {
    @Published var userInfo : User?
    @Published var isPresentedDescEditView : Bool = false
    @Published var imageSelection : PhotosPickerItem?{
        
        didSet{
            Task{
                await updateProfileImage(pickerItem: imageSelection)
            }
        }
    }
    
    private var container : DIContainer
    private let userId : String
    
    
    init(container: DIContainer,userId : String) {
        self.container = container
        self.userId =  userId
    }
    
    func getUser() async {
        if let user = try? await container.services.userServices.getUser(userId: userId) {
            userInfo = user
            
        }
    }
    func updateDescription(_ description: String) async {
        do{
            try await container.services.userServices.updateDescription(userId: userId, description: description)
            userInfo?.description = description
        } catch {
            
        }
    }
    func updateProfileImage(pickerItem:PhotosPickerItem?) async {
        guard let pickerItem else {return}
        do{
            
            let data = try await container.services.photoPickerService.loadTransferable(from: pickerItem)
            let url = try await container.services.uploadService.uploadImage(source: .profile(userId: userId), data: data)
          try await container.services.userServices.updateProfileURL(userId: userId, urlString: url.absoluteString)
            userInfo?.profileURL = url.absoluteString
        } catch {
            print(error.localizedDescription)
        }
    }
}
