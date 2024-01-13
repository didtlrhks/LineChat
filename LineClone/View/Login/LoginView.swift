//
//  LoginView.swift
//  LineClone
//
//  Created by 양시관 on 1/13/24.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack(alignment : .leading) {
            Text("로그인")
                .font(.system(size: 28,weight: .bold))
                .foregroundColor(.bkext)
                .padding(.top,80)
            
            Text("아래 제공되는 서비스로 로그인을 해주세요")
                .font(.system(size: 14))
                .foregroundColor(.greyeep)
            
            Spacer()
        }
    }
}

#Preview {
    LoginView()
}
