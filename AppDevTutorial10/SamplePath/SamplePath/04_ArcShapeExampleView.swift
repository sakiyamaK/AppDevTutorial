//
//  ShapeView.swift
//  SamplePath
//
//  Created by sakiyamaK on 2025/05/25.
//
import SwiftUI

struct ArcShape: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool

    /*
     Shapeはpath(in rect: CGRect)メソッドを実装する必要がある

     この段階で自身の描画サイズのrectが取得できるので、
     「自身の半分の大きさで弧を描く」みたいな大きさに応じた記述がやりやすくなる
     そうすることでPathを直接描いていくよりレイアウト崩れが起きづらいため、色んな画面で再利用もしやすい
     */
    func path(in rect: CGRect) -> Path {

        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        return Path { path in
            // パスを描画
            path.addArc(center: center,
                        radius: radius,
                        startAngle: startAngle,
                        endAngle: endAngle,
                        clockwise: clockwise)
        }
    }
}

struct ArcShapeExampleView: View {
    @State private var progress: Double = 0.75
    @State private var startAngle: Double = -90.0

    var body: some View {
        VStack(spacing: 40) {

            ArcShape(
                startAngle: .degrees(
                    startAngle
                ),
                endAngle: .degrees(
                    startAngle + progress * 360
                ),
                clockwise: false
            ).stroke(Color.blue, lineWidth: 15)
                .padding()

            VStack {
                Text("進捗率: \(Int(progress * 100))%")
                Slider(value: $progress, in: 0...1.0)
                    .tint(.blue)
            }
            .padding(.horizontal)

            VStack {
                Text("開始角度: \(Int(startAngle))°")
                Slider(value: $startAngle, in: -180...180)
                    .tint(.red)
            }
            .padding(.horizontal)
        }
        .padding()
        .navigationTitle("Shape: Arc")
    }
}

#Preview {
    ArcShapeExampleView()
}
