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
        case .subtract: return "-"
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
    } // End Title
    
    var isNumber : Bool { //adding to group and easy work in didTap
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            return true
        default :
            return false
        }
        
    }
    
    var operation : String{
        switch self{
        case .add  ,.subtract:
            return self.title
        case .divide:
            return "/"
        case .multiply:
            return "*"
        default:
            return ""
        }
    }
    
    var buttonColor : Color{
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine , .decimal:
            return Color(.systemGray)
        case .add ,.divide ,.multiply ,.subtract, .calculate:
            return Color(.systemBlue)
        default:
            return Color(.systemGray).opacity(0.5)
            
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

/// Show buttons function
/// - Parameters:
///   - button: our element  from CalculatorButton enum
///   - textField: Text field of our Calculator
/// - Returns: Button with style and logic inside and
func calculatorButtonRepresentation(button: CalculatorButton, action : @escaping () -> Void) -> some View {
    Button(action: {
        print("Tapped on: \(button)")
        action()
    }) {
        button.labelView
            .font(.title)
            .frame(width: 80, height: 80)
            .background(button.buttonColor)
            .foregroundColor(Color.white)
            .clipShape(Circle())
    }
}


/// //Change textField by press.Logic of our button
/// - Parameters:
///   - button: button that we pressed from CalculatorButton enum
///   - currentInput: binding a text which we want to change
func calculatorDidTap(button: CalculatorButton,
                      currentInput: Binding<String> ,
                      previousInput: Binding<String> ,
                      activeOperation: Binding<String> ,
                      result: Binding<Double>){
    
    if button.isNumber {
        currentInput.wrappedValue += button.title
        print (previousInput)
    } else if !button.operation.isEmpty {
        previousInput.wrappedValue = currentInput.wrappedValue //33
        activeOperation.wrappedValue = button.operation
        currentInput.wrappedValue = ""
    } else {
        switch button {
        case .decimal:
            currentInput.wrappedValue += ","
        case .clear:
            currentInput.wrappedValue = ""
            result.wrappedValue = 0
            activeOperation.wrappedValue = ""
            previousInput.wrappedValue = ""
        case .calculate:
            let num1 = Double(previousInput.wrappedValue) ?? 0
            let num2 = Double(currentInput.wrappedValue) ?? 0
            print("num1 is: \(num1)")
            print("num2 is: \(num2)")
            switch activeOperation.wrappedValue {
            case "+":
                result.wrappedValue = num1 + num2
            case "-":
                result.wrappedValue  = num1 - num2
            case "*":
                result.wrappedValue  = num1 * num2
            case "/":
                result.wrappedValue  = num1 / num2
            default:
                result.wrappedValue  = 0
            }
        default:
            currentInput.wrappedValue = "none"
        }
    }
    
    
}
