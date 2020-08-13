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
import AudioToolbox

class WelcomeScreenController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var languageSegmentControl: UISegmentedControl!
    
    var currentLanguage: String {
        languageSegmentControl.titleForSegment(at: languageSegmentControl.selectedSegmentIndex) ?? K.Values.emptyString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if let textField = self.username.text, textField.isEmpty {
                self.vibrate()
            }
        }
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            username.text = ""
        }
    }
    
    func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
