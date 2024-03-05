//
//  CustomAlertView.swift
//  The Favour
//
//  Created by Atta khan on 03/02/2024.
//

import SwiftUI

struct CustomAlertView: View {
    let title: String?
    let message: String?
    let primaryButtonLabel: String
    let primaryButtonAction: () -> Void
    let secondaryButtonLabel: String?
    let secondaryButtonAction: (() -> Void)?
    let image: Image?

    init(title: String?, message: String?, primaryButtonLabel: String, primaryButtonAction: @escaping () -> Void, secondaryButtonLabel: String? = nil, secondaryButtonAction: ( () -> Void)? = nil, image: Image? = nil) {
        self.title = title
        self.message = message
        self.primaryButtonLabel = primaryButtonLabel
        self.primaryButtonAction = primaryButtonAction
        self.secondaryButtonLabel = secondaryButtonLabel
        self.secondaryButtonAction = secondaryButtonAction
        self.image = image
    }

    var body: some View {
        VStack {
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
            } else if let title = title {
                FavorText(text: title, textColor: .black, fontType: .bold, fontSize: 24)
            }
            if let message = message {
                FavorText(text: message, textColor: .appLightBlack, fontType: .regular, fontSize: 16)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            HStack(spacing: 16) {
                FavorButton(text: primaryButtonLabel, width: .infinity, height: 60, textColor: .appPrimaryColor, fontType: .bold, fontSize: 16,  bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
                    self.primaryButtonAction()
                }
                .padding(16)
                if let secondaryButtonLabel = secondaryButtonLabel {
                    FavorButton(text: secondaryButtonLabel, width: .infinity, height: 60, textColor: .appPrimaryColor, fontType: .bold, fontSize: 16,  bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
                        self.secondaryButtonAction?()
                    }

                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
    
}
struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertView(title: "Success!", message: "Your profile was updated successfully.", primaryButtonLabel: "ok", primaryButtonAction: {})
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
