//
//  AndroidTextField.swift
//  exam001
//
//  Created by Seif Ghotouk on 1/9/19.
//  Copyright © 2019 Adnan Al-Akhrass. All rights reserved.
//

import UIKit

enum Config {
    static let heightConstraint: CGFloat = 20.0
}

protocol AndroidTextFieldDelegate: class {
    func androidTextFieldDidBeginEditing(_ androidTextField: AndroidTextField)
    func androidTextFieldDidEndEditing(_ androidTextField: AndroidTextField)
}

class AndroidTextField: UIView {
    // MARK: - Properties
    private var placeholder: String?
    private var color: UIColor?
    private var padding : CGFloat?
    public weak var textFieldDelegate: UITextFieldDelegate?
    
    private var topConstraint: NSLayoutConstraint?
    
    private lazy var label: UILabel = {
        let label = UILabel()
        if let placeholder = placeholder {
            label.text = placeholder
        }
        label.font = label.font.withSize(20)
        label.textColor = color
        return label
    }()
    
    public lazy var textField: CustomTextField = {
        guard let color = color,
              let padding = padding else { return CustomTextField() }
        let textField = CustomTextField(fieldPlaceHolder: "", fieldColor: .clear, fieldBorderStyle: .none, xPad: padding, ypad: padding)
        textField.delegate = self

        return textField
    }()
    
    public weak var delegate: AndroidTextFieldDelegate?

    convenience init(withPlaceholder placeHolder: String? = "", themeColor color: UIColor?, _ padding: CGFloat) {
        self.init()
        self.placeholder = placeHolder
        self.color = color
        self.padding = padding
        backgroundColor = .clear
        setupView()
        textFieldDelegate = self
    }
    // MARK: - Setup
    
    private func setupView() {
        addTextField()
        addLabel()
    }
    
    private func addLabel() {
        addSubview(label)
        setupLabelConstraints()
    }
    
    private func addTextField() {
        addSubview(textField)
        setupTextFieldCostraints()
    }
    // MARK: - Constraints
    private func setupLabelConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: Config.heightConstraint)
            ])
        
        topConstraint = label.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
        topConstraint?.isActive = true
    }
    
    private func setupTextFieldCostraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8)
        ])
    }
    
    public func animateLabelPosition() {
        topConstraint?.isActive = false
        topConstraint = label.bottomAnchor.constraint(equalTo: textField.topAnchor)
        topConstraint?.isActive = true
        label.font = label.font.withSize(15)
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let `self` = self else { return }
            self.layoutIfNeeded()
        }
    }
    
    public func resetLabelPosition() {
        if textField.text == "" {
            topConstraint?.isActive = false
            topConstraint = label.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
            topConstraint?.isActive = true
            label.font = label.font.withSize(20)
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard let `self` = self else { return }
                self.layoutIfNeeded()
            }
        }
    }
}

extension AndroidTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let delegate = delegate else { return }
        delegate.androidTextFieldDidBeginEditing(self)
        
        guard let textField = textField as? CustomTextField else { return }
        textField.changetextcolor(.orange)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let delegate = delegate else { return }
        delegate.androidTextFieldDidEndEditing(self)
        
        guard let textField = textField as? CustomTextField else { return }
        textField.changetextcolor(.gray)
    }
}
