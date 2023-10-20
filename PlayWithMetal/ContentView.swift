//
//  ContentView.swift
//  PlayWithMetal
//
//  Created by Łukasz Dziedzic on 20/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MetalView()
            Text("Hello, world!")
        }
        .padding(0)
    }
}

#Preview {
    ContentView()
}
