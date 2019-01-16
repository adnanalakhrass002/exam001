//
//  LoginViewController.swift
//  exam001
//
//  Created by Seif Ghotouk on 11/20/18.
//  Copyright © 2018 Adnan Al-Akhrass. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    enum Config {
        static let subViewHorizontalAnchor: CGFloat = 20.0
        static let secondTextfieldBottomAnchor: CGFloat = 20.0
        static let buttonTopAnchor: CGFloat = 50.0
        static let alamoButtonTopAnchor: CGFloat = 20.0
    }
    
    private lazy var androidTextField: AndroidTextField! = {
        let androidTextField = AndroidTextField(withPlaceholder: "this should go up", themeColor: .orange, 15.0)
        androidTextField.delegate = self
        return androidTextField
    }()
    
    private lazy var firstTextField: CustomTextField! = {
        let firstTextField = CustomTextField(fieldPlaceHolder: "User Name OR request type (post/get/delete/json)", fieldColor: .orange, fieldBorderStyle: .line)
        return firstTextField
    }()
    
    private lazy var secondTextField: CustomTextField! = {
        let secondTextField = CustomTextField(fieldPlaceHolder: "Password", fieldColor: .orange, fieldBorderStyle: .line)
        secondTextField.isSecureTextEntry = true
        return secondTextField
    }()
    
    private lazy var Button: SampleButton! = {
        let Button = SampleButton(title: "Sign In", buttonAdds: true)
        Button.addTarget(self, action: #selector(Login), for: .touchUpInside)
        Button.layer.cornerRadius = 20
        Button.layer.borderWidth = 1
        Button.layer.borderColor = UIColor.orange.cgColor
        Button.clipsToBounds = true
        Button.delegate = self
        return Button
    }()
    
    private lazy var alamoButton: SampleButton! = {
        let alamoButton = SampleButton(title: "Request", buttonAdds: true)
        alamoButton.addTarget(self, action: #selector(Request), for: .touchUpInside)
        alamoButton.layer.cornerRadius = 20
        alamoButton.layer.borderWidth = 1
        alamoButton.layer.borderColor = UIColor.orange.cgColor
        alamoButton.clipsToBounds = true
        return alamoButton
    }()
    
    private var fireBaseModel: fireBaseViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        fireBaseModel = fireBaseViewModel(self)
        Button.title = "Updated"
    }
    
    func setupSubViews() {
        view.backgroundColor = .darkGray
        setupFirstTextField()
        setupSecondTextField()
        setupButton()
        setupAlamoButton()
        
        setupAndroidTextField()
    }

    func setupFirstTextField() {
        view.addSubview(firstTextField)
        setupFirstFieldConstraints()
        
    }

    func setupSecondTextField() {
        view.addSubview(secondTextField)
        setupSecondFieldConstraints()
    }

    func setupButton() {
        view.addSubview(Button)
        setupButtonConstraints()
    }
    
    func setupAlamoButton() {
        view.addSubview(alamoButton)
        setupAlamoButtonConstraints()
    }
    func setupAndroidTextField() {
        view.addSubview(androidTextField)
        setupAndroidTextFieldConstrants()
    }

    func setupFirstFieldConstraints() {
        firstTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstTextField.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            firstTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -Config.subViewHorizontalAnchor),
            firstTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Config.subViewHorizontalAnchor)
            ])
    }

    func setupSecondFieldConstraints() {
        secondTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondTextField.topAnchor.constraint(equalTo: firstTextField.bottomAnchor,constant: Config.secondTextfieldBottomAnchor),
            secondTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Config.subViewHorizontalAnchor),
            secondTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -Config.subViewHorizontalAnchor)
            ])
    }

    func setupButtonConstraints() {
        Button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            Button.topAnchor.constraint(equalTo: secondTextField.bottomAnchor, constant: Config.buttonTopAnchor),
            Button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Config.subViewHorizontalAnchor),
            Button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Config.subViewHorizontalAnchor)
            ])
    }
    
    func setupAlamoButtonConstraints() {
        alamoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alamoButton.topAnchor.constraint(equalTo: Button.bottomAnchor, constant: Config.alamoButtonTopAnchor),
            alamoButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Config.subViewHorizontalAnchor),
            alamoButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Config.subViewHorizontalAnchor)
            ])
    }
    
    func setupAndroidTextFieldConstrants() {
        androidTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            androidTextField.bottomAnchor.constraint(equalTo:firstTextField.topAnchor),
            androidTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:Config.subViewHorizontalAnchor),
            androidTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:Config.subViewHorizontalAnchor),
            androidTextField.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
}

extension LoginViewController {
    // MARK: - Actions
    @objc func Login() {
        print("login tapped")
        Auth.auth().signIn(withEmail: firstTextField.text!, password: secondTextField.text!) { (user, error) in
            if let e = error {
                let alert = UIAlertController(title: "Error", message: e.localizedDescription + "Do you wish to create an account using those credintials?", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel) {
                    UIAlertAction in
                    NSLog("Don't create account")
                }
                let createAction = UIAlertAction(title: "Create Account", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    NSLog("create account")
                    Auth.auth().createUser(withEmail: self.firstTextField.text!, password: self.secondTextField.text!) { (authResult, error) in
                        // ...
                        if error == nil {
                            guard let result = authResult else { return }
                            let user = result.user
                            let vc = ViewController()
                            let nc = UINavigationController(rootViewController: vc)
                            UIApplication.shared.keyWindow?.rootViewController = nc
                            UIApplication.shared.keyWindow?.makeKeyAndVisible()
                        }
                    }
                }
                alert.addAction(okAction)
                alert.addAction(createAction)
                self.present(alert, animated: true, completion: nil)
                print(e.localizedDescription)
            }
            else {
                let vc = ViewController()
                let nc = UINavigationController(rootViewController: vc)
                UIApplication.shared.keyWindow?.rootViewController = nc
                UIApplication.shared.keyWindow?.makeKeyAndVisible()
            }
        }
    }
    
    @objc func Request() {
        if firstTextField.text != nil {
            fireBaseModel.performRequest(firstTextField.text!)
        } else {
            print("no request value entered")
        }
    }
}

extension LoginViewController: FireBaseModelDelegate {
    
    public convenience init(_ fireviewModel: fireBaseViewModel) {
        self.init()
        self.fireBaseModel = fireviewModel
    }

    
}

extension LoginViewController: SampleButtonDelegate {
    func sampleButtonDidSetTitle(_ sampleButton: SampleButton) {
        print("did set title")
        sampleButton.backgroundColor = .blue
    }
}

extension LoginViewController: AndroidTextFieldDelegate {
    func androidTextFieldDidBeginEditing(_ androidTextField: AndroidTextField) {
        androidTextField.animateLabelPosition()
    }
    
    func androidTextFieldDidEndEditing(_ androidTextField: AndroidTextField) {
        androidTextField.resetLabelPosition()
    }
    
    
}
