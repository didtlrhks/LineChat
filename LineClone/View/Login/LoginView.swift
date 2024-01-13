//
//  LoginView.swift
//  LineClone
//
//  Created by 양시관 on 1/13/24.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel : AuthenticatedViewModel
    
    var body: some View {
        
        VStack(alignment : .leading) {
            Group {
                Text("로그인")
                    .font(.system(size: 28,weight: .bold))
                    .foregroundColor(.bkext)
                    .padding(.top,80)
                
                Text("아래 제공되는 서비스로 로그인을 해주세요")
                    .font(.system(size: 14))
                    .foregroundColor(.greyeep)
            }
            
            .padding(.horizontal,30)
            Spacer()
            Button {
                authViewModel.send(action: .googleLogin)
            }
            label : {
                Text("Google로 로그인")
                
            }.buttonStyle(LoginButtonStyle(textColor: .bkext, borderColor: .greyight))
            
            Button {
               
            }
            label : {
                Text("Apple로 로그인")
                
            }.buttonStyle(LoginButtonStyle(textColor: .bkext, borderColor: .greyight))
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItemGroup(placement : .navigationBarLeading) {
                Button {
                    dismiss()
                }label : {
                    Image("back")
                }
            }
        }
    }
}


#Preview {
    LoginView()
}
