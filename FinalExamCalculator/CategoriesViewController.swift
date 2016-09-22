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

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    // MARK: UIElements
    
    let categoryLabel = UILabel()
    let catSlider = UISlider()
    let tableView = UITableView()
    let doneButton = UIButton(type: .System)
    let addButton = UIButton(type: .System)
    let newCategoryTextField = UITextField()
    let weightLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.frame = CGRectMake(40, 0, 320, 600)
        
        tableView.delegate = self
        tableView.dataSource = self
        
         tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.backgroundColor = blueColor
        
        setupUIElements()
        setupConstraints()
        
  

        
    }
    
    func setupUIElements(){
        categoryLabel.text = "Categories"
        
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        catSlider.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        newCategoryTextField.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.backgroundColor = blueColor
        
        doneButton.setTitle("Done", forState: .Normal)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), forControlEvents: .TouchUpInside)
        
        addButton.setTitle("Add", forState: .Normal)
        addButton.addTarget(self, action: #selector(addCategoryTapped), forControlEvents: .TouchUpInside)
        
        
        
        newCategoryTextField.placeholder = "New category"
        newCategoryTextField.delegate = self
        newCategoryTextField.returnKeyType = .Done
        newCategoryTextField.borderStyle = .RoundedRect
        newCategoryTextField.backgroundColor = UIColor.clearColor()
        
        weightLabel.text = "Weights"
        weightLabel.textColor = .whiteColor()
        
        
        
        self.view.addSubview(categoryLabel)
        self.view.addSubview(catSlider)
        self.view.addSubview(tableView)
        self.view.addSubview(doneButton)
        self.view.addSubview(addButton)
        self.view.addSubview(newCategoryTextField)
        self.view.addSubview(weightLabel)
        
    }

    func setupConstraints(){
        
        // Label
        let labelTop = NSLayoutConstraint(item: categoryLabel, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .TopMargin, multiplier: 1, constant: 20)
        let labelCenterX = NSLayoutConstraint(item: categoryLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)
        self.view.addConstraints([labelTop, labelCenterX])
        
        //Cancel button
        let doneButtonTop = NSLayoutConstraint(item: doneButton, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 20)
        let doneButtonTrailing = NSLayoutConstraint(item: doneButton, attribute: .Trailing, relatedBy: .Equal, toItem: self.view, attribute: .Trailing, multiplier: 1, constant: 0)
        let doneButtonLeading = NSLayoutConstraint(item: doneButton, attribute: .Leading, relatedBy: .Equal, toItem: categoryLabel, attribute: .Trailing, multiplier: 1, constant: 0)
        self.view.addConstraints([doneButtonTop, doneButtonTrailing, doneButtonLeading])
        
        //Textfield and add button
        let textFieldBottom = NSLayoutConstraint(item: newCategoryTextField, attribute: .Bottom, relatedBy: .Equal, toItem: tableView, attribute: .Top, multiplier: 1, constant: 0)
        let textFieldTrailing = NSLayoutConstraint(item: newCategoryTextField, attribute: .Trailing, relatedBy: .Equal, toItem: addButton, attribute: .Leading, multiplier: 1, constant: -6)
        let textFieldLeading = NSLayoutConstraint(item: newCategoryTextField, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .LeadingMargin, multiplier: 1, constant: 0)
        
        let addButtonBottom = NSLayoutConstraint(item: addButton, attribute: .Bottom, relatedBy: .Equal, toItem: tableView, attribute: .Top, multiplier: 1, constant: 0)
        let addButtonTrailing = NSLayoutConstraint(item: addButton, attribute: .Trailing, relatedBy: .Equal, toItem: self.view, attribute: .TrailingMargin, multiplier: 1, constant: 0)
        
        self.view.addConstraints([textFieldBottom, textFieldTrailing, textFieldLeading, addButtonBottom, addButtonTrailing])
        
        
        // Tableview
        let tableViewCenterX = NSLayoutConstraint(item: self.tableView, attribute: .Trailing, relatedBy: .Equal, toItem: self.view, attribute: .Trailing, multiplier: 1, constant: 0)
        let tableViewCenterY = NSLayoutConstraint(item: self.tableView, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1, constant: 0)
        let tableViewBottom = NSLayoutConstraint(item: self.tableView, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1, constant: -300)
        let tableViewTop = NSLayoutConstraint(item: self.tableView, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 100)
        self.view.addConstraints([tableViewCenterX, tableViewCenterY, tableViewTop, tableViewBottom])
        
        // Weight Label
        let weightCenterX = NSLayoutConstraint(item: weightLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)
        let weightTop = NSLayoutConstraint(item: weightLabel, attribute: .Top, relatedBy: .Equal, toItem: tableView, attribute: .Bottom, multiplier: 1, constant: 8)
        self.view.addConstraints([weightCenterX, weightTop])
        
        // Slider
        let sliderCenterX = NSLayoutConstraint(item: catSlider, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)
        let sliderTop = NSLayoutConstraint(item: catSlider, attribute: .Top, relatedBy: .Equal, toItem: weightLabel, attribute: .Top, multiplier: 1, constant: 100)
        self.view.addConstraints([sliderCenterX, sliderTop])
        

    }
    // MARK: - Button Functions
    func doneButtonTapped(){
        
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func addCategoryTapped(){
        
    }
    
    // MARK: - TextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        resignFirstResponder()
        
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
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        
        let category = FinalExamController.sharedController.categories[indexPath.row]
        
        cell?.accessoryType = .DisclosureIndicator
        cell?.textLabel?.text = category.name
        cell?.textLabel?.textColor = .whiteColor()
        
        cell?.detailTextLabel?.text = "40%"
        
        cell?.backgroundColor = blueColor
        
        
        return cell ?? UITableViewCell()
    }

}
