//
//  MyEqualWidthVStack.swift
//  CustomLayout
//
//  Created by sakiyamaK on 2025/09/28.
//

import SwiftUI

struct MyEqualWidthVStack: Layout {


    /*
     子Viewたちを表示する領域を決める

     proposal: ProposedViewSize
     親Viewから子Viewに伝える表示可能領域の大きさ

     subviews: Subviews
     子Viewたちをもつ型でRandomAccessCollectionに準拠しているため、配列みたいなもの
     内部でレイアウトを決めるためのパラメータやメソッドを持つ

     cache: inout Void
     複雑な計算をキャッシュさせたいならこれを使う
     */
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Void
    ) -> CGSize {
        if !subviews.isEmpty {
            print(proposal)
            let maxSize = subviews.maxSize
            print(maxSize)
            return CGSize(
                width: maxSize.width,
                height: maxSize.height  * CGFloat(subviews.count) + subviews.spacings(along: .vertical).reduce(.zero, +)
            )
        } else {
            return .zero
        }
    }

    /*
     子ViewたちをsizeThatFitsで決まった領域内のどこに表示するか決めるメソッド

     in bounds: CGRect
     sizeThatFitsで決まった領域

     proposal: ProposedViewSize
     sizeThatFitsのproposalと同じ

     subviews: Subviews
     sizeThatFitsのsubviewsと同じ

     cache: inout Void
     複雑な計算をキャッシュさせたいならこれを使う
     */
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Void
    ) {

        guard !subviews.isEmpty else { return }
        /*
         suviews[0]の初期値

         minYが0とは限らない
         後ほど出てくるanchorがcenterを指定しているので
         上半分の表示領域のmaxSize.height / 2を指定
         */

        var y = bounds.minY + subviews.maxSize.height / 2

        for index in subviews.indices {
            /*
             subviewをどこに配置するか決めるメソッド
             at 座標を指定
             anchor atの座標にsubviewのどこを配置するのか決める、デフォで左上のtopLeading
             proposal 表示可能領域の提案サイズ
             */

            subviews[index].place(
                at: CGPoint(x: bounds.midX, y: y),
                anchor: .center,
                proposal: subviews.maxSize.proposedViewSize
            )
            y += subviews.maxSize.height + subviews.spacings(along: .vertical)[index]
        }
    }
}

