//
//  DocumentUploadButton.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI

struct DocumentUploadButton: View {
    let title: String
    @Binding var image: UIImage?
    var action: (() -> Void)?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
            .fill(Color(hex: "#F8F8F8"))
            .border(.appBorderColor, width: 1, cornerRadius: 16)
            .overlay {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .cornerRadius(8)
                        .padding(.all, 8)
                } else {
                    VStack(alignment: .center, spacing: 12) {
                        ZStack {
                            Circle()
                                .frame(width: 44, height: 44)
                                .foregroundColor(.appPrimaryColor)
                                .opacity(0.2)
                            Image(systemName: "plus")
                                .foregroundColor(.appPrimaryColor)
                                .frame(width: 44, height: 44)
                        }
                        FavorText(text: title, textColor: Color(#colorLiteral(red: 0.46, green: 0.46, blue: 0.46, alpha: 1)), fontType: .semiBold, fontSize: 18)
                    }
                }
            }
            
        }
        .frame(width: UIScreen.main.bounds.size.width - 24, height: 144)
        .onTapGesture {
            action?()
        }
    }
}

struct DocumentUploadButton_Previews: PreviewProvider {
    static var previews: some View {
        @State var selectedFrontImage: UIImage? = nil

        DocumentUploadButton(title: "Upload ID Front", image: $selectedFrontImage)
    }
}
