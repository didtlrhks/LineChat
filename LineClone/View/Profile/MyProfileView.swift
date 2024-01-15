//
//  MyProfileView.swift
//  LineClone
//
//  Created by 양시관 on 1/15/24.
//

import SwiftUI

struct MyProfileView: View {
    
    @StateObject var viewModel : MyprofileViewModel
    var body: some View {
        NavigationStack{
            ZStack{
                Image("profile_bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea(edges : .vertical)
                
                VStack(spacing : 0) {
                    Spacer()
                    
                    profileView
                        .padding(.bottom,16)
                    
                    nameView
                        .padding(.bottom,26)
                    
                    descriptionView
                    Spacer()
                    menuView
                    
                }
            }
        }
    }
    
    var profileView: some View {
        Button {
            
        } label: {
            Image("person")
                .resizable()
                .frame(width: 80,height: 80)
                .clipShape(Circle())
        }
    }
    
    var nameView : some View{
        
        Text(viewModel.userInfo?.name ?? "이름")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.bgh)
    }
    
    var descriptionView : some View {
        Button {
            
        }label : {
            Text(viewModel.userInfo?.description ?? "상태메세지를 입력해주세요")
                .font(.system(size : 14))
                .foregroundColor(.bgh)
            
        }
    }
    
    var menuView : some View {
        HStack(alignment: .top,spacing: 27) {
            ForEach(MyProfileMenuType.allCases,id :\.self) { menu in
             
                    Button {
                        
                    } label: {
                        VStack(alignment: .center){
                            Image(menu.imageName)
                                .resizable()
                                .frame(width: 50,height: 50)
                            Text(menu.descroption)
                                .font(.system(size:10))
                                .foregroundColor(.bgh)
                        }
                    }
                }
            
        }
    }
}

#Preview {
    MyProfileView(viewModel: .init(container: DIContainer(services: StubService()),userId: "user1_id"))
    
}
