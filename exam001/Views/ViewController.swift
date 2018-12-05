//
//  ViewController.swift
//  exam001
//
//  Created by Adnan Al-Akhrass on 11/8/18.
//  Copyright © 2018 Adnan Al-Akhrass. All rights reserved.
//

//

import UIKit
import Firebase

enum textfieldIndex: Int {
    case first
    case second
    case third
    case fourth
}

struct Requestes {
    var fullName: String
    var floor: String
    var location: String
    var items: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FireBaseModelDelegate {

    // MARK: - Properties
    private var firstTextField: CustomTextField!
    private var secondTextField: CustomTextField!
    private var thirdTextField: CustomTextField!
    private var fourthTextField: CustomTextField!
    private var topButton: SampleButton!
    private var bottomButton: SampleButton!
    private var submitButton: SampleButton!
    private var fillerView: UIView!
    private var stack: CustomStack!
    private var subStack: CustomStack!
    private var table: UITableView!
    private var scrollView: UIScrollView!
    private var containerView: UIView!
    private var cellcount: Int = 0
    
    // MARK: - ViewModel
    public var fireBaseModel: fireBaseViewModel!
    public var viewModel: StackViewModel!
    
    // MARK: - Initializers
    public convenience init(_ viewModel: StackViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    public convenience init(_ fireviewModel: fireBaseViewModel) {
        self.init()
        self.fireBaseModel = fireviewModel
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.darkGray
        self.title = "Home"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
        
        fireBaseModel = fireBaseViewModel(self)
        viewModel = StackViewModel(self)
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData(0, 13)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fireBaseModel.clearData()
        loadData(0, cellcount)
        table.reloadData()
    }
    
    // MARK: - Setup Subviews
    private func setupViews() {
        view.backgroundColor = UIColor.darkGray
        
        setupScrollView()
        setupStack()
        setupSubStack()
        setupFirstTF()
        setupSecondTF()
        setupThirdTF()
        setupFourthTF()
//        setupTopBtn()
//        setupBottomBtn()
        setupSubmitBtn()
        setupTableView()
        setupFillerView()
        addSubstackViews()
        addStackViews()
    }
    
    private func setupScrollView() {
        
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(containerView)
        
//        let lbl = UILabel()
//        lbl.backgroundColor = UIColor.red
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        containerView.addSubview(lbl)
//
//        let lbl2 = UILabel()
//        lbl2.backgroundColor = UIColor.yellow
//        lbl2.translatesAutoresizingMaskIntoConstraints = false
//        containerView.addSubview(lbl2)
        
        NSLayoutConstraint.activate([
            // rule 1
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            
            // rule 2
            containerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
//            lbl.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            lbl.leftAnchor.constraint(equalTo: containerView.leftAnchor),
//            lbl.widthAnchor.constraint(equalTo: containerView.widthAnchor),
//            lbl.heightAnchor.constraint(equalToConstant: 40),
//
//            // rule 4
//            lbl2.topAnchor.constraint(equalTo: lbl.bottomAnchor, constant: 800),
//            lbl2.leftAnchor.constraint(equalTo: lbl.leftAnchor),
//            lbl2.widthAnchor.constraint(equalTo: lbl.widthAnchor),
//            lbl2.bottomAnchor.constraint(equalTo: containerView.bottomAnchor), // should be added on last item inside the container
//            lbl2.heightAnchor.constraint(equalToConstant: 40),
            
        ])
        
        // rule 3
        let containerHeightConstraint = containerView.heightAnchor.constraint(equalTo: view.heightAnchor)
        containerHeightConstraint.priority = UILayoutPriority(250)
        containerHeightConstraint.isActive = true
        
    }
    
    private func setupFirstTF() {
        firstTextField = CustomTextField(fieldPlaceHolder: viewModel.fieldsArray[textfieldIndex.first.rawValue], fieldColor: .orange, fieldBorderStyle: .line)
        self.containerView.addSubview(firstTextField)
        setupFirstTFConstraints()
    }
    
    private func setupSecondTF() {
        secondTextField = CustomTextField(fieldPlaceHolder: viewModel.fieldsArray[textfieldIndex.second.rawValue], fieldColor: .orange, fieldBorderStyle: .line)
        self.containerView.addSubview(secondTextField)
        setupSecondTFConstraints()
    }
    
    private func setupThirdTF() {
        thirdTextField = CustomTextField(fieldPlaceHolder: viewModel.fieldsArray[textfieldIndex.third.rawValue], fieldColor: .orange, fieldBorderStyle: .line, xPad: 10)
        self.containerView.addSubview(thirdTextField)
        setupThirdTFConstraints()
    }
    
    private func setupFourthTF() {
        fourthTextField = CustomTextField(fieldPlaceHolder: viewModel.fieldsArray[textfieldIndex.fourth.rawValue], fieldColor: .orange, fieldBorderStyle: .line, ypad: 10)
        self.containerView.addSubview(fourthTextField)
        setupFourthTFConstraints()
    }
    
//    private func setupTopBtn() {
//        topButton = SampleButton(title: "Turn to 2",buttonAdds: true)
//        topButton.addTarget(self, action: #selector(topBtnTapped), for: .touchUpInside)
//        topButton.layer.cornerRadius = 20
//        topButton.layer.borderWidth = 1
//        topButton.layer.borderColor = UIColor.orange.cgColor
//        topButton.clipsToBounds = true
//        self.containerView.addSubview(topButton)
//        setupTopBtnConstraints()
//    }
//
//    private func setupBottomBtn() {
//        bottomButton = SampleButton(title: "turn to 4", color: .darkGray, buttonAdds: true)
//        bottomButton.addTarget(self, action: #selector(bottomBtnTapped), for: .touchUpInside)
//        bottomButton.layer.cornerRadius = 20
//        bottomButton.layer.borderWidth = 1
//        bottomButton.layer.borderColor = UIColor.orange.cgColor
//        bottomButton.clipsToBounds = true
//        self.containerView.addSubview(bottomButton)
//        setupBottomBtnConstraint()
//    }
    
    private func setupSubmitBtn() {
        submitButton = SampleButton(title: "Submit", color: .darkGray, buttonAdds: true)
        submitButton.addTarget(self, action: #selector(submitBtnTapped), for: .touchUpInside)
        submitButton.layer.cornerRadius = 20
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.orange.cgColor
        submitButton.clipsToBounds = true
        self.containerView.addSubview(submitButton)
        setupSubmitBtnConstraint()
    }
    
    private func setupTableView() {
        table = UITableView()
        table.backgroundColor = UIColor.gray
        table.register(DevCell.self, forCellReuseIdentifier: "DevCell")
        self.containerView.addSubview(table)
        setupTableViewConstraints()
    }
    
    private func setupFillerView() {
        fillerView = UIView()
        fillerView.backgroundColor = UIColor.clear
        self.containerView.addSubview(fillerView)
        setupFillerViewConstraints()
    }
    
    private func setupSubStack() {
        subStack = CustomStack(sAxis: .vertical, sDist: .fill, sAlignment: .center, sSpacing: 15)
        self.containerView.addSubview(subStack)
        setupSubstackConstraints()
    }
    
    private func setupStack() {
        stack = CustomStack(sAxis: .vertical, sDist: .equalSpacing, sAlignment: .center)
        self.containerView.addSubview(stack)
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
//        stack.addArrangedSubview(topButton)
//        stack.addArrangedSubview(bottomButton)
        stack.addArrangedSubview(submitButton)
        stack.addArrangedSubview(table)
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
    
    private func setupSubmitBtnConstraint() {
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            submitButton.rightAnchor.constraint(equalTo: stack.rightAnchor),
            submitButton.leftAnchor.constraint(equalTo: stack.leftAnchor),
            submitButton.topAnchor.constraint(equalTo: subStack.bottomAnchor, constant: 15),
            submitButton.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    private func setupTableViewConstraints() {
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            table.rightAnchor.constraint(equalTo: stack.rightAnchor),
            table.leftAnchor.constraint(equalTo: stack.leftAnchor),
            table.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 15),
//            table.heightAnchor.constraint(equalToConstant: 500)
            table.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
            table.bottomAnchor.constraint(equalTo: stack.bottomAnchor, constant: -30)
            ])
    }
    
    private func setupFillerViewConstraints() {
        fillerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fillerView.rightAnchor.constraint(equalTo: stack.rightAnchor),
            fillerView.leftAnchor.constraint(equalTo: stack.leftAnchor),
            fillerView.topAnchor.constraint(equalTo: table.bottomAnchor, constant: 15),
            fillerView.bottomAnchor.constraint(equalTo: stack.bottomAnchor)
            ])
    }
    
