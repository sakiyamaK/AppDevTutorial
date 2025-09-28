//
//  LayoutSubviews+.swift
//  CustomLayout
//
//  Created by sakiyamaK on 2025/09/28.
//

import SwiftUI

extension LayoutSubviews {

    var maxSize: CGSize {
        // Subviews自身がRandomAccessCollectionに準拠しているので配列操作関数が使える
        self.map {
            /*
             Subviews自身にsizeThatFitsが定義されている
             パラメータでsubviewsの要素の大きさの種類を指定できる
             unspecifiedは指定しない(デフォルト)
             infinityは最大サイズ
             zeroは最小サイズ
             */
            $0.sizeThatFits(.unspecified)
        }.reduce(.zero) { currentMax, subviewSize in
            /*
             最大の幅と高さを求める
             reduceだけど統計量を出すわけではない
             */
            CGSize(
                width: Swift.max(currentMax.width, subviewSize.width),
                height: Swift.max(currentMax.height, subviewSize.height))
        }
    }

    func spacings(along: Axis) -> [CGFloat] {
        self.indices.map { index in
            if index < self.count - 1 {
                /*
                 spacingはViewSpacing型でsubviewsの要素間の色々な距離を測れるメソッドをもつ
                 to で、測定対象のViewSpacingを指定
                 along で、方向を指定
                 */
                self[index].spacing.distance(
                    to: self[index + 1].spacing,
                    along: along)
            } else {
                0
            }
        }
    }
}
