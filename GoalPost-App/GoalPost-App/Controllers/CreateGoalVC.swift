//
//  CreateGoalVC.swift
//  GoalPost-App
//
//  Created by Mahmoud on 8/15/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController ,UITextViewDelegate {

    //@IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    
    @IBOutlet weak var goalTextView: UITextView!
    
    @IBOutlet weak var nextBtn: UIButton!
    var goalType : GoalType = .ShortTerm
    override func viewDidLoad() {
        super.viewDidLoad()
        goalTextView.delegate = self
        nextBtn.bindToKeyboard()
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()

//        let calcBtn = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30))
//        calcBtn.backgroundColor = #colorLiteral(red: 1, green: 0.5917804241, blue: 0.0205632858, alpha: 1)
//        calcBtn.setTitle("Calculate", for: .normal)
//        calcBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
//        calcBtn.addTarget(self, action: #selector(CreateGoalVC.calculate), for: .touchUpInside)
//
//        goalTextView.inputAccessoryView = calcBtn
       // priceTxt.inputAccessoryView = calcBtn
        
        
        
    }

    @objc func calculate(){
    print("xx")
    
    }
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    @IBAction func ShortTermBtnWasPressed(_ sender: Any) {
        goalType = .ShortTerm
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
    }
    @IBAction func longTermBtnWasPressed(_ sender: Any) {
        goalType = .LongTerm
        longTermBtn.setSelectedColor()
        shortTermBtn.setDeselectedColor()
    }
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        if goalTextView.text != "" && goalTextView.text != "What is your goal?" {
            guard let finsihGoal = storyboard?.instantiateViewController(withIdentifier: "finishGoalVC") as? FinishGoalVC else {return}
            finsihGoal.initData( description: goalTextView.text! ,type: goalType)
           presentingViewController?.PresentToInitalVC(finsihGoal)
        }
   
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = ""
        goalTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
    }
}
