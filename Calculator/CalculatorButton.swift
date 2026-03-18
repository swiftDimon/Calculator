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
    } // Title end
    
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
        case .add  ,.subtract , .divide ,.multiply:
            return self.title
        case .exponent:
            return "ⁿ"
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
    
    
    
}// Enum end

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

struct CalcTask { // Struct for making Live result with animation
    static var pendingWork: DispatchWorkItem?
}
/// //Change textField by press.Logic of our button
/// - Parameters:
///   - button: button that we pressed from CalculatorButton enum
///   - currentInput: binding a text which we want to change
func calculatorDidTap(button: CalculatorButton,
                      activeOperation: Binding<String> ,
                      result: Binding<String>,
                      expression: Binding<String>
){
    let lastChar = expression.wrappedValue.last ?? " "
    if button.isNumber {
        if expression.wrappedValue == "0"{
            expression.wrappedValue = button.title
        }else if lastChar == "ⁿ" || "⁰¹²³⁴⁵⁶⁷⁸⁹".contains(lastChar){ // logic for exponent
            expression.wrappedValue += convertToSubscript(button.title)
        }
        else {
            expression.wrappedValue += button.title
        }
    } else if !button.operation.isEmpty{
        if "÷×+-xⁿ".contains(lastChar){
            expression.wrappedValue.removeLast()
            expression.wrappedValue += button.operation
        } else {
            expression.wrappedValue += button.operation
        }
    }else {
        print ("Not gg")
        switch button {
        case .decimal:
            if lastChar != "." {
                expression.wrappedValue += "."
            }
        case .clear:
            result.wrappedValue = "0"
            activeOperation.wrappedValue = ""
            expression.wrappedValue = "0"
        case .squareRoot:
            activeOperation.wrappedValue = "√"
        case.calculate:
            CalcTask.pendingWork?.cancel()
           try? expression.wrappedValue = calculateExpression(expression)
            return
        default:
            expression.wrappedValue = "none"
            
        } // switch button end
    } //else end
    
    // --- 2. THE DELAY LOGIC ---
        
        // Cancel any previous timer because the user just tapped a button
        CalcTask.pendingWork?.cancel()
        
        // Create a new timer
        let workItem = DispatchWorkItem {
            if let liveResult = try? calculateExpression(expression) {
                // Check if user hasn't typed anything else during the 1-second wait
                // This ensures we don't overwrite with an old calculation
                DispatchQueue.main.async {
                    result.wrappedValue = liveResult
                }
            }
        }
        
        // Store and execute after 1 second
        CalcTask.pendingWork = workItem
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: workItem)

}// calculatorDidTap end

/// Return result from expression string
/// - Parameter input: Our string with operations and numbers
/// - Returns: result of expression
func calculateExpression (_ input: Binding<String>) throws -> String{
    do {
        var formula = input.wrappedValue
        let subsripts = ["⁰":"0", "¹":"1", "²":"2", "³":"3", "⁴":"4", "⁵":"5", "⁶":"6", "⁷":"7", "⁸":"8", "⁹":"9"]
        for (key,value) in subsripts {
            formula = formula.replacingOccurrences(of: key, with: value)
        }
        guard !formula.isEmpty else { throw CalculatorError.noNumberEntered }
        while let last = formula.last, "÷×+-ⁿ.".contains(last) { // remove last operation symbol
            formula.removeLast()
        }
        let swapSymbols = formula.replacingOccurrences(of: "÷", with: "/") //change symbols ,to work with
            .replacingOccurrences(of: "×", with: "*")
            .replacingOccurrences(of: "ⁿ", with: "**")
        
        let expression = NSExpression(format: swapSymbols)
        
        guard let result = expression.expressionValue(with: nil, context: nil) as? Double else { throw CalculatorError.invalidCharacters }
            return String(format: "%g",result)
    } catch CalculatorError.noNumberEntered{
        return "no numbers"
    }catch CalculatorError.invalidCharacters{
        return "Character error"
    }catch {
        return "Unexpected error"
    }
}

enum CalculatorError: Error {
//    case divisionByZero
    case invalidCharacters
    case noNumberEntered
}

func convertToSubscript(_ input: String) -> String{ // Support function to convert for Exponent
    let subsripts = ["⁰":"0", "¹":"1", "²":"2", "³":"3", "⁴":"4", "⁵":"5", "⁶":"6", "⁷":"7", "⁸":"8", "⁹":"9"]
    var result = ""
    for (key, value) in subsripts {
        if value == input{
            result = key
            break
        }
    }
    return result
}
