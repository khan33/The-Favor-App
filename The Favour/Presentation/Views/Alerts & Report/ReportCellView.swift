//
//  ReportCardView.swift
//  The Favour
//
//  Created by Atta khan on 28/04/2023.
//

import SwiftUI

struct ReportCardView: View {
    @State var checked = false
    let title: String
    var body: some View {
        HStack(alignment: .top) {
            FavorText(text: title, textColor:  Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)) , fontType: .bold, fontSize: 16, alignment: .center, lineSpace: 0)
            Spacer()
            CheckBoxView(checked: $checked)

        }
        .padding(.vertical, 8)
        .cornerRadius(10)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
        
    }
}

struct ReportCardView_Previews: PreviewProvider {
    static var previews: some View {
        ReportCardView(title: "Fraud")
    }
}


struct CheckBoxView: View {
    @Binding var checked: Bool

    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .foregroundColor(checked ? .appPrimaryColor : Color.secondary)
            .onTapGesture {
                self.checked.toggle()
            }
    }
}
