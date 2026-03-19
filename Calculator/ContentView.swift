//
//  ContentView.swift
//  Calculator
//
//  Created by Тема on 11.03.2026.
//

import SwiftUI

struct ContentView: View {
    @State var result : String = "0"
    @State var activeOperator: String = ""
    @State var expression : String = "0"
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    let mainButtons: [[CalculatorButton]] = [
        [.clear, .squareRoot, .exponent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.history, .zero, .decimal, .calculate],
        [.openBracket, .closeBracket]
    ]
    
    var body: some View {
        
        VStack(){
            resultField
            textField
                .padding(.bottom)
            ForEach(mainButtons, id: \.self) { row in
                LazyVGrid(columns: columns) {
                    ForEach(row, id: \.self){ button in
                        calculatorButtonRepresentation(
                            button: button,
                            action: {
                                calculatorDidTap(button: button,
                                                 activeOperation: $activeOperator,
                                                 result: $result,
                                                 expression: $expression)
                            }
                        )
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
        //        Text("\(activeOperator) \(currentInput)  ")
        Text(expression)
            .font(.title)
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
}// ContentView end



#Preview {
    ContentView()
}