    private func setupStackConstraints() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            stack.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 20),
//            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20)
            stack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20), // should be added on last item inside the container
            ])
    }
    
    private func setupSubstackConstraints() {
        subStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subStack.rightAnchor.constraint(equalTo: stack.rightAnchor),
            subStack.leftAnchor.constraint(equalTo: stack.leftAnchor)
            ])
    }
    
    // MARK: - tablview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fireBaseModel.getTableDatasize()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DevCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "DevCell")
        cell.cellIndex = indexPath.row
        let singleCellData: NSDictionary = fireBaseModel.getTableData(indexPath.row)
        let location = singleCellData[self.viewModel.fieldsArray[3]] as? String ?? ""
        let stat = singleCellData["Status"] as? String ?? ""
        cell.textLabel!.text = location
        cell.detailTextLabel?.text = stat
        cell.textLabel?.textColor = UIColor.orange
        cell.backgroundColor = UIColor.darkGray
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print(fireBaseModel.tableCellDataArray[indexPath.row] as Any)
        if let dictv = fireBaseModel.tableCellDataArray[indexPath.row] {
            firstTextField.text = dictv[self.viewModel.fieldsArray[0]] as? String
            secondTextField.text = dictv[self.viewModel.fieldsArray[1]] as? String
            thirdTextField.text = dictv[self.viewModel.fieldsArray[2]] as? String
            fourthTextField.text = dictv[self.viewModel.fieldsArray[3]] as? String
        }
        if let navigationController = self.navigationController {
            print("T##items: Any...##Any")
            print(indexPath.row)
            print("T##items: Any...##Any")
            let detailViewController = RequestDetailsViewController(fireBaseModel.tableCellDataArray[indexPath.row] as! NSDictionary,indexPath.row)
            navigationController.pushViewController(detailViewController, animated: true)
        }
