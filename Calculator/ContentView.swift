//
//  ContentView.swift
//  Calculator
//
//  Created by Тема on 11.03.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var text: String = "Hello, world!"
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(text)
        }
        .padding()
        buttonEditText // ad this one
        Spacer()
        
    }
    var buttonEditText: some View { //add button here
        Button {
            text = "Good bye world!"
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 120, height: 60)
                .foregroundColor(.blue)
                .shadow(radius: 10)
                
                .overlay(
                    Text("Good bye world!")
                        .foregroundStyle(.white)
                )
        }
    }
}

#Preview {
    ContentView()
}
