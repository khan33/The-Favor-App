//
//  DistanceSliderView.swift
//  The Favour
//
//  Created by Atta khan on 05/05/2023.
//

import SwiftUI

struct DistanceSliderView: View {
    @Binding var sliderValue: Double
    @State var showValueBalloon    = false
    var maxValue                   = 100.0
    private var percentOfScale: Double       { sliderValue / maxValue }
    private var isPastHalfWayPoint: Bool     { sliderValue / maxValue > 0.49}
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            FavorText(text: "Location", textColor: .appTitleBlack , fontType: .bold, fontSize: 20, alignment: .leading, lineSpace: 0)

            ZStack(alignment: .leading) {
                GeometryReader { geo in // capture the geometry of these two views
                    ValueBalloon(value: $sliderValue)
                        .animation(.default, value: isPastHalfWayPoint)
                        //.opacity(showValueBalloon ? 1.0 : 0.0)
                        .offset(x: (geo.size.width * percentOfScale - (isPastHalfWayPoint ? 4.0 : 5.0) ), y: -30)
                    Slider(value: $sliderValue,
                           in: 0...maxValue,
                           onEditingChanged: { isEditing in showValueBalloon = isEditing })
                    .tint(Color.appPrimaryColor)
                }
            }.frame(height: 48)
        }
    }
}

// Simple balloon view
struct ValueBalloon: View {
    @Binding var value: Double
    @State var frameWidth = 48.0
    @State var frameHeight = 20.0
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4).foregroundColor(.appPrimaryColor)
            Triangle2().frame(width: 20, height: 12).foregroundColor(.appPrimaryColor).offset(x: 0, y: 12)
            Text("\(value, specifier: "%.0f") m").fontWeight(.bold).foregroundColor(.white).font(.caption)
        }
        .frame(width: frameWidth, height: frameHeight)
    }

}

struct Triangle2: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + 1, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - 1, y: rect.minY))

    return path
    }
}
