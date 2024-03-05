//
//  AvatarView.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI

struct AvatarView: View {
    let image: Image
    let size: CGFloat
    let profileImageURL: URL?

    var body: some View {
        Group {
            if let imageURL = profileImageURL {
                AsyncImage(url: imageURL) { image in
                        image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size, height: size)
                        .clipShape(Circle())
                        .shadow(radius: 1)
                    } placeholder: {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size, height: size)
                            .clipShape(Circle())
                            .shadow(radius: 1)
                    }

            }  else {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size, height: size)
                    .clipShape(Circle())
                    .shadow(radius: 1)
            }
            
        }
            
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(image: Image("avatar"), size: 200, profileImageURL: nil)
    }
}
