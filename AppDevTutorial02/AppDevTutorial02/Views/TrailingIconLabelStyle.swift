/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

/*
 ********** 解説 **********
 自前でこうしてLabelStyleを作ることもできる
 */
struct TrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

/*
 ********** 解説 **********
 protocolにstaticメンバーを増やす書き方

 trailingIconはSelf型を返すよ
 Self型とはTrailingIconLabelStyleのことだよ
 */

extension LabelStyle where Self == TrailingIconLabelStyle {
    static var trailingIcon: Self { Self() }
}
/*
 ********** 解説 **********
 なんでこう書けないんだろうね
 */
//extension LabelStyle {
//    static var trailingIcon: TrailingIconLabelStyle { TrailingIconLabelStyle() }
//}
