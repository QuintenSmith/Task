//
//  TaskDetailTableViewController.swift
//  Task3.0
//
//  Created by Quinten Smith on 9/22/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dueTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    var task: Task? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    var dueDateValue: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        dueTextField.inputView = dueDatePicker
    }
    
    func updateViews() {
        guard let task = task else {return}
        nameTextField.text = task.name
        notesTextView.text = task.notes
        dueTextField.text = task.due?.stringValue()
        dueDateValue = task.due
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty,
            let notes = notesTextView.text,
            let due = dueDateValue else {return}
        
        if let task = self.task {
            TaskController.shared.update(task: task, name: name, notes: notes, due: due)
        } else {
            TaskController.shared.add(taskWithName: name, notes: notes, due: due)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
        dueDateValue = dueDatePicker.date
        dueTextField.text = dueDateValue?.stringValue() 
    }
    
    @IBAction func userTappedView(_ sender: Any) {
        resignFirstResponder()
    }
    
}
