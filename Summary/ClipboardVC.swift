//
//  ClipboardVC.swift
//  Summary
//
//  Created by Sahil Chaudhary on 12/03/18.
//  Copyright © 2018 Sahil Chaudhary. All rights reserved.
//

import UIKit

class ClipboardVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector (self.dismissKeyboard(_:)))
        view.addGestureRecognizer(tap)
        
    }
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer){
        textView.resignFirstResponder()
    }
    override func viewWillAppear(_ animated: Bool) {
        textView.text = "Tap here and paste the text"
        textView.textColor = UIColor.lightGray
        textView.textAlignment = .center
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = UIPasteboard.general.string
        textView.textColor = UIColor.black
        textView.textAlignment = .left
    }

    @IBAction func summariseButton(_ sender: UIButton) {
        if textView.text != "" && textView.text != "Tap here and paste the text" {
            //Summarisation will take place here
            let summary = Summary()
            let text = textView.text
            textToBeDisplayed = summary.getSummary(text: text!)
            //presenting the next VC
            let vc = storyboard?.instantiateViewController(withIdentifier: "SummaryVC")
            presentDetail(vc!)
        }
        else {
            let alert = UIAlertController(title: "Error", message: "No text found", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Ok", style: .cancel)
            alert.addAction(cancel)
            self.present(alert,animated: true)
            
        }
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismissDetail()
    }
}
