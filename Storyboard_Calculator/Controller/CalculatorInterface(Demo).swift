//
//  ViewController.swift
//  Storyboard_Calculator
//
//  Created by MacBook on 7/13/20.
//  Copyright © 2020 ngg666. All rights reserved.
//

import UIKit
import RealmSwift
class CalculatorInterface: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet var calculatorView: UIView!
    
    var calculatorManager = CalculatorManager()
    var username: String = ""
    var operation: String = ""
    
    var realm: Realm? = try! Realm()
    
    var isTyping: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: Calculator Interface Methods
    
    @IBAction func numberPressed(_ sender: UIButton) {
        
        calculatorManager.typingCurrentValue(symbol: sender.titleLabel?.text ?? "")
        updateView()
    }
    
    @IBAction func operationPressed(_ sender: UIButton) {
        calculatorManager.isTyping = false
        calculatorManager.floatingPointAdded = false 
        calculatorManager.firstValue = Double(calculatorManager.displayedValue)
        calculatorManager.operation = sender.titleLabel?.text!
        
        updateView()
    }
    
    @IBAction func changeValuesPressed(_ sender: UIButton) {
    
        if sender.titleLabel?.text! == "AC" {calculatorManager.clearValues()}
        else if sender.titleLabel?.text! == "±" {calculatorManager.changeSign()}
        updateView()
    }
    
    @IBAction func historyButtonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toHistorySegue", sender: self)
    }
    
    @IBAction func resultPressed(_ sender: UIButton) {
        calculatorManager.secondValue = Double(calculatorManager.displayedValue)
        calculatorManager.processCalculation()
        saveData()
        updateView()
    }
    
    //MARK: Gestures Handling Methods
    
    @IBAction func gesturePerformed(_ gesture: UISwipeGestureRecognizer) {
        
        if gesture.direction == .left {
            performSegue(withIdentifier: "toBlackInterface", sender: self)
        } else if gesture.direction == .right {
            print("right")
            dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK: Data Saving
    
    func saveData() {
        let dataString = String(calculatorManager.firstValue!) + " " + calculatorManager.operation! + " " + String(calculatorManager.secondValue!) + " = " + String(calculatorManager.result!)
        
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
        displayLabel.text = calculatorManager.refactoredValue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toBlackInterface" else { return }
        print(segue.destination)
        let calcVC = segue.destination as! CalculatorInterface
        calcVC.username = self.username
        calcVC.displayLabel.text = calculatorManager.refactoredValue
       }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
}

