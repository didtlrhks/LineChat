//
//  HomeView.swift
//  LineClone
//
//  Created by 양시관 on 1/14/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var container : DIContainer
    @EnvironmentObject var navigationRouter : NavigationRouter
    @StateObject var viewModel : HomeViewModel
    var body: some View {
        NavigationStack(path: $navigationRouter.destinations){
            contentView
                .fullScreenCover(item: $viewModel.modalDestination) {
                    switch $0 {
                        
                        
                    case .myProfile :
                        MyProfileView(viewModel: .init(container: container, userId: viewModel.userId))
                    case let .otherProfile(userId):
                        OtherProfileView(viewModel: .init(container: container, userId: userId)){ otherUserInfo in
                            viewModel.send(action: .goToChat(otherUserInfo))
                            
                            
                        }
                    }
                }
                .navigationDestination(for: NavigationDestination.self)
            {
                switch $0 {
                case .chat:
                    ChatView()
                case .search:
                    SearchView()
                }
            }
        }
    }
    
    
    @ViewBuilder
    var contentView : some View {
        switch viewModel.phase {
        case .notRequest:
            PlaceholderView()
                .onAppear {
                    viewModel.send(action: .load)
                }
        case .loading:
            LoadingView()
        case .success:
            loadedView
                .toolbar{
                    Image("bookmark")
                    Image("notifications")
                    Image("person_add")
                    
                    Button{
                        
                    } label: {
                        Image("settings")
                    }
                }
        case .fail:
            ErrorView()
        }
    }
    
    var loadedView : some View {
        ScrollView{
            profileView
                .padding(.bottom,30)
            searchButton
                .padding(.bottom,24)
            
            HStack{
                Text("친구")
                    .font(.system(size: 14))
                    .foregroundColor(.bkext)
                Spacer()
            }
            .padding(.horizontal,30)
            
            if viewModel.users.isEmpty {
                Spacer(minLength: 89)
                emptyView
            } else {
                LazyVStack{
                    ForEach(viewModel.users, id: \.id) {
                        user in
                        Button {
                            viewModel.send(action: .presentOtherProfileView(user.id))
                        } label: {
                            HStack(spacing: 8){
                                Image("person")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                Text(user.name)
                                    .font(.system(size:12))
                                    .foregroundColor(.bkext)
                                Spacer()
                            }
                        }
                        .padding(.horizontal,30)
                    }
                }
            }
            
        }
        
    }
    
    
    
    var profileView: some View {
        HStack{
            VStack(alignment: .leading, spacing:  7) {
                Text(viewModel.myUser?.name ?? "이름")
                    .font(.system(size: 22,weight: .bold))
                    .foregroundColor(.bkext)
                Text(viewModel.myUser?.description ?? "상태메시지 입력")
                    .font(.system(size: 12))
                    .foregroundColor(.greyeep)
                
            }
            
            Spacer()
            
            Image("person")
                .resizable()
                .frame(width: 52,height: 52)
                .clipShape(Circle())
        }
        .padding(.horizontal,30)
        .onTapGesture {
            viewModel.send(action: .presentMyProfileView)
        }
    }
    
    var searchButton : some View {
        NavigationLink(value : NavigationDestination.search){
            ZStack{
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 36)
                    .background(Color.greyool)
                    .cornerRadius(5)
                
                HStack{
                    Text("검색")
                        .font(.system(size: 12))
                        .foregroundColor(.greyightVer2)
                    Spacer()
                }
                .padding(.leading,22)
            }
            .padding(.horizontal,30)
        }
    }
    
    var emptyView: some View {
        VStack{
            VStack(spacing:3) {
                Text("친구를 추가해보세요.")
                    .foregroundColor(.bkext)
                Text("큐알코드나 검색을 이용해서 친구를 추가해보세요.")
                    .foregroundColor(.greyeep)
                
            }
            .font(.system(size : 14))
            .padding(.bottom,30)
            
            Button{
                viewModel.send(action: .requestContacts)
            } label: {
                Text("친구추가")
                    .font(.system(size : 14))
                    .foregroundColor(.bkext)
                    .padding(.vertical,9)
                    .padding(.horizontal,24)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.greyight)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static let container: DIContainer = .init(services: StubService())
    static let navigationRouter : NavigationRouter = .init()
    
    static var previews: some View {
        HomeView(viewModel: .init(container: Self.container,navigationRouter: Self.navigationRouter, userId: "user1_id"))
            .environmentObject(Self.navigationRouter)
            .environmentObject(Self.container)
    }
}

