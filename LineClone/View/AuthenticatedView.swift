//
//  AuthenticatedView.swift
//  LineClone
//
//  Created by 양시관 on 1/12/24.
//

import SwiftUI

struct AuthenticatedView: View {
    @StateObject var authViewModel : AuthenticatedViewModel
    var body: some View {
        VStack{
            switch authViewModel.authenticationState {
            case .unauthenticated:
                LoginIntroView()
                    .environmentObject(authViewModel)
            case .authenticated:
                MainTabView()
            }
        }
        .onAppear{
            authViewModel.send(action: .checkAuthenticationState)
        }
    }
}

//

#Preview {
    AuthenticatedView(authViewModel: .init(container: .init(services:StubService() )))
}
