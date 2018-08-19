//
//  ViewController.swift
//  GoalPost-App
//
//  Created by Mahmoud on 8/15/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import UIKit
import CoreData
let appDelegate = UIApplication.shared.delegate as? AppDelegate
class GoalsVC: UIViewController {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var goals : [Goal] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    fileprivate func fetchCoreObjects() {
        self.fetch { (complete) in
            if complete{
                if goals.count >= 1 {
                    tableView.isHidden = false
                }
                else {
                    tableView.isHidden = true
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fetchCoreObjects()
        tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goalpostWasPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "createGoalVC") else {return}
        presentDetail(createGoalVC)
    }
    
}

extension GoalsVC : UITableViewDataSource ,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as? GoalCell else {
            return UITableViewCell()
        }
        
        let goal  = goals[indexPath.row]
        
        
        cell.ConfigureCell(goal: goal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let addAction = UITableViewRowAction(style: .normal, title: "Add 1") { (rowAction, indexPath) in
            self.setProgress(forIndexPath: indexPath)
            
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        return [deleteAction,addAction]
        
    }
}

extension GoalsVC {
    
    // Get goals from core data to be presented in table view
    
    func fetch (completion:(_ complete:Bool)->()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            goals = try managedContext.fetch(fetchRequest)
            print("Data Fetched Successfully")
            completion(true)
        }catch {
            debugPrint("Unable to fetch data \(error.localizedDescription)")
            completion(false)
        }
        
    }
    
    //Delete  goals from core data
    
    func removeGoal (atIndexPath indexpath:IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        managedContext.delete(goals[indexpath.row])
        
        do {
            try managedContext.save()
            print ("Goal Deletetd Successfully")
        } catch  {
            debugPrint("Error While Deleting\(error.localizedDescription)")
        }
        
    }
    
    func setProgress (forIndexPath indexPath:IndexPath){
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let chosenGoal = goals[indexPath.row]
        if chosenGoal.goalProgress < chosenGoal.goalCompletetionValue {
            chosenGoal.goalProgress += 1
        }
        else {
            return
        }
        
        do {
            try managedContext.save()
            print ("Goal Target Date updated Successfully")
        } catch  {
            debugPrint("Error While Updating Goal Target Date\(error.localizedDescription)")
        }
  
    }
}
