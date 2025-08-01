//
//  ContentView.swift
//  appIos
//
//  Created by Josh on 12/27/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Momentum")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Productivity App")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
