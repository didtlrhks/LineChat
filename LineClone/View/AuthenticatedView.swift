//
//  AuthenticatedView.swift
//  LineClone
//
//  Created by 양시관 on 1/12/24.
//

import SwiftUI

struct AuthenticatedView: View {
    @StateObject var authViewModel : AuthenticatedViewModel
    @StateObject var navigationRouter : NavigationRouter
    
    
    var body: some View {
        VStack{
            switch authViewModel.authenticationState {
            case .unauthenticated:
                LoginIntroView()
                    .environmentObject(authViewModel)
            case .authenticated:
                MainTabView()
                    .environmentObject(authViewModel)
                    .environmentObject(navigationRouter)
            }
        }
        .onAppear{
          authViewModel.send(action: .checkAuthenticationState)
           // authViewModel.send(action: .logout)
        }
    }
}

//

#Preview {
    AuthenticatedView(authViewModel: .init(container: .init(services:StubService() )), navigationRouter: .init())
}
