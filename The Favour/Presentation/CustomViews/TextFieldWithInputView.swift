//
//  TextFieldWithInputView.swift
//  The Favour
//
//  Created by Atta khan on 26/07/2023.
//

import Foundation
import SwiftUI

struct TextFieldWithInputView : UIViewRepresentable {
    @ObservedObject var viewModel: FavorViewModel
    var placeholder : String
    @Binding var selectedData : ServiceModelData?

    private let textField = UITextField()
    private let picker = UIPickerView()
    

    func makeCoordinator() -> TextFieldWithInputView.Coordinator {
        Coordinator(parent: self)

    }

    func makeUIView(context: UIViewRepresentableContext<TextFieldWithInputView>) -> UITextField {
        picker.delegate = context.coordinator
        picker.dataSource = context.coordinator
        picker.backgroundColor = .lightGray
        picker.tintColor = .black
        textField.placeholder = placeholder
        textField.isUserInteractionEnabled = true // Allow user interaction
        textField.isEnabled = false // Disable editing within UITextField
        textField.inputView = picker
        textField.textColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)
        textField.font = UIFont(name: "Urbanist-Regular", size: 14)
        
        textField.delegate = context.coordinator
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<TextFieldWithInputView>) {
        uiView.text = selectedData?.name
    }

    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate , UITextFieldDelegate {
        private let parent : TextFieldWithInputView
        
        
        init(parent: TextFieldWithInputView) {
            self.parent = parent
        }

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return self.parent.viewModel.services?.count ?? 0
        }
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return self.parent.viewModel.services?[row].name
        }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            self.parent.selectedData = self.parent.viewModel.services?[row]
            self.parent.textField.endEditing(true)

        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            self.parent.textField.resignFirstResponder()
        }
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            return false
        }
        
    }
}
