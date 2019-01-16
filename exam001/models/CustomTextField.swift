//
//  CustomTextField.swift
//  exam001
//
//  Created by Seif Ghotouk on 11/12/18.
//  Copyright © 2018 Adnan Al-Akhrass. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    private var fPlaceHolder: String?
    private var fColor: UIColor?
    private var fBorder: UITextField.BorderStyle?
    private var xPadding:CGFloat?
    private var yPadding: CGFloat?
    
    convenience init (fieldPlaceHolder: String, fieldColor: UIColor, fieldBorderStyle: UITextField.BorderStyle, xPad: CGFloat? = 10, ypad: CGFloat? = 10) {
        self.init()
        fPlaceHolder = fieldPlaceHolder
        fColor = fieldColor
        fBorder = fieldBorderStyle
        xPadding = xPad
        yPadding = ypad
        setupField()
    }
    
    func setupField() {
        self.isUserInteractionEnabled = true
        self.borderStyle = fBorder!
        self.placeholder = fPlaceHolder!
        self.backgroundColor = fColor!
    }
    
    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: xPadding!, dy: yPadding!)
    }
    
    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: xPadding!, dy: yPadding!)
    }
    
    public func changetextcolor(_ color: UIColor?){
        guard let color = color else { return }
        self.textColor = color
    }
}
