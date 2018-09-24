//
//  TaskController.swift
//  Task3.0
//
//  Created by Quinten Smith on 9/22/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    static let shared = TaskController()
    
    var tasks: [Task] = []
    
    func toggleIsComplete(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
    
    func add(taskWithName name: String, notes: String?, due: Date?) {
        let task = Task(name: name, notes: notes, due: due)
        tasks.append(task)
        saveToPersistentStore()
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?) {
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
    }
    
    func remove(task: Task) {
        guard let index = tasks.index(of: task) else {return}
        tasks.remove(at: index)
        CoreDataStack.context.delete(task)
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch let error {
            print("There was an error in \(#function): \(error)\n\(error.localizedDescription)")
        }
    }
    
    func fetchTasks() -> [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        do {
            return try CoreDataStack.context.fetch(request)
        } catch let error {
            print("There was an error in \(#function): \(error)\n\(error.localizedDescription)")
        }
        return []
    }
}
