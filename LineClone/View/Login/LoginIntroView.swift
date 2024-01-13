//
//  LoginIntroView.swift
//  LineClone
//
//  Created by 양시관 on 1/12/24.
//

import SwiftUI

struct LoginIntroView: View {
    
    @State private var isPresentedLoginView : Bool = false
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                Text("환영합니다.")
                    .font(.system(size: 26,weight: .bold))
                    .foregroundColor(.bkext)
                Text("무료 시지와 영상통화, 음성통화를 부담없이 즐겨보세요!")
                    .font(.system(size: 12))
                    .foregroundColor(.greyeep)
                
                Spacer()
                
                Button
                {
                    isPresentedLoginView.toggle()
                }label: {
                    Text("로그인")
                        .font(.system(size: 14))
                        .foregroundColor(.lineAppColor)
                        .frame(maxWidth: .infinity,maxHeight: 40)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.lineAppColor,lineWidth: 0.8)
                }
                .padding(.horizontal,15)
            }
            .navigationDestination(isPresented: $isPresentedLoginView) {
                LoginView()
            }
        }
    }
}

#Preview {
    LoginIntroView()
}
