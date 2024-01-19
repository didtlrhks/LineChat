//
//  NavigationRoutingView.swift
//  LineClone
//
//  Created by 양시관 on 1/19/24.
//

import SwiftUI

struct NavigationRoutingView: View {
    
    @State var destination : NavigationDestination
    var body: some View {
        switch destination {
        case .chat:
            ChatView()
        case .search:
            SearchView()
        }
    }
}

