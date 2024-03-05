//
//  MessageView.swift
//  The Favour
//
//  Created by Atta khan on 14/07/2023.
//

import SwiftUI

struct MessageView: View {
    let message: String
    let backgroundColor: Color
    
    var body: some View {
        VStack {
            Spacer()
            Text(message)
                .foregroundColor(.white)
                .padding()
                .background(Color.red)
                .cornerRadius(10)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .transition(.move(edge: .bottom))
        
    }
}


struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: "Internet not available", backgroundColor: Color.green)
    }
}
