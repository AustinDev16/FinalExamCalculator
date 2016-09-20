//
//  Assignment.swift
//  FinalExamCalculator
//
//  Created by Austin Blaser on 9/19/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CoreData


class Assignment: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    convenience init?(name: String, score: Double, pointsPossible: Double, category: Category, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext){
        
        guard let entity = NSEntityDescription.entityForName(Assignment.kName, inManagedObjectContext: context) else { return nil}
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        self.name = name
        self.score = score
        self.pointsPossible = pointsPossible
        self.category = category.name
        
    }

}
extension Assignment {
    static var kName: String { return "Assignment" }
    var fractionalScore: Double {return Double(score)/Double(pointsPossible)}
}
