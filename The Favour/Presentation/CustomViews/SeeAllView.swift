//
//  SeeAllView.swift
//  The Favour
//
//  Created by Atta khan on 05/05/2023.
//

import SwiftUI

struct SeeAllView: View {
    var label1: String = ""
    var label2: String = ""
    var action: (() -> Void)? = nil
    
    
    
    //(() -> Void)? = nil
    var body: some View {
        HStack {
            FavorText(text: label1, textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .bold, fontSize: 20, alignment: .center, lineSpace: 0)
            Spacer()
            FavorText(text: label2, textColor: Color(#colorLiteral(red: 0.45, green: 0.06, blue: 1, alpha: 1)), fontType: .bold, fontSize: 16, alignment: .center, lineSpace: 0)
                .onTapGesture {
                    action?()
                }
        }
    }
}

struct SeeAllView_Previews: PreviewProvider {
    static var previews: some View {
        SeeAllView(label1: "Services", label2: "See All")
    }
}
