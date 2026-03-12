//
//  ContentView.swift
//  Calculator
//
//  Created by Тема on 11.03.2026.
//

import SwiftUI

struct ContentView: View {
    @State var result: String = ""
    var body: some View {
     
            VStack{
                textField
            }
      
    }
    
    var textField : some View {
        Text(result)
            .font(.headline)
            .frame(
                maxWidth: .infinity,
                maxHeight: 50,
                alignment: .trailing)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 1)
            )
    }
}

#Preview {
    ContentView()
}
