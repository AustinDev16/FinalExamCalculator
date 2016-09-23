//
//  FinalScoreViewController.swift
//  FinalExamCalculator
//
//  Created by Austin Blaser on 9/20/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit



class FinalScoreViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - Properties
 
    
    let finalScoreLabel = UILabel()
    let scorePicker = UIPickerView()
    let currentGradeLabel = UILabel()
    let finalScoreHeader = UILabel()
    let desiredGradeLabel = UILabel()
    let addScoreButton = UIBarButtonItem()
    let onYourFinal = UILabel()
    
    var desiredGrade: Double = 0 {
        didSet{
            finalScoreLabel.text = "\(Int(FinalExamController.sharedController.calculateFinalExamGrade(desiredGrade)*100)) %"
            
        }
    }
    var pickerValues: [Int] = []
    
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = AppearenceController.gradient()
        gradient.locations = [0.3, 1.2]
        gradient.frame = self.view.bounds
        self.view.layer.addSublayer(gradient)
        
        self.navigationController?.navigationBar.backgroundColor = .whiteColor()
        self.navigationController?.navigationBar.alpha = 0.1
        
        self.tabBarController?.tabBar.barTintColor = greyColor
        self.tabBarController?.tabBar.backgroundColor = greyColor
        setupLabelText()
        setupLayoutConstraints()
        self.scorePicker.delegate = self
        self.scorePicker.dataSource = self
        setupPickerContent()
        
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
    // MARK: - Setup UI components
    
    func setupPickerContent(){
        for number in 50...100 {
            self.pickerValues.insert(number, atIndex: 0)
        }
        
        if let index = pickerValues.indexOf(85) {
            self.scorePicker.selectRow(index, inComponent: 0, animated: true)
        }
    }
    
    
    func setupLabelText(){
        self.title = "Final Exam"
        addScoreButton.title = "Add Score"
        self.navigationItem.rightBarButtonItem = addScoreButton
        self.view.backgroundColor = blueColor
        
        //scorePicker.backgroundColor = .whiteColor()
        
        
        finalScoreLabel.text = "---"
        finalScoreLabel.textColor = .redColor()
        finalScoreLabel.font = UIFont(name: textFont, size: 36)
        
        currentGradeLabel.text = "Your current grade is: 76%"
        currentGradeLabel.textColor = .whiteColor()
        currentGradeLabel.font = UIFont(name: textFont, size: 24)
        
        desiredGradeLabel.text = "Choose your desired grade"
        desiredGradeLabel.textColor = .whiteColor()
        desiredGradeLabel.font = UIFont(name: textFont, size: 24)
        
        finalScoreHeader.text = "You need at least a"
        finalScoreHeader.textColor = .whiteColor()
        finalScoreHeader.font = UIFont(name: textFont, size: 24)
        
        onYourFinal.text = "on your final."
        onYourFinal.textColor = .whiteColor()
        onYourFinal.font = UIFont(name: textFont, size: 24)
        
        self.view.addSubview(finalScoreLabel)
        self.view.addSubview(scorePicker)
        self.view.addSubview(currentGradeLabel)
        self.view.addSubview(desiredGradeLabel)
        self.view.addSubview(finalScoreHeader)
        self.view.addSubview(onYourFinal)
    }
    
    func setupLayoutConstraints(){
        finalScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scorePicker.translatesAutoresizingMaskIntoConstraints = false
        currentGradeLabel.translatesAutoresizingMaskIntoConstraints = false
        desiredGradeLabel.translatesAutoresizingMaskIntoConstraints = false
        finalScoreHeader.translatesAutoresizingMaskIntoConstraints = false
        onYourFinal.translatesAutoresizingMaskIntoConstraints = false
        
        // Top label
        let currentGradeTop = NSLayoutConstraint(item: currentGradeLabel, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 75)
        let currentGradeCenterX = NSLayoutConstraint(item: currentGradeLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)
        
        self.view.addConstraints([currentGradeTop, currentGradeCenterX])
        
        // Desired Grade label
        let desiredGradeCenterX = NSLayoutConstraint(item: desiredGradeLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)
        let desiredGradeBottomToPicker = NSLayoutConstraint(item: desiredGradeLabel, attribute: .Bottom, relatedBy: .Equal, toItem: scorePicker, attribute: .Top, multiplier: 1, constant: -15)
        self.view.addConstraints([desiredGradeCenterX, desiredGradeBottomToPicker])
        
        // Scorepicker
        let pickerCenterX = NSLayoutConstraint(item: scorePicker, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)
        let pickerCenterY = NSLayoutConstraint(item: scorePicker, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: 0)
        
        self.view.addConstraints([pickerCenterX, pickerCenterY])
        
        // Final Score header
        let finalScoreHeaderCenterX = NSLayoutConstraint(item: finalScoreHeader, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)
        let finalScoreHeaderTopToPicker = NSLayoutConstraint(item: finalScoreHeader, attribute: .Top, relatedBy: .Equal, toItem: scorePicker, attribute: .Bottom, multiplier: 1, constant: 0)
        self.view.addConstraints([finalScoreHeaderCenterX, finalScoreHeaderTopToPicker])
        
        // Final Score Label
        let finalScoreLabelCenterX = NSLayoutConstraint(item: finalScoreLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)
        let finalScoreLabelFromBottom = NSLayoutConstraint(item: finalScoreLabel, attribute: .Top, relatedBy: .Equal, toItem: finalScoreHeader, attribute: .Bottom, multiplier: 1, constant: 6)
        self.view.addConstraints([finalScoreLabelCenterX, finalScoreLabelFromBottom])
        
        //On your final Label
        let onYourFinalCenterX = NSLayoutConstraint(item: onYourFinal, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)
        
        let onYourFinalFromFinalScore = NSLayoutConstraint(item: onYourFinal, attribute: .Top, relatedBy: .Equal, toItem: finalScoreLabel, attribute: .Bottom, multiplier: 1, constant: 6)
        self.view.addConstraints([onYourFinalCenterX, onYourFinalFromFinalScore])
    }
    
    // MARK: - Picker Delegate methods
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerValues.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(self.pickerValues[row])
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.desiredGrade = Double(pickerValues[row])/100
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
