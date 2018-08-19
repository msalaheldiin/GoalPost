//
//  GoalCell.swift
//  GoalPost-App
//
//  Created by Mahmoud on 8/15/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {
   
    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    
    @IBOutlet weak var completedGoal: UIView!
    func ConfigureCell(goal : Goal)  {
        goalDescriptionLbl.text = goal.goalDescription
        goalTypeLbl.text = goal.goalType
        goalProgressLbl.text = String(describing:goal.goalProgress)
        
        if goal.goalProgress == goal.goalCompletetionValue {
            completedGoal.isHidden = false
        }
        else {
           completedGoal.isHidden = true
        }
    }
    
    
}
