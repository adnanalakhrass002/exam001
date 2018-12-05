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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init (fieldPlaceHolder: String, fieldColor: UIColor, fieldBorderStyle: UITextField.BorderStyle, xPad: CGFloat? = 10, ypad: CGFloat? = 10) {
        self.init()
        self.fPlaceHolder = fieldPlaceHolder
        self.fColor = fieldColor
        self.fBorder = fieldBorderStyle
        self.xPadding = xPad
        self.yPadding = ypad
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
}
