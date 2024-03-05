//
//  TextViewWrapper.swift
//  The Favour
//
//  Created by Atta khan on 26/07/2023.
//

import Foundation
import SwiftUI

struct TextViewWrapper: UIViewRepresentable {
    @Binding var text: String
    var hasText: Bool = false
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.backgroundColor = .clear
        textView.text = "Description"
        textView.textColor = UIColor(red: 199 / 255, green: 199 / 255, blue: 205 / 255, alpha: 1)
        textView.font = UIFont(name: "Urbanist-Regular", size: 14)
        textView.returnKeyType = .done
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if !uiView.isFirstResponder  && uiView.text.isEmpty{
            uiView.text = "Description"
            uiView.textColor = UIColor(red: 199 / 255, green: 199 / 255, blue: 205 / 255, alpha: 1)
        } else {
            uiView.text = text
            uiView.textColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)
        }
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextViewWrapper
        
        init(_ textViewWrapper: TextViewWrapper) {
            parent = textViewWrapper
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            textView.textColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)
        }
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == "Description" {
                textView.text = ""
                textView.textColor = .black
            }
        }
    }
}
