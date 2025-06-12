//
//  DrawRectView.swift
//  SamplePath
//
//  Created by sakiyamaK on 2025/05/25.
//

import SwiftUI

// 色々な図形

struct DrawOthersView: View {

    var body: some View {
        ScrollView {
            VStack {
                Path { path in
                     // 四角形
                    path.addRect(CGRect(x: 0, y: 0, width: 100, height: 100))
                }
                .stroke(Color.black, lineWidth: 1)
                .fill(Color.red)
                .border(Color.gray.opacity(0.3))
                .frame(height: 200)


                Path { path in
                    // 円(楕円)
                    path.addEllipse(in: CGRect(x: 0, y: 0, width: 100, height: 100))

                    path.addEllipse(in: CGRect(x: 200, y: 0, width: 100, height: 100))

                }
                .stroke(Color.black, lineWidth: 1)
                .fill(Color.red)
                .border(Color.gray.opacity(0.3))
                .frame(height: 200)

                Path { path in

                    let center = CGPoint(x: 100, y: 100)

                    path.move(to: center)

                    path.addArc(
                        center: center, // 円の中心
                        radius: 80, // 円の半径
                        startAngle: .degrees(0), // 右方向
                        endAngle: .degrees(45), // 時計回りに方向
                        clockwise: true // 時計回りに描画
                    )

                    path.closeSubpath()

                }
                .stroke(Color.black, lineWidth: 1)
                .fill(Color.red)
                .border(Color.gray.opacity(0.3))
                .frame(height: 200)
            }
        }
        .padding()
    }
}

#Preview {
    DrawOthersView()
}
