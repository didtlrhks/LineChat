//
//  LineCloneApp.swift
//  LineClone
//
//  Created by 양시관 on 1/12/24.
//

import SwiftUI

@main
struct LineCloneApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var container : DIContainer = .init(services: Services())
 
    
    var body: some Scene {
        WindowGroup {
            AuthenticatedView(authViewModel: .init(container: container),
                              navigationRouter: .init())
                .environmentObject(container)
        }
    }
}
