//
//  RangeSlider.swift
//  The Favour
//
//  Created by Atta khan on 04/10/2023.
//

import Foundation
import SwiftUI

struct RangeSlider: View {
    
    @State var width: CGFloat = 0
    @State var widthTow: CGFloat = 15
    let offsetValue: CGFloat = 40
    @State var isDraggingLeft: Bool = false
    @State var isDraggingRight: Bool = false
    @State var totalScreen: CGFloat = 0
    let maxValue: CGFloat = 1000
    
    var lowerValue: Int {
        Int(map(value: width, from: 0...totalScreen, to: 0...maxValue))
    }
    
    var upperValue: Int {
        Int(map(value: widthTow, from: 0...totalScreen, to: 0...maxValue))

    }
    
    
    
    var body: some View {
        ZStack {
            Color.red.opacity(0.1)
            GeometryReader { geometry in
                VStack(spacing: 30) {
                    Text("$ \(lowerValue) - $ \(upperValue)").bold()
                        .foregroundStyle(Color.appPrimaryColor)
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10).foregroundStyle(.gray)
                            .opacity(0.3)
                            .frame(height: 6)
                            .padding(.horizontal, 6)
                        Rectangle().foregroundStyle(Color.appPrimaryColor)
                            .frame(width: widthTow - width, height: 6)
                            .offset(x: width + 20)
                        
                        HStack(spacing: 0) {
                            DraggableCircle(isLeft: true, isDragging: $isDraggingLeft, position: $width, otherPosition: $widthTow, limit: totalScreen)
                            
                            DraggableCircle(isLeft: false, isDragging: $isDraggingRight, position: $widthTow, otherPosition: $width, limit: totalScreen)
                        }
                        ValueBox(isDragging: isDraggingLeft, value: lowerValue, position: width, xoffset: -18)
                        ValueBox(isDragging: isDraggingRight, value: upperValue, position: widthTow, xoffset: 0)
                    }
                    .offset(y: 8)
                }
                .frame(width: geometry.size.width, height: 130)
                .onAppear {
                    totalScreen = geometry.size.width - offsetValue
                }
            }
            .frame(height: 130)
            .padding(.horizontal, 30)
            .background(.white, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            .padding(.horizontal, 10)
            .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 0)
        }
        .ignoresSafeArea()
    }
    
    func map(value: CGFloat, from: ClosedRange<CGFloat>, to: ClosedRange<CGFloat>) -> CGFloat {
        let inputRange = from.upperBound - from.lowerBound
        guard inputRange != 0 else { return 0 }
        let outputRange = to.upperBound - to.lowerBound
        return (value - from.lowerBound) / inputRange * outputRange + to.lowerBound
        
    }
    
    
    
    
}






struct ValueBox: View {
    var isDragging: Bool
    var value: Int
    var position: CGFloat
    var xoffset: CGFloat
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .frame(width: 60, height: 40)
                .foregroundStyle(isDragging ? .black : .clear)
                Text("$\(value)")
                .foregroundStyle(isDragging ? .white : .clear)
        }
        .scaleEffect(isDragging ? 1 : 0)
        .offset(x: position + xoffset , y: isDragging ? -40 : 0)
    }
}


struct DraggableCircle: View {
    var isLeft: Bool
    @Binding var isDragging: Bool
    @Binding var position: CGFloat
    @Binding var otherPosition: CGFloat
    var limit: CGFloat
    
    var body: some View {
        ZStack {
            Circle().frame(width: 25, height: 25).foregroundStyle(Color.appPrimaryColor)
            Circle().frame(width: 15, height: 15).foregroundStyle(Color.appWhite)
        }
        .offset(x: position + (isLeft ? 0 : -5 ))
        .gesture (
            DragGesture()
                .onChanged ({ value in
                    withAnimation {
                        isDragging = true
                    }
                    if isLeft {
                        position = min(max(value.location.x, 0), otherPosition)
                    } else {
                        position = min(max(value.location.x, otherPosition), limit)
                    }
                })
                .onEnded({ value in
                    withAnimation {
                        isDragging = false
                    }
                })
        )
    }
}
