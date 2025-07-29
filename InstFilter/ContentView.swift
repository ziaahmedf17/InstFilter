//
//  ContentView.swift
//  InstFilter
//
//  Created by Zi on 30/07/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var blurAmount = 0.0
    
    var body: some View {
        VStack{
            Text("Hello Worl")
                .blur(radius: blurAmount)
            Slider(value: $blurAmount,in: 0...20)
                .onChange(of: blurAmount){ newValue in
                    print("New Value is: \(blurAmount)")
                
            }
            
            Button("Random Blur")
            {
                blurAmount = Double.random(in: 0...20)
            }
        }
    }
}

#Preview {
    ContentView()
}
