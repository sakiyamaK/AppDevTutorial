//
//  DrawLineView.swift
//  SamplePath
//
//  Created by sakiyamaK on 2025/05/25.
//

import SwiftUI

// 線を引く

struct DrawLineView: View {

    var body: some View {
        ScrollView {
            VStack {

                Path { path in

                    /*
                     二点を結ぶ線を引く

                     ただし、「線を引く」という概念的なことだけを指定したので
                     まだ色も太さも指定していなくてこれだけだと透明で細さが0の線を引くだけ
                     紙の上を指でなぞっただけのような感覚

                     strokeで色と太さを指定して初めて「見える線を引く」
                     */
                    path.addLines(
                        [
                            CGPoint(
                                x: 0,
                                y: 0
                            ),
                            CGPoint(
                                x: 100,
                                y: 100
                            ),
                            CGPoint(
                                x: 150,
                                y: 130
                            )
                         ]
                    )
                }
                .stroke(Color.black, lineWidth: 1)
                .border(Color.gray.opacity(0.3))
                .frame(height: 200)


                Path { path in
                    /*
                     三点を結ぶ線を引く

                     fillを指定すると始点と終点を結んで勝手に閉じた図形と判断して色を塗る
                     */
                    path.addLines(
                        [
                            CGPoint(
                                x: 0,
                                y: 0
                            ),
                            CGPoint(
                                x: 100,
                                y: 0
                            ),
                            CGPoint(
                                x: 50,
                                y: 100
                            )
                        ]
                    )
                }
                .stroke(Color.black, lineWidth: 1)
                .fill(Color.red)
                .border(Color.gray.opacity(0.3))
                .frame(height: 200)

                Path { path in
                    /*
                     四点を結ぶ線を引く

                     始点と終点が同じだが概念として閉じているわけではない
                     コンピュータには目がないので、基本は図形が閉じてるかどうかは分からないと思えば良い
                     だけどSwiftUIは賢いから閉じたと判断していたりする...
                     */
                    path.addLines(
                        [
                            CGPoint(
                                x: 0,
                                y: 0
                            ),
                            CGPoint(
                                x: 100,
                                y: 0
                            ),
                            CGPoint(
                                x: 50,
                                y: 100
                            ),
                            CGPoint(
                                x: 0,
                                y: 0
                            )
                        ]
                    )
                }
                .stroke(Color.black, lineWidth: 1)
                .fill(Color.red)
                .border(Color.gray.opacity(0.3))
                .frame(height: 200)

                Path { path in
                    /*
                     三点を結ぶ線を引く

                     closeSubpath()で明確に閉じろと指定している
                     */
                    path.addLines(
                        [
                            CGPoint(
                                x: 0,
                                y: 0
                            ),
                            CGPoint(
                                x: 100,
                                y: 0
                            ),
                            CGPoint(
                                x: 50,
                                y: 100
                            )
                        ]
                    )

                    path.closeSubpath()
                }
                .stroke(Color.black, lineWidth: 1)
                .fill(Color.red)
                .border(Color.gray.opacity(0.3))
                .frame(height: 200)

                Path { path in
                    // ペンを移動させるイメージ
                    path.move(
                        to: CGPoint(
                            x: 0,
                            y: 0
                        )
                    )
                    path.addLine(
                        to: CGPoint(
                            x: 100,
                            y: 0
                        )
                    )
                    path.addLine(
                        to: CGPoint(
                            x: 50,
                            y: 100
                        )
                    )
                    path.closeSubpath()

                    // ペンを移動させるイメージ
                    path.move(
                        to: CGPoint(
                            x: 200,
                            y: 0
                        )
                    )
                    path.addLine(
                        to: CGPoint(
                            x: 300,
                            y: 0
                        )
                    )
                    path.addLine(
                        to: CGPoint(
                            x: 250,
                            y: 100
                        )
                    )
                    path.closeSubpath()
                }
                .stroke(Color.black, lineWidth: 1)
                .fill(Color.red)
                .frame(height: 200)
                .border(Color.gray.opacity(0.3))
            }
        }
        .padding()
    }
}

#Preview {
    DrawLineView()
}
