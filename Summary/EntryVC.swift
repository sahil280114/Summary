//
//  EntryVC.swift
//  Summary
//
//  Created by Sahil Chaudhary on 13/03/18.
//  Copyright © 2018 Sahil Chaudhary. All rights reserved.
//

import UIKit

class EntryVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }


    @IBAction func imgButton(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController")
        presentDetail(vc!)
    }
    
    
  
    @IBAction func clipboardButton(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ClipboardVC")
        presentDetail(vc!)
    }
    
}