//        let vc = RequestDetailsViewController()
//        self.present(vc, animated: true, completion: nil)

    }
    
    // MARK: - Actions
    @objc func topBtnTapped() {
        UIView.animate(withDuration: 2.0, animations: {
            self.subStack.removeArrangedSubview(self.secondTextField)
            self.subStack.removeArrangedSubview(self.fourthTextField)
            self.containerView.layoutIfNeeded()
        })
        
    }
    
    @objc func bottomBtnTapped() {
        UIView.animate(withDuration: 2.0, animations: {
            self.subStack.insertArrangedSubview(self.secondTextField, at: 1)
            self.subStack.insertArrangedSubview(self.fourthTextField, at: 3)
            self.containerView.layoutIfNeeded()
        })
        
    }
    
    @objc func submitBtnTapped() {
        if (firstTextField.text?.isEmpty)! || (secondTextField.text?.isEmpty)! || (thirdTextField.text?.isEmpty)! || (fourthTextField.text?.isEmpty)! {
            let alert = UIAlertController(title: "Oops", message: "You missed a field!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Let me check", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
        let entry = Requestes(fullName: firstTextField.text!, floor: secondTextField.text!, location: thirdTextField.text!, items: fourthTextField.text!)
            fireBaseModel.appendNewEntry(entry,  completion: { (success) in
                self.firstTextField.text = ""
                self.secondTextField.text = ""
                self.thirdTextField.text = ""
                self.fourthTextField.text = ""
                self.table.reloadData()
                let alert = UIAlertController(title: "Success", message: "Request submitted!", preferredStyle: UIAlertController.Style.actionSheet)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            })
        }
    }
    
}

extension ViewController: ViewModelDelegate {
    func didAddData(_ index: Int) {
        
    }
    
    // ViewModel Delegates
    func didUpdateData() {
        print("did update")
        }
    
    func loadData(_ offset: Int, _ limit: Int) {
        table.dataSource = self
        table.delegate = self
        self.fireBaseModel.getCellDataFromFirebase(offset, limit, completion: { (success) in
            self.table.reloadData()
        })
    }
}

//refresh data when scroll hits last cell
extension ViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == table {
            if table.visibleCells.count > 0 {
                let lastVisibleCell = table.visibleCells[table.visibleCells.count-1] as! DevCell
                if lastVisibleCell.cellIndex == fireBaseModel.tableCellDataArray.count - 1 {
                    loadData(fireBaseModel.tableCellDataArray.count, 13)
                }
            }
        }
    }
}
