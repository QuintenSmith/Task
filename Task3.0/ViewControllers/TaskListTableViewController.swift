//
//  TaskListTableViewController.swift
//  Task3.0
//
//  Created by Quinten Smith on 9/22/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class TaskListTableViewController: UITableViewController, ButtonTableViewCellDelegate {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
        guard let index = tableView.indexPath(for: sender) else {return}
        let task = TaskController.shared.tasks[index.row]
        TaskController.shared.toggleIsComplete(task: task)
        tableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? ButtonTableViewCell
        let task = TaskController.shared.tasks[indexPath.row]
        cell?.task = task
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = TaskController.shared.tasks[indexPath.row] 
            TaskController.shared.remove(task: task)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetailView" {
            let destinationVC = segue.destination as? TaskDetailTableViewController
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let task = TaskController.shared.tasks[indexPath.row]
            destinationVC?.task = task
        }
    }

}
