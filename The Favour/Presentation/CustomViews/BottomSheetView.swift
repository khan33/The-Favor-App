//
//  BottomSheetView.swift
//  The Favour
//
//  Created by Atta khan on 09/05/2023.
//

import SwiftUI



struct BottomSheet<SheetContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let content: () -> SheetContent
    
    func body(content: Content) -> some View {
        ZStack {
            
            content
            VStack {
                GeometryReader { _ in
                    EmptyView()
                }
                .background(Color.red.opacity(0.2))
                .opacity(isPresented ? 1 : 0)
                .animation(.easeIn)
                .onTapGesture {
                    isPresented.toggle()
                }
                GeometryReader { geometry in
                    self.content()
                        .frame(height: geometry.size.height - 20)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .offset(y: isPresented ? geometry.size.height / 2  : geometry.size.height)
                        .animation(.spring())
                }
            }
        }
        .onTapGesture {
            isPresented.toggle()
        }
    }
}




extension View {
    func customBottomSheet<SheetContent: View>(
        isPresented: Binding<Bool>,
        sheetContent: @escaping () -> SheetContent
    ) -> some View {
        self.modifier(BottomSheet(isPresented: isPresented, content: sheetContent))
    }
}
