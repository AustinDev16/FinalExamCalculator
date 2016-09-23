//
//  CategoriesViewController.swift
//  FinalExamCalculator
//
//  Created by Austin Blaser on 9/21/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class customCell: UITableViewCell {
    
}

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: - Picker Delegate methods
    var pickerValues: [Int] {
        var pickerArray: [Int] = []
        for number in (1...100).reverse() {
            pickerArray.append(number)
        }
        return pickerArray
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return FinalExamController.sharedController.categories.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerValues.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerValues[row])
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let categories = FinalExamController.sharedController.categories
        let components = FinalExamController.sharedController.categories.count - 1
        
        if component < components {
            // move weight next to it ( + component)
            let weightToMatch = Int(100 * (Double(categories[component].weight) + Double(categories[component + 1].weight)))
            print("begin picker")
            print("Weight to match \(weightToMatch)")
            
            let newWeight = pickerValues[row]
            let newWeightForNextComponent = weightToMatch - newWeight
            
            
            if newWeightForNextComponent < 0 {
                
            } else {
            print("new weight: \(newWeight)")
            print("next weight: \(newWeightForNextComponent)")
            
            // Update weight on object
            let currentCategory = categories[component]
            currentCategory.weight = Double(newWeight)/100.0
            print(currentCategory.weight)
            
            let nextCategory = categories[component + 1]
            nextCategory.weight = Double(newWeightForNextComponent)/100.0
            print(nextCategory.weight)
            
            FinalExamController.sharedController.saveToPersistedStorage()
            }
            
            updatePickerWithWeights()
            
        } else {
            // adjust weight next to it ( - component)
            // move weight next to it ( + component)
            let weightToMatch = Int(100 * (Double(categories[component].weight) + Double(categories[component - 1].weight)))
            print("begin picker")
            print("Weight to match \(weightToMatch)")
            
            let newWeight = pickerValues[row]
            let newWeightForNextComponent = weightToMatch - newWeight
            if newWeightForNextComponent < 0 {
                
            } else {
                print("new weight: \(newWeight)")
                print("next weight: \(newWeightForNextComponent)")
                
                // Update weight on object
                let currentCategory = categories[component]
                currentCategory.weight = Double(newWeight)/100.0
                print(currentCategory.weight)
                
                let nextCategory = categories[component - 1]
                nextCategory.weight = Double(newWeightForNextComponent)/100.0
                print(nextCategory.weight)
                
                FinalExamController.sharedController.saveToPersistedStorage()
            }
            
            updatePickerWithWeights()
        }
        
    }
    
    func updatePickerWithWeights(){
        var component = 0
        for category in FinalExamController.sharedController.categories {
            print(category.weight)
            let weight = Double(category.weight) * 100.0
            if let index = pickerValues.indexOf(Int(weight)) {
                
                self.weightPicker.selectRow(index, inComponent: component, animated: true)
                
            }
            
            component += 1
            
            
        }
        self.tableView.reloadData()
    }
    
    // MARK: - UIElements
    
    
    let categoryLabel = UILabel()
    let catSlider = UISlider()
    let tableView = UITableView()
    let newCategoryTextField = UITextField()
    let weightLabel = UILabel()
    let instructionLabel = UILabel()
    let weightPicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradientLayer = AppearenceController.gradient()
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.addSublayer(gradientLayer)
        
        let width = self.view.frame.width
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: width, height: 60))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Categories")
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: nil, action: #selector(doneButtonTapped))
                navItem.leftBarButtonItem = doneButton
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: nil, action: #selector(addCategoryTapped))
        navItem.rightBarButtonItem = addButton
        
        
        navBar.setItems([navItem], animated: false)
        //tableView.frame = CGRectMake(40, 0, 320, 600)
        
        tableView.delegate = self
        tableView.dataSource = self
        
