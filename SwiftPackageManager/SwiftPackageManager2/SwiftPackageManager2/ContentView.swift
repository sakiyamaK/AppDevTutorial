//
//  ContentView.swift
//  SwiftPackageManager2
//
//  Created by sakiyamaK on 2025/06/12.
//

import SwiftUI
import Lottie

struct ContentView : View {
    var body: some View {
        LottieView(animation: .named("32921-volumn-from-mute-to-maximum.json"))
          .configure(\.contentMode, to: .scaleAspectFit)
          .looping()
          .frame(maxWidth: .infinity)
    }
}

#Preview {
    ContentView()
}
