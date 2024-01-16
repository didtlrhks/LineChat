//
//  PhotoPickerService.swift
//  LineClone
//
//  Created by 양시관 on 1/16/24.
//

import Foundation
import SwiftUI
import PhotosUI

enum PhotoPickerError : Error {
    case importFailed
}

protocol PhotoPickerServiceType {
    func loadTransferable(from imageSelection : PhotosPickerItem) async throws -> Data
}

class PhotoPickerService: PhotoPickerServiceType {
    func loadTransferable(from imageSelection : PhotosPickerItem) async throws -> Data{
        guard let image = try await imageSelection.loadTransferable(type: PhotoImage.self) else {
            throw PhotoPickerError.importFailed
        }
        
        return image.data
    }
}
class StubPhotoPickerService: PhotoPickerServiceType {
    
    func loadTransferable(from imageSelection : PhotosPickerItem) async throws -> Data{
        return Data()
}
    
}
