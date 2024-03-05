//
//  ServicesView.swift
//  The Favour
//
//  Created by Atta khan on 05/05/2023.
//

import SwiftUI

struct ServicesView: View {
    var image: String = "cleaning"
    var name: String = "Cleaning"
    var color: Color = .appPrimaryColor
    
    var service: ServiceModelData?
    var action: (() -> Void)?
    
    var body: some View {
        VStack {
            VStack {
                AsyncImage(url: URL(string: service?.icon ?? "")) { image in
                        image
                        .resizable()
                        .frame(width: 22, height: 22)

                    } placeholder: {
                        Image(image)
                            .resizable()
                            .frame(width: 22, height: 22)
                    }
            }
            .overlay(
                Circle()
                    .fill(Color(hex: service?.color ?? "000000"))
                    .opacity(0.1)
                    .frame(width: 60, height: 60)
            )
            .frame(width: 70, height: 70)
            
            FavorText(text: service?.name ?? name, textColor: Color(#colorLiteral(red: 0.26, green: 0.26, blue: 0.26, alpha: 1)), fontType: .bold, fontSize: 16, alignment: .center, lineSpace: 0)
        }
        .onTapGesture {
            action?()
        }
    }
}

struct ServicesView_Previews: PreviewProvider {
    static var previews: some View {
        ServicesView()
    }
}
