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


import UIKit

protocol DiskStorageType {
    func value(for key: String) throws -> UIImage?
    func store(for key: String, image: UIImage) throws
}


class DiskStorage: DiskStorageType {
    
    let fileManager: FileManager
    let directoryURL: URL
    
    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
        self.directoryURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0].appendingPathComponent("ImageCache")
        
        createDirectory()
    }
    
    func createDirectory() {
        guard !fileManager.fileExists(atPath: directoryURL.path()) else { return }
        
        do {
            try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true)
        } catch {
            print(error)
        }
    }
    
    func cacheFileURL(for key: String) -> URL {
        let fileName = key.sha256() // String 확장을 사용하여 SHA256 해시 계산
        return directoryURL.appendingPathComponent(fileName, isDirectory: false)
    }

    
    func value(for key: String) throws -> UIImage? {
        let fileURL = cacheFileURL(for: key)
        
        guard fileManager.fileExists(atPath: fileURL.path()) else {
            return nil
        }
        
        let data = try Data(contentsOf: fileURL)
        return UIImage(data: data)
    }
    
    func store(for key: String, image: UIImage) throws {
        let data = image.jpegData(compressionQuality: 0.5)
        let fileURL = cacheFileURL(for: key)
        try data?.write(to: fileURL)
    }
}


extension String {
    func sha256() -> String {
        let data = Data(self.utf8)
        let hash = SHA256.hash(data: data)
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}

