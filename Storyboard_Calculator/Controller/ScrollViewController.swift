//
//  CalculatorPads.swift
//  Storyboard_Calculator
//
//  Created by MacBook on 8/3/20.
//  Copyright © 2020 ngg666. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MaterialSnackbar

class ScrollViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet var swipeRecognizer: UISwipeGestureRecognizer!
    
    var username: String = K.Values.emptyString
    var language: String? 
    var currentDisplayedValue: String = K.Values.zeroString
    
    var slides: [CalculatorController] = []
    
    override var prefersHomeIndicatorAutoHidden: Bool {
         return true
     }
    
    //MARK: Gestures Handling Methods
     
     @IBAction func gesturePerformed(_ gesture: UISwipeGestureRecognizer) {

         if gesture.direction == .up {
             performSegue(withIdentifier: "toHistory", sender: self)
         }
     }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            slides[pageControl.currentPage].calculatorModel.clearValues()
            slides[pageControl.currentPage].updateView()
        }
    }
}


extension ScrollViewController: UIScrollViewDelegate {
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        scrollView.addGestureRecognizer(swipeRecognizer)
        scrollView.delegate = self
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.systemOrange
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
    }
    
    //MARK: Scroll View Setup
    
    private func setupSlideScrollView(slides : [CalculatorController]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    private func createSlides() -> [CalculatorController] {
        
        let slide1:CalculatorController = Bundle.main.loadNibNamed("BlackPad", owner: self, options: nil)?.first as! CalculatorController
        slide1.username = self.username
        slide1.calculatorModel.calculatorScrollView = self
        
        let slide2:CalculatorController = Bundle.main.loadNibNamed("GrayPad", owner: self, options: nil)?.first as! CalculatorController
        slide2.username = self.username
        slide2.calculatorModel.calculatorScrollView = self
        
        let slide3:CalculatorController = Bundle.main.loadNibNamed("BluePad", owner: self, options: nil)?.first as! CalculatorController
        slide3.username = self.username
        slide3.calculatorModel.calculatorScrollView = self
        
        return [slide1, slide2, slide3]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.currentDisplayedValue = slides[pageControl.currentPage].calculatorModel.displayedValue
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        slides[pageControl.currentPage].calculatorModel.displayedValue = self.currentDisplayedValue
        
        if currentDisplayedValue == K.Values.zeroString {
            slides[pageControl.currentPage].calculatorModel.isTyping = false
        } else {
            slides[pageControl.currentPage].calculatorModel.isTyping = true
        }
        
        slides[pageControl.currentPage].updateView()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupSlideScrollView(slides: slides)
    }
    
    //MARK: View
    
    func showSnackbar(error: String) {
        let snackbarMessage = MDCSnackbarMessage()
        snackbarMessage.text = K.Snackbar.errors[self.language! + "_" + error]
        MDCSnackbarManager.show(snackbarMessage)
    }
}
