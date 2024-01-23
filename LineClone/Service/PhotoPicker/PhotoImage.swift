//
//  PhotoImage.swift
//  LineClone
//
//  Created by 양시관 on 1/16/24.
//

import Foundation
import SwiftUI

import SwiftUI

struct PhotoImage: Transferable {
    
    let data: Data
    
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(importedContentType: .image) { data in
            guard let uiImage = UIImage(data: data) else {
                throw PhotoPickerError.importFailed
            }
            
            guard let data = uiImage.jpegData(compressionQuality: 0.3) else {
                throw PhotoPickerError.importFailed
            }
            
            return PhotoImage(data: data)
        }
    }
}
