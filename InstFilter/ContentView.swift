//
//  ContentView.swift
//  InstFilter
//
//  Created by Zi on 30/07/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        Text("Hello World")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                showingConfirmation = true
            }
            .confirmationDialog("Change Background", isPresented: $showingConfirmation) {
                Button("Red"){backgroundColor = .red}
                Button("Green"){backgroundColor = .green}
                Button("Blue"){backgroundColor = .blue}
                Button("Cancel", role: .cancel){}
            } message: {
                Text("Select a new color")
            }
    }
}

#Preview {
    ContentView()
}
