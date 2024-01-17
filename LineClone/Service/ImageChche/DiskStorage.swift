//
//  DiskStorage.swift
//  LineClone
//
//  Created by 양시관 on 1/17/24.
//

import Foundation
import UIKit
import SwiftUI
import CryptoKit



protocol DiskStorageType {
    func value(for key : String) throws -> UIImage?
    func stroe(for key : String ,image: UIImage) throws
}

class DiskStorage : DiskStorageType {
    
    let fileManager : FileManager
    let directioryURL : URL
    
    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
        self.directioryURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0].appendingPathComponent("ImageCache")
        
            createDirectory()
    }
    
    func createDirectory() {
        guard !fileManager.fileExists(atPath: directioryURL.path()) else {
            return
        }
        do {
            try fileManager.createDirectory(at:directioryURL, withIntermediateDirectories: true)
            
        } catch {
            print(error)
        }
    }
    
    
    func cacheFileURL(for key : String) -> URL {
      let fileName = sha256(key)
        return directioryURL.appendingPathComponent(fileName, isDirectory:false)
    }

    func value(for key : String) throws -> UIImage?{
        
        
    }
    
   
    
    
    func stroe(for key : String ,image: UIImage) throws{
        
        
}
}



