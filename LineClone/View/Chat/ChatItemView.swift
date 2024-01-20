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
    let date : Date
    
    
    var body: some View {
        HStack(alignment:.bottom){
            
            if direction == .right {
                Spacer()
                dateView
                
            }
            Text(message)
                .font(.system(size: 14))
                .foregroundColor(.blackix)
                .padding(.vertical,9)
                .padding(.horizontal,20)
                .background(direction.backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .overlay(alignment: .topTrailing){
                    direction.overlayImage
                    
                }
            if direction == .left {
                dateView
                
                Spacer()
            }
            
        }
        .padding(.horizontal,35)
    }
    
    var dateView : some View {
        Text(date.toChatTime)
            .font(.system(size: 10))
            .foregroundColor(.greyeep)
    }
}

struct ChatItemView_PreViews : PreviewProvider {
    static var previews : some View {
        ChatItemView(message : "안녕하세요", direction: .right, date: Date())
    }
}
