//
//  MessageBubbleView.swift
//  The Favour
//
//  Created by Atta khan on 22/05/2023.
//

import SwiftUI

struct MessageBubbleView: View {
    let message: String
    let isSender: Bool
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                if isSender {
                    Spacer()
                }
                
                Text(message)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(isSender ? Color.blue : Color.green)
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity, alignment: isSender ? .trailing : .leading)
                
                if !isSender {
                    Spacer()
                }
            }
            .padding(.horizontal, 8)
        }
    }
}


struct MessageBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubbleView(message: "hi! how are you doing today", isSender: true)
    }
}
