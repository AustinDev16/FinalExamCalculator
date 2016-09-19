//
//  Assignment+CoreDataProperties.swift
//  FinalExamCalculator
//
//  Created by Austin Blaser on 9/19/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Assignment {

    @NSManaged var name: String
    @NSManaged var score: NSNumber
    @NSManaged var category: String
    @NSManaged var pointsPossible: NSNumber

}
