//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Eddie Char on 9/3/20.
//  Copyright © 2020 Eddie Char. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    
    // MARK: - Properties
    let maxDigits: Int
    
    private let formatter = NumberFormatter()
    private var isDoneEnteringDigits = true
    private var expression: (n1: String, operation: String?, n2: String?) = (n1: "0", operation: nil, n2: nil)

    
    // MARK: - Methods
    
    init(maxDigits: Int) {
        self.maxDigits = maxDigits

        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16
    }

    mutating func enterNums(append digit: String, to operand: inout String) {
        guard (operand.count < maxDigits) && !(digit == "." && operand.contains(".")) else {
            //Limit number entry and prevent entering an extra decimal.
            return
        }
        

        if isDoneEnteringDigits {
            if digit != "0" {
                isDoneEnteringDigits = false
            }

            operand = (digit == ".") ? "0." : digit
        }
        else {
            operand += digit
        }
        
        if expression.operation == nil {
            expression.n1 = operand
        }
        else {
            expression.n2 = operand
        }
        
        print("isDoneEnteringDigits: \(isDoneEnteringDigits) | \(expression.n1) \(expression.operation ?? "nil") \(expression.n2 ?? "nil")")
    }
    
    mutating func performOperation(with operation: String, on operand: inout String) {
        isDoneEnteringDigits = true

        guard operation != "AC" else {
            expression = (n1: "0", operation: nil, n2: nil)
            operand = "0"

            print("isDoneEnteringDigits: \(isDoneEnteringDigits) | \(expression.n1) \(expression.operation ?? "nil") \(expression.n2 ?? "nil")")
            
            return
        }
        
        guard var result = Double(operand) else {
            fatalError("Unable to convert number to Double.")
        }
                

        switch operation {
        case "+/-":
            guard operand != "0" else {
                return
            }
            
            isDoneEnteringDigits = false
            result *= -1
            
            operand = formatter.string(from: NSNumber(value: result))!

            if expression.operation == nil {
                expression.n1 = operand
            }
            else {
                expression.n2 = operand
            }
        case "%":
            result /= 100

            if expression.operation == nil {
                operand = formatter.string(from: NSNumber(value: result))!
                expression.n1 = operand
            }
            else {
                if expression.n2 != nil {
                    operand = formatter.string(from: NSNumber(value: result))!
                    expression.n2 = operand
                }
            }
        case "+", "-", "×", "÷":
            if expression.operation != nil {
                operand = calculate(force: false)
            }

            expression.operation = operation
        case "=":
            operand = calculate(force: true)
        default:
            //Unknown operation
            break
        }
        
        print("isDoneEnteringDigits: \(isDoneEnteringDigits) | \(expression.n1) \(expression.operation ?? "nil") \(expression.n2 ?? "nil")")
    }
    
    
    // MARK: - Helper Methods
    
    private mutating func calculate(force calculate: Bool) -> String {
        let n1 = Double(expression.n1)!
        let n2 = Double(expression.n2 ?? (calculate ? expression.n1 : "nil"))
        var result: Double = 0
        
        switch expression.operation {
        case "+":
            result = n1 + (n2 ?? 0)
            expression.n1 = formatter.string(from: NSNumber(value: result))!
        case "-":
            result = n1 - (n2 ?? 0)
            expression.n1 = formatter.string(from: NSNumber(value: result))!
        case "×":
            result = n1 * (n2 ?? 1)
            expression.n1 = formatter.string(from: NSNumber(value: result))!
        case "÷":
            result = n1 / (n2 ?? 1)
            expression.n1 = formatter.string(from: NSNumber(value: result))!
        default:
            //Unknown operation
            break
        }
        
        expression.n2 = nil
        
        return expression.n1
    }
}
