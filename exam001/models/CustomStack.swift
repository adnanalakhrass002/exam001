//
//  CustomStack.swift
//  exam001
//
//  Created by Seif Ghotouk on 11/12/18.
//  Copyright © 2018 Adnan Al-Akhrass. All rights reserved.
//

import UIKit

class CustomStack: UIStackView {
    private var stackAxis: NSLayoutConstraint.Axis?
    private var stackDistribution: UIStackView.Distribution?
    private var stackAlignment: UIStackView.Alignment?
    private var stackSpacing: CGFloat?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(sAxis: NSLayoutConstraint.Axis? = .vertical, sDist: UIStackView.Distribution, sAlignment: UIStackView.Alignment? = .center, sSpacing: CGFloat? = 15) {
        self.init()
        self.stackAxis = sAxis
        self.stackDistribution = sDist
        self.stackAlignment = sAlignment
        self.stackSpacing = sSpacing
        setupStack()
    }
    
    func setupStack() {
        self.axis = self.stackAxis!
        self.distribution = self.stackDistribution!
        self.alignment = self.stackAlignment!
        self.spacing = self.stackSpacing!
    }
}
