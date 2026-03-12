//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Тема on 12.03.2026.
//

import SwiftUI


enum CalculatorButton: CaseIterable {
    case clear, history, squareRoot, exponent, divide, multiply, subtract, add, calculate, decimal
    case zero, one, two, three, four, five, six, seven, eight, nine
    
    var title: String {
        switch self {
        case .clear: return "AC"
        case .history: return "🕒"
        case .squareRoot: return "√"
        case .exponent: return "xⁿ"
        case .divide: return "÷"
        case .multiply: return "×"
        case .subtract: return "−"
        case .add: return "+"
        case .calculate: return "="
        case .decimal: return ","
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        }
        
        
    }
    @ViewBuilder
    var labelView: some View {
        switch self {
            //                case .squareRoot:
            //                    Image(systemName: "square.root")
        case .history:
            Image(systemName: "clock.arrow.circlepath")
            //                case .exponent:
            //                    Text("xⁿ")
        default:
            Text(self.title)
        }
    }
    
    
    
}
func calculatorButtonRepresentation(_ button: CalculatorButton) -> some View {
    Button(action: {
        print("Tapped on: \(button)")
    }) {
        button.labelView
                .font(.title)
                .frame(width: 80, height: 80)
                .background(Color.orange)
                .foregroundColor(Color.white)
                .clipShape(Circle())
    }
}
