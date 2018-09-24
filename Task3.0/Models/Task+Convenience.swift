//
//  Task+Convenience.swift
//  Task3.0
//
//  Created by Quinten Smith on 9/22/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    convenience init(name: String, notes: String?, due: Date?, context: NSManagedObjectContext = CoreDataStack.context ) {
        self.init(context: context)
        
        self.name = name
        self.notes = notes
        self.due = due
    }
}
