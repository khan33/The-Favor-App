//
//  FavorTextField.swift
//  The Favour
//
//  Created by Atta khan on 16/04/2023.
//

import SwiftUI

struct FavorTextField: View {
    let placeholder: String
    let leftImage: String?
    let rightImage: String?
    var isPassword: Bool = false
    @Binding var text: String
    var action: (() -> Void)? = nil

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.appTextFieldColor)
                .frame(height: 60)
                .border(.appWhite, width: 1, cornerRadius: 12)
            HStack {
                if let left_image = leftImage {
                    Image(left_image)
                }
                if !isPassword {
                    TextField(placeholder, text: $text, onEditingChanged: { editing in
                        action?()
                    })
                        .foregroundColor(.appBlack)
                        .font(.localizedFont(fontType: .regular, fontSize: 14))
                } else {
                    SecureField(placeholder, text: $text)
                        .foregroundColor(.appBlack)
                        .font(.localizedFont(fontType: .regular, fontSize: 14))
                }
                if let right_image = rightImage {
                    Image(right_image)
                        .onTapGesture {
                            action?()
                        }
                }
                
            }.padding(.horizontal)
                
        }
        
        
    }
}

struct FavorTextField_Previews: PreviewProvider {
    static var previews: some View {
        FavorTextField(placeholder: "Email", leftImage: nil, rightImage: "calander", text: .constant("abc@gmailcom"))
    }
}
