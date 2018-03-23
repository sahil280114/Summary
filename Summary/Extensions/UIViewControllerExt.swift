//
//  UIViewControllerExt.swift
//  Summary
//
//  Created by Sahil Chaudhary on 01/03/18.
//  Copyright © 2018 Sahil Chaudhary. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentDetail(_ vc: UIViewController){
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        present(vc,animated: false,completion: nil)
        
    }
    
    func dismissDetail(){
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
        
    }
}
