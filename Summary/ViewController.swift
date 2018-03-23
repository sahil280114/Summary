//
//  ViewController.swift
//  Summary
//
//  Created by Sahil Chaudhary on 28/02/18.
//  Copyright © 2018 Sahil Chaudhary. All rights reserved.
//

import UIKit
import TesseractOCR

//Global Var
var textToBeDisplayed:String!

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
  
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        view.addGestureRecognizer(tap)
        
    }
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer){
        textView.resignFirstResponder()
    }

    override func viewWillAppear(_ animated: Bool) {
        textView.text = "Tap the add button to load an image"
        textView.textColor = UIColor.lightGray
        textView.isEditable = false
        textView.textAlignment = .center
    }
    //This is the action for summarise button
    @IBAction func summarise(_ sender: UIButton) {
        if textView.text != "" && textView.text != "Tap the add button to load an image" {
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
    @IBAction func takePhoto(_ sender: UIButton) {
        presentImagePicker()
    }
    // OCR Action
    func performImageRecognition(_ image: UIImage?){
        if let tesseract = G8Tesseract(language: "eng+fra"){
            tesseract.engineMode = .tesseractCubeCombined
            tesseract.pageSegmentationMode = .auto
            tesseract.image = image?.g8_blackAndWhite()
            tesseract.recognize()
            textView.isEditable = true
            textView.textAlignment = .left
            textView.text = tesseract.recognizedText
            textView.textColor = .black
        }
        activityIndicator.stopAnimating()
    }

    @IBAction func backButton(_ sender: UIButton) {
        dismissDetail()
    }
    
  

}

extension ViewController: UINavigationControllerDelegate {
    
}
extension ViewController: UIImagePickerControllerDelegate{
    func presentImagePicker(){
        let imagePickerActionSheet = UIAlertController(title: "Add Image", message: nil, preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraButton = UIAlertAction(title: "Camera", style: .default){ (alert) -> Void in
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = true
                self.present(imagePicker,animated: true)
                
            }
            imagePickerActionSheet.addAction(cameraButton)
        }
        let libraryButton = UIAlertAction(title: "Library", style: .default ){ (alert) -> Void in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker,animated: true)
        }
        imagePickerActionSheet.addAction(libraryButton)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        imagePickerActionSheet.addAction(cancelButton)
        present(imagePickerActionSheet,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage,
            let scaledImage = selectedImage.scaleImage(640){
                activityIndicator.startAnimating()
            dismiss(animated: true, completion: {self.performImageRecognition(scaledImage)})
        }
        
    }
}
extension UIImage {
    func scaleImage(_ maxDimension: CGFloat) -> UIImage?{
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        if size.width > size.height {
            let scaleFactor = size.height / size.width
            scaledSize.height = scaleFactor * scaledSize.width
        }
        else{
            let scaleFactor = size.height/size.width
            scaledSize.width = scaleFactor * scaledSize.height
        }
        UIGraphicsBeginImageContext(scaledSize)
        draw(in: CGRect(origin: .zero, size: scaledSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
}
