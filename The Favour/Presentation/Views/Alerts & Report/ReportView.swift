//
//  ReportView.swift
//  The Favour
//
//  Created by Atta khan on 28/04/2023.
//

import SwiftUI

struct ReportView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            NavigationBarView(text: "Report Favor")
            ReportCardView(title: "Fraud")
            ReportCardView(title: "Offensive Content")
            ReportCardView(title: "Duplicate Favor")
            ReportCardView(title: "Other")
            
            
            FavorButton(text: "Report Favor", width: .infinity, height: 44, bgColor: .appPrimaryColor) {
                
            }
            FavorButton(text: "Cancel", width: .infinity, height: 44, textColor: .appPrimaryColor, bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
            }
            
            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
        .navigationTitle("")
        
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}
