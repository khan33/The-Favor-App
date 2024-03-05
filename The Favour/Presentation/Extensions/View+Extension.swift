//
//  View+Extension.swift
//  The Favour
//
//  Created by Atta khan on 16/04/2023.
//

import SwiftUI

extension View {
    func border(_ color: Color, width: CGFloat, cornerRadius: CGFloat) -> some View {
        overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(color, lineWidth: width))
    }
    func spinner(isShowing: Binding<Bool>) -> some View {
        self.modifier( FavorSpinnerView(isShowing: isShowing) )
    }

    
    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
    
}
