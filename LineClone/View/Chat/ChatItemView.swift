//
//  ChatItemView.swift
//  LineClone
//
//  Created by 양시관 on 1/20/24.
//

import SwiftUI

struct ChatItemView: View {
    let message : String
    let direction : ChatItemDirection
    
    
    var body: some View {
        Text(message)
            .font(.system(size: 14))
            .foregroundColor(.blackix)
            .padding(.vertical,9)
            .padding(.horizontal,20)
            .background(Color.chatolorMe)
    }
}

struct ChatItemView_PreViews : PreviewProvider {
    static var previews : some View {
        ChatItemView(message : "안녕하세요", direction: .right)
    }
}
