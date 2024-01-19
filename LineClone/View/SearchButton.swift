//
//  SearchButton.swift
//  LineClone
//
//  Created by 양시관 on 1/19/24.
//

import SwiftUI

struct SearchButton: View {
    var body: some View {
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

#Preview {
    SearchButton()
}
