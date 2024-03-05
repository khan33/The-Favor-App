//
//  PageView.swift
//  The Favour
//
//  Created by Atta khan on 05/04/2023.
//

import SwiftUI

struct PageView: View {
    var page: Page
    var body: some View {
        VStack(spacing: 20) {
            Image("\(page.imageUrl)")
                .resizable()
                .scaledToFit()
                .padding(.vertical, 80)
            FavorText(text: page.description, textColor: .appBlack, fontType: .bold, fontSize: 38, alignment: .center, lineSpace: 0)
                .padding(.bottom, 24)
            Spacer()
            
        }
        .padding(.horizontal, 24)
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(page: Page.samplePage3)
    }
}
