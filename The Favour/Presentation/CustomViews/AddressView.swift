//
//  AddressView.swift
//  The Favour
//
//  Created by Atta khan on 12/05/2023.
//

import SwiftUI

struct AddressView: View {
    let address: String
    var body: some View {
        HStack (alignment: .top){
            Image("map_icon")
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 16)
                .tint(Color.appPrimaryColor)
                .padding(.leading, 16)
            FavorText(text: address, textColor:  Color(red: 0.26, green: 0.26, blue: 0.26), fontType: .medium, fontSize: 14, alignment: .leading, lineSpace: 0)
                .lineLimit(2)
        }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(address: "255 Grand Park Avenue, New York" )
    }
}
