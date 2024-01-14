//
//  HomeView.swift
//  LineClone
//
//  Created by 양시관 on 1/14/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel : HomeViewModel
    var body: some View {
        NavigationStack{
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
                    ForEach(viewModel.users, id: \.id) {
                        user in
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
                        .padding(.horizontal,30)
                    }
                }
                
            }.toolbar{
                Image("bookmark")
                Image("notifications")
                Image("person_add")
                
                Button{
                    
                } label: {
                    Image("settings")
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
    }
    
    var searchButton : some View {
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

#Preview {
    HomeView(viewModel: .init(container: .init(services: StubService()), userId: "user1_id"))
}
 
    
