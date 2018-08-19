//
//  FinishGoalVC.swift
//  GoalPost-App
//
//  Created by Mahmoud on 8/17/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import UIKit

class FinishGoalVC: UIViewController {
    
    @IBOutlet weak var pointsTF: UITextField!
    @IBOutlet weak var createGoalBtn: UIButton!
    var goalType : GoalType!
    var goalDescription : String!
    
    func initData( description : String , type : GoalType) {
        
        self.goalType = type
        self.goalDescription = description
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createGoalBtn.bindToKeyboard()
    }
    
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func createGoalWasPressed(_ sender: Any) {
        if pointsTF.text != ""{
            self.save { (complete) in
                if complete {
                    
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    // Save Goals to persistant sotre
    func save( compeletion: (_ fineshed : Bool)->()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        let goal = Goal(context: managedContext)
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletetionValue = Int32(pointsTF.text!)!
        goal.goalProgress = Int32(0)
        
        do {
            try managedContext.save()
            print("Saved Successfully")
            compeletion(true)
        }
        catch {
            debugPrint("Could not save \(error.localizedDescription) ")
            compeletion(false)
        }
        
        
        
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
