//
//  UIButtonExt.swift
//  Summary
//
//  Created by Sahil Chaudhary on 05/03/18.
//  Copyright © 2018 Sahil Chaudhary. All rights reserved.
//

import UIKit
extension UIButton {
    open override func awakeFromNib() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 15
        self.layer.shadowOpacity = 0.20
        self.layer.cornerRadius = self.frame.height / 2
    }
}
