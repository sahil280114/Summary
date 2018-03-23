//
//  SummaryVC.swift
//  Summary
//
//  Created by Sahil Chaudhary on 01/03/18.
//  Copyright © 2018 Sahil Chaudhary. All rights reserved.
//

import UIKit
import StoreKit

class SummaryVC: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        textView.text = textToBeDisplayed
        
    }
 
    

    @IBAction func backButton(_ sender: UIButton) {
       dismissDetail()
    }
 
    @IBAction func copyButton(_ sender: UIButton) {
        if let text = textView.text {
            UIPasteboard.general.string = text
            let randomNumber = arc4random_uniform(21)
            if (randomNumber % 2 == 0){
                print(randomNumber)
                if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
                }
                
            }
        }
        
    }
    
}

