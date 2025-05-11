/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

struct CardView: View {

    let scrum: DailyScrum

    var body: some View {
        VStack(alignment: .leading) {
            Text(scrum.title)
                .font(.headline)

            Spacer()

            HStack {

                Label("\(scrum.attendees.count)", systemImage: "person.3")

                Spacer()

                Label("\(scrum.lengthInMinutes)", systemImage: "clock")
//                    .labelStyle(.trailingIcon)

                /*
                 ********** 解説 **********
                 protocolにstaticを増やすやり方とか難しいこと考えなくていいなら、素直にこう書けばいい

                 */
//                Label("\(scrum.lengthInMinutes)", systemImage: "clock")
//                    .labelStyle(TrailingIconLabelStyle())
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
    }
}

// 新しい書き方でのサイズの指定方法
#Preview(traits: .fixedLayout(width: 150, height: 60)) {

    let scrum = DailyScrum.sampleData[0]
    CardView(scrum: scrum)
        .background(scrum.theme.mainColor)
}
