//
//  FinalScoreViewController.swift
//  FinalExamCalculator
//
//  Created by Austin Blaser on 9/20/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class FinalScoreViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var finalScoreLabel: UILabel!
    @IBOutlet weak var scorePicker: UIPickerView!
    @IBOutlet weak var currentGradeLabel: UILabel!
    
    var desiredGrade: Double = 0 {
        didSet{
        finalScoreLabel.text = "\(FinalExamController.sharedController.calculateFinalExamGrade(desiredGrade)*100) %"
        }
    }
    var pickerValues: [Int] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scorePicker.delegate = self
        self.scorePicker.dataSource = self
        
        for number in 50...100 {
            self.pickerValues.insert(number, atIndex: 0)
        }
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        guard let index = pickerValues.indexOf(85) else {return}
        self.scorePicker.selectRow(index, inComponent: 0, animated: true)
    }
    
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
