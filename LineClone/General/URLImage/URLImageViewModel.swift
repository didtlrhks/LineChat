//
//  URLImageViewModel.swift
//  LineClone
//
//  Created by 양시관 on 1/17/24.
//
import UIKit
import Foundation

class URLImageViewModel : ObservableObject {
    
    var loadingOrSuccess : Bool{
        return loading || loadedImage != nil
    }
    
    @Published var loadedImage : UIImage?
    
    private var loading : Bool = false
    private var urlString: String
    private var container : DIContainer
    
    init(container : DIContainer, urlString : String){
        self.container = container
        self.urlString = urlString
    }
    
    func start() {
        guard !urlString.isEmpty else {return }
        
        loading = true
        
        container.services.imageCacheService.image(for: urlString)
    }
}