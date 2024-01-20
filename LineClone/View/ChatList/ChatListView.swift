//
//  ChatListView.swift
//  LineClone
//
//  Created by 양시관 on 1/14/24.
//

import SwiftUI

struct ChatListView: View {
    @EnvironmentObject var navigationRouter : NavigationRouter
    @StateObject var viewModel : ChatListViewModel
    @EnvironmentObject var container: DIContainer
    
    var body: some View {
        NavigationStack(path: $navigationRouter.destinations){
            ScrollView {
                NavigationLink(value : NavigationDestination.search) {
                    SearchButton()
                }
                .padding(.top,14)
                .padding(.bottom,14)
                
                ForEach(viewModel.chatRoom, id : \.self) {
                    chatRoom in
                    ChatRoomCell(chatRoom: chatRoom, userId: viewModel.userId)
                }
            }
            .navigationTitle("대화")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: NavigationDestination.self){
                NavigationRoutingView(destination: $0)
            }
            .onAppear {
                viewModel.send(action: .load)
            }
        }
    }
}


fileprivate struct ChatRoomCell : View {
    let chatRoom : ChatRoom
    let userId : String
    
    var body: some View {
        NavigationLink(value: NavigationDestination.chat(chatRoomId: chatRoom.chatRoomId, myUserId: userId, otherUserId: chatRoom.otherUserId)){
            HStack(spacing : 8){
                Image("person")
                    .resizable()
                    .frame(width: 40,height:40)
                VStack(alignment:.leading,spacing: 3){
                    Text(chatRoom.otherUserName)
                        .font(.system(size: 14,weight: .bold))
                        .foregroundColor(.bkext)
                    if let lastMessage = chatRoom.lastMessage{
                        Text(lastMessage)
                            .font(.system(size: 12))
                            .foregroundColor(.greyDeep)
                    }
                }
                Spacer()
            }
            .padding(.horizontal,30)
            .padding(.bottom,17)
        }
       
    }
}
#Preview {
    ChatListView(viewModel: .init(container: DIContainer(services: StubService()), userId: "user1_id"))
        .environmentObject(NavigationRouter())
}
