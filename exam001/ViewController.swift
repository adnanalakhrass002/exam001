//
//  ViewController.swift
//  exam001
//
//  Created by Adnan Al-Akhrass on 11/8/18.
//  Copyright © 2018 Adnan Al-Akhrass. All rights reserved.
//

//

import UIKit

class StackViewModel : NSObject {
    // MARK: - Attributes
    
    // MARK: - Methods
    
    
}

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

class SampleBtn: UIButton {
    private var title: String?
    private var color: UIColor?
    private var buttonAdds: Bool!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(title: String, color: UIColor? = .red, buttonAdds: Bool) {
        self.init()
        self.title = title
        self.color = color
        self.buttonAdds = buttonAdds
        setup()
    }
    
    func setup() {
        self.setTitle(title, for: .normal)
        self.backgroundColor = color
        self.isUserInteractionEnabled = true
    }
}

class ViewController: UIViewController {
    
    // MARK: - Properties
    //task: make custom uitextfild classes with placeholder padding set to 10
    private var firstTextField: UITextField!
    private var secondTextField: UITextField!
    private var thirdTextField: UITextField!
    private var fourthTextField: UITextField!
    private var topButton: SampleBtn!
    private var bottomButton: UIButton!
    private var fillerView: UIView!
    private var stack: UIStackView!
    private var subStack: UIStackView!
    
    // MARK: - ViewModel
    public var viewModel: StackViewModel!
    
