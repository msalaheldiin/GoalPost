//
//  UIViewControllerExt.swift
//  GoalPost-App
//
//  Created by Mahmoud on 8/15/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import UIKit

extension  UIViewController  {
    
    func presentDetail(_ UIViewController : UIViewController) {
        let transtion = CATransition()
        transtion.duration = 0.3
        transtion.type = kCATransitionPush
        transtion.subtype = kCATransitionFromRight
        self.view.window?.layer.add(transtion, forKey: kCATransition)
        present(UIViewController, animated: false, completion: nil)
    }
    
    func PresentToInitalVC(_ viewControllerToPresent : UIViewController) {
        let transtion = CATransition()
        transtion.duration = 0.3
        transtion.type = kCATransitionPush
        transtion.subtype = kCATransitionFromRight
        guard let presentedViewController = presentedViewController else{return}
        presentedViewController.dismiss(animated: false) {
             self.view.window?.layer.add(transtion, forKey: kCATransition)
            self.present(viewControllerToPresent, animated: false, completion: nil)
        }
       
        
        
    }
    

    func dismissDetail() {
        let transtion = CATransition()
        transtion.duration = 0.3
        transtion.type = kCATransitionPush
        transtion.subtype = kCATransitionFromLeft
        self.view.window?.layer.add(transtion, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
    }
}
