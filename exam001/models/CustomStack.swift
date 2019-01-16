//
//  CustomStack.swift
//  exam001
//
//  Created by Seif Ghotouk on 11/12/18.
//  Copyright © 2018 Adnan Al-Akhrass. All rights reserved.
//

import UIKit

class CustomStack: UIStackView {
    
    // MARK: - init
    convenience init(axis: NSLayoutConstraint.Axis?, distribution: UIStackView.Distribution?, alignment: UIStackView.Alignment?, spacing: CGFloat?) {
        self.init()
        self.axis = axis ?? .vertical
        self.distribution = distribution ?? .equalSpacing
        self.alignment = alignment ?? .center
        self.spacing = spacing ?? 0.0
    }
}
