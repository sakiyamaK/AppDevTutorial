//
//  DrawCurveView.swift
//  SamplePath
//
//  Created by sakiyamaK on 2025/05/25.
//

import SwiftUI

// 色々な図形

struct DrawCurveView: View {

    var body: some View {
        ScrollView {
            VStack {
                Path { path in
                    // 二次ベジェ曲線

                    //始点
                    path.move(to: CGPoint(x: 50, y: 150))

                    path.addQuadCurve(
                        // 終点
                        to: CGPoint(x: 250, y: 150),
                        // 制御点
                        control: CGPoint(x: 150, y: 50)
                    )
                }
                .stroke(Color.black, lineWidth: 1)
                .border(Color.gray.opacity(0.3))
                .frame(height: 200)


                Path { path in
                    path.move(to: CGPoint(x: 50, y: 50))

                    path.addQuadCurve(
                        to: CGPoint(x: 150, y: 150),
                        control: CGPoint(x: 40, y: 100)
                    )

                    path.addQuadCurve(
                        to: CGPoint(x: 250, y: 50),
                        control: CGPoint(x: 200, y: 10)
                    )
                }
                .stroke(Color.black, lineWidth: 1)
                .border(Color.gray.opacity(0.3))
                .frame(height: 200)

                Path { path in

                    // 三次ベジェ曲線

                    path.move(to: CGPoint(x: 50, y: 150))

                    path.addCurve(
                        to: CGPoint(x: 250, y: 150),
                        control1: CGPoint(x: 100, y: 50),
                        control2: CGPoint(x: 200, y: 200)
                    )

                }
                .stroke(Color.black, lineWidth: 1)
                .border(Color.gray.opacity(0.3))
                .frame(height: 200)
            }
        }
        .padding()
    }
}

#Preview {
    DrawCurveView()
}
