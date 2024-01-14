//
//  MainTabView.swift
//  LineClone
//
//  Created by 양시관 on 1/12/24.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var container : DIContainer
    @EnvironmentObject var authViewModel : AuthenticatedViewModel
    
    @State private var selectedTab : MainTabType = .home
    
    var body: some View {
        TabView(selection : $selectedTab ){
            ForEach(MainTabType.allCases,id : \.self) {
                tab in
                Group {
                    switch tab {
                    case .home:
                        HomeView(viewModel: .init(container : container,userId : authViewModel.userId ?? ""))
                    case .chat:
                        ChatListView()
                    case .phone:
                        Color.blackix
                    }
                }
                .tabItem {
                    Label(tab.title, image : tab.imageName(selected: selectedTab == tab))
                }
                .tag(tab)
            }
        }
        .tint(.bkText)
        }
    init()
    {
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.bkText)
    }
}

#Preview {
    MainTabView()
}
