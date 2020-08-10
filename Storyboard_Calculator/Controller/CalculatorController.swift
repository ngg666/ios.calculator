//
//  Slide.swift
//  Storyboard_Calculator
//
//  Created by MacBook on 8/3/20.
//  Copyright © 2020 ngg666. All rights reserved.
//

import UIKit
import RealmSwift

class CalculatorController: UIView {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    var username: String = K.Values.emptyString
    var isTyping: Bool = false
    
    var calculatorModel = CalculatorModel()
    var realm: Realm? = try! Realm()
    
    
    //MARK: Calculator Interface Methods
    
    @IBAction func numberPressed(_ sender: UIButton) {
        calculatorModel.typingCurrentValue(symbol: sender.titleLabel?.text ?? K.Values.emptyString)
        blinkButton(sender)
        updateView()
    }
    
    @IBAction func operationPressed(_ sender: UIButton) {
        calculatorModel.isTyping = false
        calculatorModel.floatingPointAdded = false
        calculatorModel.firstValue = Double(calculatorModel.displayedValue)
        calculatorModel.operation = sender.titleLabel?.text!
        blinkButton(sender)
        updateView()
    }
    
    @IBAction func changeValuesPressed(_ sender: UIButton) {
        
        if sender.titleLabel?.text! == K.OperationSigns.clearValues {calculatorModel.clearValues()}
        else if sender.titleLabel?.text! == K.OperationSigns.changeSign {calculatorModel.changeSign()}
        blinkButton(sender)
        updateView()
    }
    
    @IBAction func resultPressed(_ sender: UIButton) {
        calculatorModel.secondValue = Double(calculatorModel.displayedValue)
        calculatorModel.processCalculation()
        saveData()
        blinkButton(sender)
        updateView()
    }
    
    //MARK: Data Saving
    
    func saveData() {
        guard let firstValue = calculatorModel.firstValue, let secondValue = calculatorModel.secondValue,
            let operation = calculatorModel.operation, let result = calculatorModel.result else { return }
        
        let dataString = String(firstValue) + " " + operation + " " + String(secondValue) + " = " + String(result)
        
        let newData = Data()
        newData.user = self.username
        newData.operation = dataString
        newData.timestamp = Date()
        
        do {
            try realm?.write {
                realm?.add(newData)
            }
        } catch {
            print("Error writing data: \(error)")
        }
            
        
    }
    
    //MARK: View
    
    func updateView() {
        displayLabel.text = calculatorModel.refactoredValue
    }
    
    func blinkButton(_ sender: UIButton) {
        
        sender.alpha = 0.3
        UIView.animate(withDuration: 0.2, delay: 0.1, options: UIView.AnimationOptions.curveEaseOut, animations: {

            sender.alpha = 1.0

        }, completion: nil)
    }
    
}
