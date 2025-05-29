//
//  SpeakerArc.swift
//  AppDevTutorial10
//
//  Created by sakiyamaK on 2025/05/25.
//

/*
 **** 解説 ****
 新規追加ファイル

 */

import SwiftUI

struct SpeakerArc: Shape {
    let speakerIndex: Int
    let totalSpeakers: Int

    private var degreesPerSpeaker: Double {
        // Int.doubleValueはExtensions/Int+.swiftで拡張した書き方を定義してる
        360.0 / totalSpeakers.doubleValue
    }
    private var startAngle: Angle {
        Angle(degrees: degreesPerSpeaker * speakerIndex.doubleValue + 1.0)
    }
    private var endAngle: Angle {
        Angle(degrees: startAngle.degrees + degreesPerSpeaker - 1.0)
    }

    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height) - 24.0
        let radius = diameter / 2.0
        let center = CGPoint(x: rect.midX, y: rect.midY)
        return Path { path in
            path.addArc(
                center: center,
                radius: radius,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: false
            )
        }
    }
}

// MARK: - カスタムShape: SmileShape
struct SmileShape: Shape {
    var isSmiling: Bool // アニメーションのプロパティ

    // isSmiling の変化をスムーズにするための animatableData
    var animatableData: Double {
        get { isSmiling ? 1.0 : 0.0 }
        set { isSmiling = newValue > 0.5 }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2 * 0.8 // 顔の半径

        // 顔の輪郭（円）
        path.addArc(center: center, radius: radius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)

        // 目 (左)
        let eyeSize = radius * 0.15
        path.addEllipse(in: CGRect(x: center.x - radius * 0.4 - eyeSize / 2,
                                   y: center.y - radius * 0.3 - eyeSize / 2,
                                   width: eyeSize, height: eyeSize))

        // 目 (右)
        path.addEllipse(in: CGRect(x: center.x + radius * 0.4 - eyeSize / 2,
                                   y: center.y - radius * 0.3 - eyeSize / 2,
                                   width: eyeSize, height: eyeSize))

        // 口 (isSmiling の値で変化)
        let mouthWidth = radius * 0.6
        let mouthControlOffset = radius * 0.3 // 口のカーブの制御点オフセット

        // 口の開始点と終了点
        let mouthStartX = center.x - mouthWidth / 2
        let mouthEndX = center.x + mouthWidth / 2
        let mouthY = center.y + radius * 0.3

        path.move(to: CGPoint(x: mouthStartX, y: mouthY))

        // 笑顔 (isSmiling = true) の場合は上にカーブ
        // 悲しい顔 (isSmiling = false) の場合は下にカーブ
        let controlPointY = mouthY + (isSmiling ? -mouthControlOffset : mouthControlOffset)

        path.addQuadCurve(to: CGPoint(x: mouthEndX, y: mouthY),
                          control: CGPoint(x: center.x, y: controlPointY))

        return path
    }
}

#Preview {
    SmileShape(isSmiling: true)
}
