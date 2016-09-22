//
//  FinalExamController.swift
//  FinalExamCalculator
//
//  Created by Austin Blaser on 9/19/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CoreData

class FinalExamController {
    
    static let sharedController = FinalExamController()
    
    var assignments: [Assignment] = []
    var categories: [Category] = []
    
    init(){

        loadCategoriesFromPersistedStorage()
        loadAssignmentsFromPersistedStorage()
        //assignAssignmentsToCategory()
        if self.assignments.count == 0 || self.categories.count == 0 {
            createMockData()
            loadCategoriesFromPersistedStorage()
            loadAssignmentsFromPersistedStorage()
        }
        print(self.assignments.map{ $0.name})
            print(self.categories.map{$0.name})
        
    }
    
    func createMockData(){
        
        guard let cat1 = Category(name: "Homework", weight: 0.25, type: .Other),
            let cat2 = Category(name: "Essays", weight: 0.25, type: .Other),
            let _ = Category(name: "Final", weight: 0.5, type: .Final) else {return}
        guard let _ = Assignment(name: "Section 1.1", score: 20, pointsPossible: 20, category: cat1),
        let _ = Assignment(name: "Section 1.2", score: 20, pointsPossible: 20, category: cat1),
        let _ = Assignment(name: "Reflective Essay", score: 50, pointsPossible: 50, category: cat2),
        let _ = Assignment(name: "Midterm", score: 100, pointsPossible: 100, category: cat2) else {return}
        saveToPersistedStorage()
        
        
    }
    // MARK: - Assignment
    func createAssignment(name: String, score: Double, pointsPossible: Double, category: Category){
        guard let newAssignment = Assignment(name: name, score: score, pointsPossible: pointsPossible, category: category) else {return}
        saveToPersistedStorage()
        category.assignments?.append(newAssignment)
        FinalExamController.sharedController.assignments.append(newAssignment)
    }
    
    func deleteAssignment(assignment: Assignment){
        guard let moc = assignment.managedObjectContext,
            let index = FinalExamController.sharedController.assignments.indexOf(assignment) else {return}
        
        moc.deleteObject(assignment)
        saveToPersistedStorage()
        FinalExamController.sharedController.assignments.removeAtIndex(index)
    }
    
    // MARK: - Category
    
    func createCategory(name: String, weight: Double, type: CategoryType = .Other){
        guard let newCategory = Category(name: name, weight: weight, type: type) else {return}
        saveToPersistedStorage()
        FinalExamController.sharedController.categories.append(newCategory)
    }
    
    func modifyCategory(category: Category, name: String? = nil, weight: Double? = nil){
        if let name = name {
            category.name = name
        }
        if let weight = weight {
            category.weight = weight
        }
        saveToPersistedStorage()
    }
    
    func deleteCategory(category: Category){
        guard let moc = category.managedObjectContext,
            let index = FinalExamController.sharedController.categories.indexOf(category) else {return}
        
        moc.deleteObject(category)
        saveToPersistedStorage()
        FinalExamController.sharedController.categories.removeAtIndex(index)
    }
    
    func assignWeights(){
        
    }
    // MARK: - CoreData
    func loadAssignmentsFromPersistedStorage(){
        let fetchRequest = NSFetchRequest(entityName: Assignment.kName)
        // fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        let moc = Stack.sharedStack.managedObjectContext
        
        self.assignments = (try? moc.executeFetchRequest(fetchRequest)) as? [Assignment] ?? []
        
    }
    
    func assignAssignmentsToCategory(){
        for category in FinalExamController.sharedController.categories {
            let assignments = FinalExamController.sharedController.assignments.filter{ $0.category == category.name}
            category.assignments = assignments
            
        }
        
    }
    
    func loadCategoriesFromPersistedStorage(){
        let fetchRequest = NSFetchRequest(entityName: Category.kName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        let moc = Stack.sharedStack.managedObjectContext
        
        self.categories = (try? moc.executeFetchRequest(fetchRequest)) as? [Category] ?? []
    }
    
    func saveToPersistedStorage(){
        let moc = Stack.sharedStack.managedObjectContext
        do {
            _ = try moc.save()
        } catch {
            print("Error saving to persisted storage.")
        }
    }
    
    // MARK: - Grade Calculation
    
    func calculateFinalExamGrade(desiredGrade: Double) -> Double {
        
        let categories = FinalExamController.sharedController.categories.filter{ $0.type == "Other"}
        let final = FinalExamController.sharedController.categories.filter{ $0.type == "Final"}
        var aveScores: [Double] = []
        for category in categories {
            let scoresForCategory = FinalExamController.sharedController.assignments.filter{ $0.category == category.name}
            
            let categoryAverage = Double(category.weight)*((scoresForCategory.map{ $0.fractionalScore}.reduce(0){$0 + $1})/Double(scoresForCategory.count))
            
            aveScores.append(categoryAverage)
        }
        
        let averageScore = aveScores.reduce(0) {$0 + $1}
        let finalWeight = Double((final[0].weight))
//        print("Cat scores: \(aveScores)")
//        print("Desired grade: \(desiredGrade)")
//        print("averageScore: \(averageScore)")
//        print("finalWeight: \(finalWeight)")
        let finalExamScore = (desiredGrade - averageScore)/(finalWeight)
        return finalExamScore
    }
    
}
