//
//  WelcomeScreen.swift
//  Storyboard_Calculator
//
//  Created by MacBook on 7/31/20.
//  Copyright © 2020 ngg666. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MaterialSnackbar

class WelcomeScreenController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var languageSegmentControl: UISegmentedControl!
    
    var currentLanguage: String {
        languageSegmentControl.titleForSegment(at: languageSegmentControl.selectedSegmentIndex) ?? K.Values.emptyString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        
        if let currentUser = username.text, currentUser.isEmpty {
            let snackbarMessage = MDCSnackbarMessage()
            snackbarMessage.text = K.Snackbar.errors[currentLanguage + "_" + K.Snackbar.emptyFieldMessage]
            MDCSnackbarManager.show(snackbarMessage)
        } else {
            performSegue(withIdentifier: "toCalculator", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let currentUser = username.text {
            let calcVC = segue.destination as! ScrollViewController
            calcVC.username = currentUser
            calcVC.language = currentLanguage
        }
    }
}
