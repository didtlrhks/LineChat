//
//  ImageCacheService.swift
//  LineClone
//
//  Created by 양시관 on 1/17/24.
//

import Foundation
import Combine
import UIKit


protocol ImageCacheServiceType {
    func image(for key: String) -> AnyPublisher<UIImage?,Never>
}

class ImageCacheService : ImageCacheServiceType {
    let memoryStorage : MemoryStorageType
    let diskStorage : DiskStorageType
    
    init(memoryStorage: MemoryStorageType, diskStorage: DiskStorageType) {
        self.memoryStorage = memoryStorage
        self.diskStorage = diskStorage
    }
    func image(for key: String) -> AnyPublisher<UIImage?,Never>{
        
    }
    
    func imageWithMemoryCache(for key : String ) -> AnyPublisher<UIImage?,Never> {
        
    }
    
}

class StubImageCacheService : ImageCacheServiceType {
    
    func image(for key: String) -> AnyPublisher<UIImage?,Never>{
        Empty().eraseToAnyPublisher()
    }
}
