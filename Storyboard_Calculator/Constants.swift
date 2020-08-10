//
//  Constants.swift
//  Storyboard_Calculator
//
//  Created by MacBook on 7/15/20.
//  Copyright © 2020 ngg666. All rights reserved.
//

import Foundation
import UIKit

struct K {
    struct Values {
        static let maxNumberOfChar: Int  = 10
        static let zeroInt: Int = 0
        static let zeroDouble: Double = 0.0
        static let zeroString: String = "0"
        static let emptyString: String = ""
        static let floatingPoint: String = "."
    }
    
    struct OperationSigns {
        static let addition: String = "+"
        static let substraction: String = "-"
        static let multiplication: String = "×"
        static let division: String = "÷"
        static let clearValues: String = "AC"
        static let changeSign: String = "±"
    }
    
    struct Snackbar {
        static let errors: [String : String] =
        [
            "Eng_emptyTextField" : "Text field is empty. Enter your name to continue",
            "Eng_divideByZero" : "Division by zero is impossible",
            "Eng_welcomeScreen" : "Enter your name",
            
            "Ru_emptyTextField" : "Вы не заполнили поле. Введите свое имя, чтобы продолжить",
            "Ru_divideByZero" : "Деление на ноль невозможно",
            "Ru_welcomeScreen" : "Введите свое имя",
            
            "Ro_emptyTextField" : "Câmpul este gol. Introdu numele pentru a continua",
            "Ro_divideByZero" : "împărțirea la zero este imposibilă",
            "Ro_welcomeScreen" : "Introduceți numele"
        ]
        
        static let emptyFieldMessage: String = "emptyTextField"
        static let divideByZeroMessage: String = "divideByZero"
        static let welcomeScreenMessage: String = "welcomeScreen"
    }
}
