//
//  ButtonTableViewCell.swift
//  Task3.0
//
//  Created by Quinten Smith on 9/22/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

protocol ButtonTableViewCellDelegate: class {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell)
}

class ButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: ButtonTableViewCellDelegate?
    
    func updateViews() {
        guard let task = task else {return}
        primaryLabel.text = task.name
        updateButton(task.isComplete)
    }
    
    func updateButton(_ isComplete: Bool) {
        guard let task = task else {return}
        if task.isComplete == true {
            completeButton.setImage(#imageLiteral(resourceName: "Image"), for: .normal)
        } else {
            completeButton.setImage(#imageLiteral(resourceName: "Image-1"), for: .normal)
        }
    }
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        delegate?.buttonCellButtonTapped(self) 
    }
    
}

