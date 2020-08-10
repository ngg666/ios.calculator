//
//  CalculatorModel.swift
//  Storyboard_Calculator
//
//  Created by MacBook on 7/15/20.
//  Copyright © 2020 ngg666. All rights reserved.
//

import Foundation
import MaterialComponents.MaterialSnackbar

struct CalculatorModel {
    
    var calculatorScrollView: ScrollViewController?
    
    var firstValue: Double? = 0
    var secondValue: Double? = 0
    var result: Double? = 0
    
    var operation: String?
    
    var displayedValue: String = K.Values.zeroString
    
    var isTyping: Bool = false
    var floatingPointAdded: Bool = false
    
    var refactoredValue: String {
        let stringValue = String(displayedValue)
        var outputString: String = K.Values.emptyString
        for character in stringValue.reversed() {
            if outputString.count % 4 == 0 {
                outputString += " "
            }
            outputString += String(character)
        }
        return String(outputString.reversed())
    }
    
    mutating func processCalculation() {
        switch operation {
        case K.OperationSigns.addition: add()
        case K.OperationSigns.substraction: substract()
        case K.OperationSigns.multiplication: multiply()
        case K.OperationSigns.division: divide()
        default:
            break
        }
        
        isTyping = false
    }
    
    //MARK: Values Manipulation Methods
    
    mutating func typingCurrentValue(symbol: String) {
        
        if displayedValue.contains(K.Values.floatingPoint) && symbol == K.Values.floatingPoint {
            return
        }
        
        if displayedValue.count < K.Values.maxNumberOfChar {
            if isTyping {
                displayedValue += symbol
            } else {
                if symbol == K.Values.floatingPoint {
                    displayedValue = K.Values.zeroString
                } else if displayedValue == K.Values.zeroString && symbol == K.Values.zeroString {
                    return 
                } else {
                    displayedValue = K.Values.emptyString
                }
                displayedValue += symbol
                isTyping = true
            }
        }
    }
    
    mutating func clearValues() {
        firstValue = K.Values.zeroDouble
        secondValue = K.Values.zeroDouble
        displayedValue = K.Values.zeroString
        isTyping = false
    }
    
    mutating func changeSign() {
        if let currentDoubleValue = Double(displayedValue) {
            displayedValue = valueToString(value: currentDoubleValue * (-1))
        }
    }
    
    private func isInteger(_ resultValue: Double) -> Bool {
        return floor(resultValue) == resultValue
    }
    
    private func valueToString(value: Double) -> String {
        if isInteger(value) {
            return String(Int(value))
        }
        return String(value)
    }
    
    //MARK: Mathematical Operations Methods
    
    private mutating func add(){
        if firstValue != nil, secondValue != nil {
            result = firstValue! + secondValue!
            displayedValue = valueToString(value: result!)
        } else {
            clearValues()
        }
    }
    
    private mutating func substract(){
        
        if firstValue != nil, secondValue != nil {
            result = firstValue! - secondValue!
            displayedValue = valueToString(value: result!)
        } else {
            clearValues()
        }
    }
    
    private mutating func multiply(){
        
        if firstValue != nil, secondValue != nil {
            result = firstValue! * secondValue!
            displayedValue = valueToString(value: result!)
        } else {
            clearValues()
        }
    }
    
    private mutating func divide(){
        
        if firstValue != nil, secondValue != nil {
            if secondValue == K.Values.zeroDouble {
                calculatorScrollView?.showSnackbar(error: K.Snackbar.divideByZeroMessage)
                return
            }
            result = firstValue! / secondValue!
            displayedValue = valueToString(value: result!)
        } else {
            clearValues()
        }
    }
    
}
