//
//  UploadService.swift
//  LineClone
//
//  Created by 양시관 on 1/17/24.
//

import Foundation

protocol UploadServiceType{
    
    func uploadImage(source: UploadSourceType,data : Data) async throws -> URL
}

class UploadService: UploadServiceType {
    
    private let provider : UploadProviderType
    init(provider: UploadProviderType) {
        self.provider = provider
    }
    
    func uploadImage(source: UploadSourceType, data: Data) async throws -> URL {
      let url = try await provider.upload(path: source.path, data: data, fileName: UUID().uuidString)
        return url
    }
}
class StubUploadService : UploadServiceType {
    
    func uploadImage(source: UploadSourceType, data: Data) async throws -> URL {
        return URL(string: "")!
    }
}
