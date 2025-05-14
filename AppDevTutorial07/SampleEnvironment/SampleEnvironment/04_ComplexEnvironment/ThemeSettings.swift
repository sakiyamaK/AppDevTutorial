//
//  ThemeSettings.swift
//  SampleEnvironment
//
//  Created by sakiyamaK on 2025/05/14.
//

import SwiftUI
import Observation

/*
 ********** 解説 **********
 自前で「更新可能」な環境変数を用意する場合
iOS17から使えるObservationを使う場合

 1. 更新させるデータ構造を用意して
 2. EnvironmentKeyに準拠した自分用のKeyを用意して
 3. EnvironmentValuesを拡張して呼び出す
 */

// 1. 更新させるデータ構造を用意して
@Observable
class ThemeSettings {
    /*
     ********** 解説 **********
     setだけprivate
     つまり外からアクセスできるが更新はできない
     */
    private(set) var fontSize: CGFloat
    private(set) var accentColor: Color

    func toggleAccentColor() {
        accentColor = accentColor == .blue ? .red : .blue
    }

    func updateFontSize() {
        fontSize += 5
    }

    init(fontSize: CGFloat = 18, accentColor: Color = .blue) {
        self.fontSize = fontSize
        self.accentColor = accentColor
    }
}