    // MARK: - Initializers
    public convenience init(viewModel: StackViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Setup Subviews
    private func setupViews() {
        view.backgroundColor = UIColor.gray
        setupStack()
        setupSubStack()
        setupFirstTF()
        setupSecondTF()
        setupThirdTF()
        setupFourthTF()
        setupTopBtn()
        setupBottomBtn()
        setupFillerView()
        addSubstackViews()
        addStackViews()
    }
    
    private func setupFirstTF() {
        firstTextField = UITextField().setupField(placeHolder: "First field", Color: UIColor.purple)
        self.view.addSubview(firstTextField)
        setupFirstTFConstraints()
    }
    
    private func setupSecondTF() {
        secondTextField = UITextField().setupField(placeHolder: "Second field", Color: UIColor.cyan)
        self.view.addSubview(secondTextField)
        setupSecondTFConstraints()
    }
    
    private func setupThirdTF() {
        thirdTextField = UITextField().setupField(placeHolder: "Third field", Color: UIColor.purple)
        self.view.addSubview(thirdTextField)
        setupThirdTFConstraints()
    }
    
    private func setupFourthTF() {
        fourthTextField = UITextField().setupField(placeHolder: "Fourth field", Color: UIColor.cyan)
        self.view.addSubview(fourthTextField)
        setupFourthTFConstraints()
    }
    
    private func setupTopBtn() {
        topButton = SampleBtn(title: "Turn to 2", buttonAdds: true)
        topButton.addTarget(self, action: #selector(topBtnTapped), for: .touchUpInside)
        self.view.addSubview(topButton)
        setupTopBtnConstraints()
    }
    
    private func setupBottomBtn() {
        bottomButton = SampleBtn(title: "Turn to 4", color: .red, buttonAdds: true)
        bottomButton.addTarget(self, action: #selector(bottomBtnTapped), for: .touchUpInside)
        self.view.addSubview(bottomButton)
        setupBottomBtnConstraint()
    }
    
    private func setupFillerView() {
        fillerView = UIView()
        fillerView.backgroundColor = UIColor.clear
        self.view.addSubview(fillerView)
        setupFillerViewConstraints()
    }
    
    private func setupSubStack() {
        subStack = CustomStack(sAxis: .vertical, sDist: .fill, sAlignment: .center, sSpacing: 15)
        self.view.addSubview(subStack)
        setupSubstackConstraints()
    }
    
    private func setupStack() {
        stack = CustomStack(sAxis: .vertical, sDist: .equalSpacing, sAlignment: .center)
        self.view.addSubview(stack)
        setupStackConstraints()
    }
    
    private func addSubstackViews() {
        subStack.addArrangedSubview(firstTextField)
        subStack.addArrangedSubview(secondTextField)
        subStack.addArrangedSubview(thirdTextField)
        subStack.addArrangedSubview(fourthTextField)
    }
    
    private func addStackViews() {
        stack.addArrangedSubview(subStack)
        stack.addArrangedSubview(topButton)
        stack.addArrangedSubview(bottomButton)
        stack.addArrangedSubview(fillerView)
    }
    
    // MARK: - Setup Subviews' Constraints
    private func setupFirstTFConstraints() {
        firstTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstTextField.rightAnchor.constraint(equalTo: subStack.rightAnchor),
            firstTextField.leftAnchor.constraint(equalTo: subStack.leftAnchor),
            firstTextField.topAnchor.constraint(equalTo: subStack.topAnchor, constant: 0),
            firstTextField.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    private func setupSecondTFConstraints() {
        secondTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondTextField.rightAnchor.constraint(equalTo: subStack.rightAnchor),
            secondTextField.leftAnchor.constraint(equalTo: subStack.leftAnchor),
            secondTextField.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    private func setupThirdTFConstraints() {
        thirdTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thirdTextField.rightAnchor.constraint(equalTo: subStack.rightAnchor),
            thirdTextField.leftAnchor.constraint(equalTo: subStack.leftAnchor),
            thirdTextField.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    private func setupFourthTFConstraints() {
        fourthTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fourthTextField.rightAnchor.constraint(equalTo: subStack.rightAnchor),
            fourthTextField.leftAnchor.constraint(equalTo: subStack.leftAnchor),
            fourthTextField.bottomAnchor.constraint(equalTo: subStack.bottomAnchor, constant: 0),
            fourthTextField.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    private func setupTopBtnConstraints() {
        topButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topButton.rightAnchor.constraint(equalTo: stack.rightAnchor),
            topButton.leftAnchor.constraint(equalTo: stack.leftAnchor),
            topButton.topAnchor.constraint(equalTo: subStack.bottomAnchor, constant: 15),
            topButton.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    private func setupBottomBtnConstraint() {
        bottomButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomButton.rightAnchor.constraint(equalTo: stack.rightAnchor),
            bottomButton.leftAnchor.constraint(equalTo: stack.leftAnchor),
            bottomButton.topAnchor.constraint(equalTo: topButton.bottomAnchor, constant: 15),
            bottomButton.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    private func setupFillerViewConstraints() {
        fillerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fillerView.rightAnchor.constraint(equalTo: stack.rightAnchor),
            fillerView.leftAnchor.constraint(equalTo: stack.leftAnchor),
            fillerView.topAnchor.constraint(equalTo: bottomButton.bottomAnchor, constant: 15)
            ])
    }
    
    private func setupStackConstraints() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20)
            ])
    }
    
    private func setupSubstackConstraints() {
        subStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subStack.rightAnchor.constraint(equalTo: stack.rightAnchor),
            subStack.leftAnchor.constraint(equalTo: stack.leftAnchor)
            ])
    }
    
    // MARK: - Actions
    @objc func topBtnTapped() {
        UIView.animate(withDuration: 2.0, animations: {
            self.subStack.removeArrangedSubview(self.secondTextField)
            self.subStack.removeArrangedSubview(self.fourthTextField)
            self.view.layoutIfNeeded()
        })
        
        //        let vc =
        //        self.present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
    }
    
    @objc func bottomBtnTapped() {
        UIView.animate(withDuration: 2.0, animations: {
            self.subStack.insertArrangedSubview(self.secondTextField, at: 1)
            self.subStack.insertArrangedSubview(self.fourthTextField, at: 3)
            self.view.layoutIfNeeded()
        })
        
    }
}

extension UITextField {
    func setupField(placeHolder: String, Color: UIColor) -> UITextField {
        let textfield = UITextField()
        textfield.isUserInteractionEnabled = true
        textfield.borderStyle = .line
        textfield.placeholder = placeHolder
        textfield.backgroundColor = Color
        return textfield
    }
    
}
