//
//  ContentView.swift
//  Calculator
//
//  Created by Тема on 11.03.2026.
//

import SwiftUI

struct ContentView: View {
    @State var result : Double = 0
    @State var currentInput: String = ""
    @State var previousInput: String = ""
    @State var activeOperator: String = ""
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
            resultField
            textField
                .padding(.bottom)
            ForEach(mainButtons, id: \.self) { row in
                LazyVGrid(columns: columns) {
                    ForEach(row, id: \.self){ button in
                        calculatorButtonRepresentation(button: button , textField: $currentInput , previousInput: $previousInput , activeOperation: $activeOperator , result : $result)
                    }
                }
            }
            
            
        }
        
    }
    var resultField : some View {
        Text("\(result)")
            .font(.largeTitle)
            .frame(
                maxWidth: .infinity,
                maxHeight: 100,
            )
    }
    var textField : some View {
        Text("\(activeOperator) \(currentInput)  ")
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

