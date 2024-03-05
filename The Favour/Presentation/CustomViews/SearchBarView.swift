//
//  SearchBarView.swift
//  The Favour
//
//  Created by Atta khan on 08/05/2023.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var filterAction: (() -> Void)?
    
    var body: some View {
        HStack {
            Image("Search")
            
            TextField("Search", text: $searchText)
                .textFieldStyle(PlainTextFieldStyle())
                .onSubmit {
                    filterAction?()
                }
            
            Image("fliter")
                .onTapGesture {
                    filterAction?()
                }
            
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 16)
        .background(Color.init(hex: "#F5F5F5"))
        .cornerRadius(8)
        
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