//         tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
       // self.view.backgroundColor = blueColor
        
        self.weightPicker.delegate = self
        self.weightPicker.dataSource = self
        
       setupUIElements()
       setupConstraints()
        
        updatePickerWithWeights()
        
  

        
    }
    
    func setupUIElements(){
        //categoryLabel.text = "Categories"
       //// categoryLabel.font = UIFont(name: textFont, size: 36)
        
        //categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        catSlider.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
       // doneButton.translatesAutoresizingMaskIntoConstraints = false
        //addButton.translatesAutoresizingMaskIntoConstraints = false
        newCategoryTextField.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        weightPicker.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.backgroundColor = .clearColor()
        
       // doneButton.setTitle("Done", forState: .Normal)
       // doneButton.addTarget(self, action: #selector(doneButtonTapped), forControlEvents: .TouchUpInside)
        
       // addButton.setTitle("Add", forState: .Normal)
//addButton.addTarget(self, action: #selector(addCategoryTapped), forControlEvents: .TouchUpInside)
        
        
        
        newCategoryTextField.placeholder = "New category"
        newCategoryTextField.delegate = self
        newCategoryTextField.returnKeyType = .Done
        newCategoryTextField.borderStyle = .RoundedRect
        newCategoryTextField.backgroundColor = UIColor.clearColor()
        newCategoryTextField.textColor = .whiteColor()
        
        weightLabel.text = "Weights"
        weightLabel.textColor = .whiteColor()
        weightLabel.font = UIFont(name: textFont, size: 24)
        
        instructionLabel.text = "Adjust weights from left to right."
        instructionLabel.textColor = .redColor()
        
        instructionLabel.font = UIFont(name: textFont, size: 18)
        
        //self.view.addSubview(categoryLabel)
        //self.view.addSubview(catSlider)
        self.view.addSubview(tableView)
       // self.view.addSubview(doneButton)
       // self.view.addSubview(addButton)
        self.view.addSubview(newCategoryTextField)
        self.view.addSubview(weightLabel)
        self.view.addSubview(instructionLabel)
        self.view.addSubview(weightPicker)
        
    }

    func setupConstraints(){
        //        //Done button
//        let doneButtonTop = NSLayoutConstraint(item: doneButton, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 20)
//        let doneButtonLeading = NSLayoutConstraint(item: doneButton, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .LeadingMargin, multiplier: 1, constant: 0)
//        //let doneButtonTrailing = NSLayoutConstraint(item: doneButton, attribute: .Trailing, relatedBy: .Equal, toItem: categoryLabel, attribute: .Leading, multiplier: 1, constant: 0)
//        self.view.addConstraints([doneButtonTop, doneButtonLeading])
        
        //Textfield and add button
        let textFieldBottom = NSLayoutConstraint(item: newCategoryTextField, attribute: .Bottom, relatedBy: .Equal, toItem: tableView, attribute: .Top, multiplier: 1, constant: 0)
        let textFieldTrailing = NSLayoutConstraint(item: newCategoryTextField, attribute: .Trailing, relatedBy: .Equal, toItem: self.view, attribute: .TrailingMargin, multiplier: 1, constant: 0)
        let textFieldLeading = NSLayoutConstraint(item: newCategoryTextField, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .LeadingMargin, multiplier: 1, constant: 0)
        
//        let addButtonBottom = NSLayoutConstraint(item: addButton, attribute: .Bottom, relatedBy: .Equal, toItem: tableView, attribute: .Top, multiplier: 1, constant: 0)
//        let addButtonTrailing = NSLayoutConstraint(item: addButton, attribute: .Trailing, relatedBy: .Equal, toItem: self.view, attribute: .TrailingMargin, multiplier: 1, constant: 0)
        
        self.view.addConstraints([textFieldBottom, textFieldTrailing, textFieldLeading])
        
        
        // Tableview
        let tableViewCenterX = NSLayoutConstraint(item: self.tableView, attribute: .Trailing, relatedBy: .Equal, toItem: self.view, attribute: .TrailingMargin, multiplier: 1, constant: 0)
        let tableViewCenterY = NSLayoutConstraint(item: self.tableView, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1, constant: 0)
        let tableViewBottom = NSLayoutConstraint(item: self.tableView, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1, constant: -300)
        let tableViewTop = NSLayoutConstraint(item: self.tableView, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 100)
        self.view.addConstraints([tableViewCenterX, tableViewCenterY, tableViewTop, tableViewBottom])
        
        // Weight Label
        let weightCenterX = NSLayoutConstraint(item: weightLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)
        let weightTop = NSLayoutConstraint(item: weightLabel, attribute: .Top, relatedBy: .Equal, toItem: tableView, attribute: .Bottom, multiplier: 1, constant: 8)
        self.view.addConstraints([weightCenterX, weightTop])
        
        // Instructional Label
        let instructionBottom = NSLayoutConstraint(item: instructionLabel, attribute: .Bottom, relatedBy: .Equal, toItem: weightPicker, attribute: .Top, multiplier: 1, constant: 4)
        let instructionLeading = NSLayoutConstraint(item: instructionLabel, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .LeadingMargin, multiplier: 1, constant: 0)
        self.view.addConstraints([instructionBottom, instructionLeading])
        
        // Weight Picker
        let weightPickerTop = NSLayoutConstraint(item: weightPicker, attribute: .Top, relatedBy: .Equal, toItem: weightLabel, attribute: .Bottom, multiplier: 1, constant: 20)
        let weightPickerLeading = NSLayoutConstraint(item: weightPicker, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1, constant: 0)
        let weightPickerTrailing = NSLayoutConstraint(item: weightPicker, attribute: .Trailing, relatedBy: .Equal, toItem: self.view, attribute: .Trailing, multiplier: 1, constant: 0)
        self.view.addConstraints([weightPickerTop, weightPickerLeading, weightPickerTrailing])
        
//        // Slider
//        let sliderCenterX = NSLayoutConstraint(item: catSlider, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)
//        let sliderTop = NSLayoutConstraint(item: catSlider, attribute: .Top, relatedBy: .Equal, toItem: weightLabel, attribute: .Top, multiplier: 1, constant: 100)
//        self.view.addConstraints([sliderCenterX, sliderTop])
        

    }
    // MARK: - Button Functions
    func doneButtonTapped(){
        
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func addCategoryTapped(){
        
//        guard let categoryName = newCategoryTextField.text where categoryName.characters.count > 0 else { return}
//        
//        FinalExamController.sharedController.createCategory(categoryName, weight: 0)
//        FinalExamController.sharedController.redistributeWeights()
        newCategoryTextField.resignFirstResponder()
        updatePickerWithWeights()
        
    }
    
    // MARK: - TextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        newCategoryTextField.resignFirstResponder()
        
        return true
    }
    
    // MARK: - TableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FinalExamController.sharedController.categories.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: "cell")
        }
        
        let category = FinalExamController.sharedController.categories[indexPath.row]
        
        //cell.accessoryType = .DisclosureIndicator
        cell.textLabel?.text = category.name
        cell.textLabel?.font = UIFont(name: textFont, size: 18)
        cell.textLabel?.textColor = .whiteColor()
        
        cell.detailTextLabel?.text = "\(Int(Double(category.weight) * 100)) %"
        cell.detailTextLabel?.textColor = .whiteColor()
        cell.detailTextLabel?.font = UIFont(name: textFont, size: 18)
        
        cell.backgroundColor = .clearColor()
        
        
        return cell
    }

}
