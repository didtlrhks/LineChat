//
//  ChatView.swift
//  LineClone
//
//  Created by 양시관 on 1/17/24.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel: ChatViewModel
  //  @FocusState private var isFocused: Bool
    @EnvironmentObject var navigationRouter : NavigationRouter
    var body: some View {
        
            ScrollView {
              contentView
            }
        .background(Color.chatg)
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    navigationRouter.pop()
                } label: {
                    Image("back")
                }
                
                Text(viewModel.otherUser?.name ?? "대화방이름")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.bkext)
            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Image(decorative: "search_chat")
                Image(decorative: "bookmark")
                Image(decorative: "settings")
            }
        }
    }
    
    var contentView : some View {
        EmptyView()
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ChatView(viewModel: .init(container: DIContainer(services: StubService()),
                                      chatRoomId: "chatRoom1_id",
                                      myUserId: "user1_id",
                                      otherUserId: "user2_id"))
        }
    }
}
