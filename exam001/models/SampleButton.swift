//
//  SampleButton.swift
//  exam001
//
//  Created by Seif Ghotouk on 11/12/18.
//  Copyright © 2018 Adnan Al-Akhrass. All rights reserved.
//

import UIKit

protocol SampleButtonDelegate: class {
    func sampleButtonDidSetTitle(_ sampleButton: SampleButton)
}

class SampleButton: UIButton {
    public var title: String = "" {
        didSet {
            setTitle(title, for: .normal)
            guard let delegate = delegate else { return }
            delegate.sampleButtonDidSetTitle(self)
        }
    }
    private var color: UIColor?
    private var buttonAdds: Bool!
    private var textColor: UIColor?
    
    public weak var delegate: SampleButtonDelegate?
        
    convenience init(title: String, color: UIColor? = .darkGray, buttonAdds: Bool, textColor: UIColor? = .orange) {
        self.init()
        self.title = title
        self.color = color
        self.buttonAdds = buttonAdds
        self.textColor = textColor
        config()
    }
    
    private func config() {
        setTitle(title, for: .normal)
        backgroundColor = color
        isUserInteractionEnabled = true
        setTitleColor(textColor, for: .normal)
    }
    
}
