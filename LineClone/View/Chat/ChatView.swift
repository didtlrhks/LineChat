//
//  ChatView.swift
//  LineClone
//
//  Created by 양시관 on 1/17/24.
//

import SwiftUI
import PhotosUI


struct ChatView: View {
    @StateObject var viewModel: ChatViewModel
    @FocusState private var isFocused: Bool
    @EnvironmentObject var navigationRouter : NavigationRouter
    var body: some View {
        
            ScrollView {
                if viewModel.chatDataList.isEmpty {
                    Color.chatg
                }
              contentView
            }
        .background(Color.chatg)
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .tabBar)
        .toolbarBackground(Color.chatg, for: .navigationBar)
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
        .keyboardToolbar(height : 50) {
            HStack(spacing: 13){
                Button {
                    
                } label: {
                    Image("other_add")
                }
                
                PhotosPicker( selection: $viewModel.imageSelection,matching:.images){
                    Image("image_add")
                }
//                Button {
//                    
//                } label: {
//                    Image("image_add")
//                }
                Button {
                    
                } label: {
                    Image("photo_camera")
                }
                TextField("", text: $viewModel.message)
                    .font(.system(size:16))
                    .foregroundColor(.bkext)
                    .focused($isFocused)
                    .padding(.vertical,6)
                    .padding(.horizontal,13)
                    .background(Color.greyool)
                    .cornerRadius(20)
                
                Button {
                    viewModel.send(action: .addChat(viewModel.message))
                    isFocused = false
                }label :
                {
                    Image("send")
                }
                .disabled(viewModel.message.isEmpty)
            }
            .padding(.horizontal,27)
        }
        .onAppear{
            viewModel.send(action: .load)
        }
        
    }
    var contentView: some View {
        ForEach(viewModel.chatDataList) { chatData in
            Section {
                ForEach(chatData.chats) {
                    chat in
                    if let message = chat.message {
                        
                        ChatItemView(message: message, direction: viewModel.getDirection(id: chat.userId), date: chat.date)
                    } else if let photoURL = chat.photoURL {
                        ChatImageItemView(urlString: photoURL, direction: viewModel.getDirection(id: chat.userId))
                    }
                }
            } header: {
                headerView(dateStr: chatData.dateStr)
            }
        }
    }
    
    func headerView(dateStr: String) -> some View {
        ZStack{
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 76,height: 20)
                .background(Color.chatotice)
                .cornerRadius(50)
            Text(dateStr)
                .font(.system(size:10))
                .foregroundColor(.bgh)
        }
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
