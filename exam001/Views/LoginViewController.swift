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

class LoginViewController: UIViewController, FireBaseModelDelegate {

    private var firstTextField: CustomTextField!
    private var secondTextField: CustomTextField!
    private var Button: SampleButton!
    private var fireBaseModel: fireBaseViewModel!

    public convenience init(_ fireviewModel: fireBaseViewModel) {
        self.init()
        self.fireBaseModel = fireviewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGray
        setupSubViews()
        fireBaseModel = fireBaseViewModel(self)
    }

    func setupSubViews() {
        setupFirstTextField()
        setupSecondTextField()
        setupButton()
    }

    func setupFirstTextField() {
        firstTextField = CustomTextField(fieldPlaceHolder: "User Name", fieldColor: .orange, fieldBorderStyle: .line)
        view.addSubview(firstTextField)
        seupFirstFieldConstraints()
        
    }

    func setupSecondTextField() {
        secondTextField = CustomTextField(fieldPlaceHolder: "Password", fieldColor: .orange, fieldBorderStyle: .line)
        secondTextField.isSecureTextEntry = true
        view.addSubview(secondTextField)
        setupSecondFieldConstraints()
    }

    func setupButton() {
        Button = SampleButton(title: "Sign In", buttonAdds: true)
        Button.addTarget(self, action: #selector(Login), for: .touchUpInside)
        Button.layer.cornerRadius = 20
        Button.layer.borderWidth = 1
        Button.layer.borderColor = UIColor.orange.cgColor
        Button.clipsToBounds = true
        view.addSubview(Button)
        setupButtonConstraints()
    }

    func seupFirstFieldConstraints() {
        firstTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstTextField.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            firstTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            firstTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20)
            ])
    }

    func setupSecondFieldConstraints() {
        secondTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondTextField.topAnchor.constraint(equalTo: firstTextField.bottomAnchor,constant: 20),
            secondTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            secondTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
            ])
    }

    func setupButtonConstraints() {
        Button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            Button.topAnchor.constraint(equalTo: secondTextField.bottomAnchor, constant: 50),
            Button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            Button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
            ])
    }
    
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
                            guard let user = authResult?.user else { return }
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
    
}
