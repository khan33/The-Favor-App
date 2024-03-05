//
//  OTPTextView.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI



import DPOTPView

struct OTPTextView: UIViewRepresentable {
    
    let textOTPView = DPOTPView()
    
    func makeUIView(context: Context) -> DPOTPView {
        textOTPView.count = 4
        textOTPView.spacing = 12
//        textOTPView.fontTextField = UIFont(.sy)
        textOTPView.dismissOnLastEntry = true
        textOTPView.borderColorTextField = UIColor(Color.appLightGrey)
        textOTPView.selectedBorderColorTextField = UIColor(Color.appLightGrey)
        textOTPView.borderWidthTextField = 1
        textOTPView.backGroundColorTextField = UIColor(Color.appWhite)
        textOTPView.cornerRadiusTextField = 12
        textOTPView.isCursorHidden = false
        textOTPView.shadowColorTextField = UIColor(Color.appLightBlack)
        textOTPView.shadowRadiusTextField = 6
        textOTPView.shadowOpacityTextField = 0.2
        textOTPView.shadowOffsetSizeTextField = CGSize(width: 0, height: 0)
        textOTPView.tintColor = UIColor(Color.appBlack)
        return textOTPView
    }
    
    func updateUIView(_ uiView: DPOTPView, context: Context) { }
}


struct OTPTextView_Previews: PreviewProvider {
    static var previews: some View {
        OTPTextView()
    }
}
