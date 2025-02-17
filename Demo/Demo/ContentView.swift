//
//  ContentView.swift
//  Demo
//
//  Created by Yuki Kuwashima on 2025/02/14.
//

import SwiftUI
import TransformUtils

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
