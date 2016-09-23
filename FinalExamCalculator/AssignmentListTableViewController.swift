//
//  AssignmentListTableViewController.swift
//  FinalExamCalculator
//
//  Created by Austin Blaser on 9/20/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class AssignmentListTableViewController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Scores"
        self.navigationController?.navigationBar.barTintColor = greyColor
        self.navigationController?.navigationBar.alpha = 1
        
        self.definesPresentationContext = true
        
        let addButton = UIBarButtonItem(title: "Add Score", style: .Plain, target: self, action: #selector(self.addScoreButtonTapped))
        let categoriesButton = UIBarButtonItem(title: "Categories", style: .Plain, target: self, action: #selector(self.categoriesButtonTapped))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = categoriesButton
        
        self.tableView.backgroundColor = blueColor
        
      FinalExamController.sharedController.assignAssignmentsToCategory()
    }
    
//    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView()
//        view.backgroundColor = blueColor
//        return view
//    }

    func addScoreButtonTapped(){
        self.performSegueWithIdentifier("toDetailAddNew", sender: nil)
    }
    
    func categoriesButtonTapped(){
        self.performSegueWithIdentifier("toCategories", sender: nil)
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return FinalExamController.sharedController.categories.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return FinalExamController.sharedController.categories[section].assignments?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return FinalExamController.sharedController.categories[section].name
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("assignmentCell", forIndexPath: indexPath)
        
        guard let assignment = FinalExamController.sharedController.categories[indexPath.section].assignments?[indexPath.row] else {return UITableViewCell()}
        cell.textLabel?.text = assignment.name
        cell.textLabel?.textColor = .whiteColor()
        
        cell.detailTextLabel?.text = "\(assignment.score)/\(assignment.pointsPossible)"
        cell.detailTextLabel?.textColor = .whiteColor()
        
        cell.backgroundColor = .clearColor()
        
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if segue.identifier == "toDetailFromExisting"{
                guard let index = tableView.indexPathForSelectedRow,
                detailTVC = segue.destinationViewController as? AssignmentDetailTableViewController,
                assignments = FinalExamController.sharedController.categories[index.section].assignments else {return}
                detailTVC.assignment = assignments[index.row]
        }
    }
    

}
