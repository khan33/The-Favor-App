//
//  favourView.swift
//  The Favour
//
//  Created by Atta khan on 07/04/2023.
//

import SwiftUI

struct favourView: View {
    var body: some View {
        HStack {
            Image("user_fav_profile")
                .resizable()
                .frame(width: 88)
                .aspectRatio(contentMode: .fit)
           
            VStack(alignment: .leading) {
                Text("Kylee Danford")
                    .font(.system(size: 11))
                    .foregroundColor(.secondary)
                Text("House Cleaning")
                    .font(.subheadline)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .lineLimit(3)
                Text("Written by simon Ng".uppercased())
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .layoutPriority(100)
        }
        .padding()
        .cornerRadius(10)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black.opacity(0.1), lineWidth: 1)
                .shadow(color: Color.gray.opacity(0.5), radius: 2)
        }
        .padding([.top, .horizontal])
        
    }
}

struct favourView_Previews: PreviewProvider {
    static var previews: some View {
        favourView()
    }
}
