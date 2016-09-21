//
//  Category.swift
//  FinalExamCalculator
//
//  Created by Austin Blaser on 9/19/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CoreData

enum CategoryType: String{
    case Final = "Final"
    case Other = "Other"
}
class Category: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    convenience init?(name: String, weight: Double, type: CategoryType, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext){
        guard let entity = NSEntityDescription.entityForName(Category.kName, inManagedObjectContext: context) else {return nil}
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        self.name = name
        self.weight = weight
        self.type = type.rawValue
    }
    
       var assignments: [Assignment]?

}
extension Category {
    static var kName: String { return "Category" }
}
