//
//  ContentView.swift
//  Calculator
//
//  Created by Тема on 11.03.2026.
//

import SwiftUI

struct ContentView: View {
    @State var result: String = ""

    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    let mainButtons: [[CalculatorButton]] = [
        [.clear, .squareRoot, .exponent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.history, .zero, .decimal, .calculate]
    ]
    
    var body: some View {
        
        VStack(){
            textField
                .padding(.bottom)
            ForEach(mainButtons, id: \.self) { row in
                LazyVGrid(columns: columns) {
                    ForEach(row, id: \.self){ button in
                        calculatorButtonRepresentation(button: button , textField: $result)
                    }
                }
            }
            
            
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
