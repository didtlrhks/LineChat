//
//  Services.swift
//  LineClone
//
//  Created by 양시관 on 1/12/24.
//

import Foundation


protocol ServiceType {
    var authService : AuthenticationServiceType{get set}
    var userServices : UserServiceType{get set}
    var contactService : ContactServiceType {get set}
    var photoPickerService : PhotoPickerServiceType {get set}
    var uploadService : UploadServiceType{get set}
    var imageCacheService : ImageCacheServiceType{get set}
    
}


class Services : ServiceType {
    var authService: AuthenticationServiceType
    var userServices: UserServiceType
    var contactService: ContactServiceType
    var photoPickerService: PhotoPickerServiceType
    var uploadService: UploadServiceType
    var imageCacheService : ImageCacheServiceType
    
    init() {
        self.authService = AuthenticationService()
        self.userServices = UserService(dbRepository: UserDBRepository())
        self.contactService = ContactService()
        self.photoPickerService = PhotoPickerService()
        self.uploadService = UploadService(provider:UploadProvider())
        self.imageCacheService = ImageCacheService()
    }
}

class StubService: ServiceType {
    var authService: AuthenticationServiceType = StubAuthenticationService()
    var userServices: UserServiceType = StubUserService()
    var contactService: ContactServiceType = StubContactService()
    var photoPickerService: PhotoPickerServiceType = StubPhotoPickerService()
    var uploadService: UploadServiceType = StubUploadService()
    var imageCacheService : ImageCacheServiceType = StubImageCacheService()
    
}
