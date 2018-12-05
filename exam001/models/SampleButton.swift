//
//  SampleButton.swift
//  exam001
//
//  Created by Seif Ghotouk on 11/12/18.
//  Copyright © 2018 Adnan Al-Akhrass. All rights reserved.
//

import UIKit

class SampleButton: UIButton {
    private var title: String?
    private var color: UIColor?
    private var buttonAdds: Bool!
    private var textColor: UIColor?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
        
    convenience init(title: String, color: UIColor? = .darkGray, buttonAdds: Bool, textColor: UIColor? = .orange) {
        self.init()
        self.title = title
        self.color = color
        self.buttonAdds = buttonAdds
        self.textColor = textColor
        setup()
    }
    
    func setup() {
        self.setTitle(title, for: .normal)
        self.backgroundColor = color
        self.isUserInteractionEnabled = true
        self.setTitleColor(textColor, for: .normal)
        
    }
    
}

extension SampleButton {
    func setupLoginButton() {
        
    }
}
