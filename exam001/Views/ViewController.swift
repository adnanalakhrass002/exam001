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

// Adnan: Always use initializers to pass data
// Data retrieved from API might sometimes contain nil value, so we use optionals to avoid possible crashes.
struct Requestes {
    var fullName: String
    var floor: String
    var location: String
    var items: String
    
    public init(_ fullname: String,_ floor: String,_ location: String,_ items: String) {
        self.fullName = fullname
        self.floor = floor
        self.location = location
        self.items = items
    }
}

class ViewController: UIViewController {

    // MARK: - Properties
    private lazy var firstTextField: CustomTextField = {
        let textField = CustomTextField(fieldPlaceHolder: viewModel.fieldsArray[textfieldIndex.first.rawValue], fieldColor: .orange, fieldBorderStyle: .line)
        return textField
    }()
    
    private lazy var secondTextField: CustomTextField! = {
        let secondTextField = CustomTextField(fieldPlaceHolder: viewModel.fieldsArray[textfieldIndex.second.rawValue], fieldColor: .orange, fieldBorderStyle: .line)
        return secondTextField
    }()

    private lazy var thirdTextField: CustomTextField! = {
        let thirdTextField = CustomTextField(fieldPlaceHolder: viewModel.fieldsArray[textfieldIndex.third.rawValue], fieldColor: .orange, fieldBorderStyle: .line, xPad: 10)
        return thirdTextField
    }()
    
    private lazy var fourthTextField: CustomTextField! = {
        let fourthTextField = CustomTextField(fieldPlaceHolder: viewModel.fieldsArray[textfieldIndex.fourth.rawValue], fieldColor: .orange, fieldBorderStyle: .line, ypad: 10)
        return fourthTextField
    }()
    
    private var topButton: SampleButton!
    
    private var bottomButton: SampleButton!
    
    private lazy var submitButton: SampleButton = { [weak self] in
        let submitButton = SampleButton(title: "Submit", color: .darkGray, buttonAdds: true)
        submitButton.addTarget(self, action: #selector(submitBtnTapped), for: .touchUpInside)
        submitButton.layer.cornerRadius = 20
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.orange.cgColor
        submitButton.clipsToBounds = true
        return submitButton
    }()
    
    private lazy var fillerView: UIView = {
        let fillerView = UIView()
        fillerView.backgroundColor = .clear
        return fillerView
    }()
    
    private lazy var stack: CustomStack = {
        return createStackViewWithDistribution(.equalSpacing, andSpacing: 15.0)
    }()
    
    private lazy var subStack: CustomStack = {
        return createStackViewWithDistribution(.fill, andSpacing: 15.0)
    }()
    
    // ADNAN: -
    private func createStackViewWithDistribution(_ dist: UIStackView.Distribution, andSpacing spacing: CGFloat) -> CustomStack {
        return CustomStack(axis: .vertical, distribution: dist, alignment: .center, spacing: spacing)
    }
    
    private lazy var table: UITableView! = { [weak self] in
//        guard let `self` = self else { return UITableView() } //use this if weak self causes an error in the block
        let table = UITableView()
        table.backgroundColor = .gray
        table.register(DevCell.self, forCellReuseIdentifier: "DevCell")
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    private lazy var scrollView: UIScrollView! = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var containerView: UIView! = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private var cellcount: Int = 0
    
    enum Config {
        static let heightAnchor: CGFloat = 50.0
        static let firstTextFieldTopAnchor: CGFloat = 0.0
        static let fourthTextFieldTopAnchor: CGFloat = 0.0
        static let TopAnchor: CGFloat = 15.0
        static let tableHeight: CGFloat = 400.0
        static let tableBottomAnchor: CGFloat = -30.0
        static let stackPadding: CGFloat = 20.0
    }
    
    // MARK: - ViewModel
    public var fireBaseModel: fireBaseViewModel!
    public var viewModel: StackViewModel!
    
    // MARK: - Initializers
    public convenience init(_ viewModel: StackViewModel) {
        self.init()
        self.viewModel = viewModel
        self.viewModel.stackViewModelDelegate = self
    }
    
    public convenience init(_ fireviewModel: fireBaseViewModel) {
        self.init()
        self.fireBaseModel = fireviewModel
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
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
    private func setupNavigationBar() {
        guard let navigationController = navigationController else { return }
        navigationController.navigationBar.barTintColor = .darkGray
        self.title = "Home"
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.orange]
    }
    
    private func setupViews() {
        view.backgroundColor = .darkGray
        
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
        
        view.addSubview(scrollView)
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
        containerView.addSubview(firstTextField)
        setupFirstTFConstraints()
    }
    
    private func setupSecondTF() {
        containerView.addSubview(secondTextField)
        setupSecondTFConstraints()
    }
    
    private func setupThirdTF() {
        containerView.addSubview(thirdTextField)
        setupThirdTFConstraints()
    }
    
    private func setupFourthTF() {
        containerView.addSubview(fourthTextField)
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
        containerView.addSubview(submitButton)
        setupSubmitBtnConstraint()
    }
    
    private func setupTableView() {
        containerView.addSubview(table)
        setupTableViewConstraints()
    }
    
    private func setupFillerView() {
        containerView.addSubview(fillerView)
        setupFillerViewConstraints()
    }
    
    private func setupSubStack() {
        containerView.addSubview(subStack)
        setupSubstackConstraints()
    }
    
    private func setupStack() {
        containerView.addSubview(stack)
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
            firstTextField.topAnchor.constraint(equalTo: subStack.topAnchor, constant: Config.firstTextFieldTopAnchor),
            firstTextField.heightAnchor.constraint(equalToConstant: Config.heightAnchor)
            ])
    }
    
    private func setupSecondTFConstraints() {
        secondTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondTextField.rightAnchor.constraint(equalTo: subStack.rightAnchor),
            secondTextField.leftAnchor.constraint(equalTo: subStack.leftAnchor),
            secondTextField.heightAnchor.constraint(equalToConstant: Config.heightAnchor)
            ])
    }
    
    private func setupThirdTFConstraints() {
        thirdTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thirdTextField.rightAnchor.constraint(equalTo: subStack.rightAnchor),
            thirdTextField.leftAnchor.constraint(equalTo: subStack.leftAnchor),
            thirdTextField.heightAnchor.constraint(equalToConstant: Config.heightAnchor)
            ])
    }
    
    private func setupFourthTFConstraints() {
        fourthTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fourthTextField.rightAnchor.constraint(equalTo: subStack.rightAnchor),
            fourthTextField.leftAnchor.constraint(equalTo: subStack.leftAnchor),
            fourthTextField.bottomAnchor.constraint(equalTo: subStack.bottomAnchor, constant: Config.fourthTextFieldTopAnchor),
            fourthTextField.heightAnchor.constraint(equalToConstant: Config.heightAnchor)
            ])
    }
    
    private func setupTopBtnConstraints() {
        topButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topButton.rightAnchor.constraint(equalTo: stack.rightAnchor),
            topButton.leftAnchor.constraint(equalTo: stack.leftAnchor),
            topButton.topAnchor.constraint(equalTo: subStack.bottomAnchor, constant: Config.TopAnchor),
            topButton.heightAnchor.constraint(equalToConstant: Config.heightAnchor)
            ])
    }
    
    private func setupBottomBtnConstraint() {
        bottomButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomButton.rightAnchor.constraint(equalTo: stack.rightAnchor),
            bottomButton.leftAnchor.constraint(equalTo: stack.leftAnchor),
            bottomButton.topAnchor.constraint(equalTo: topButton.bottomAnchor, constant: Config.TopAnchor),
            bottomButton.heightAnchor.constraint(equalToConstant: Config.heightAnchor)
            ])
    }
    
    private func setupSubmitBtnConstraint() {
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            submitButton.rightAnchor.constraint(equalTo: stack.rightAnchor),
            submitButton.leftAnchor.constraint(equalTo: stack.leftAnchor),
            submitButton.topAnchor.constraint(equalTo: subStack.bottomAnchor, constant: Config.TopAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: Config.heightAnchor)
            ])
    }
    
    private func setupTableViewConstraints() {
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            table.rightAnchor.constraint(equalTo: stack.rightAnchor),
            table.leftAnchor.constraint(equalTo: stack.leftAnchor),
            table.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: Config.TopAnchor),
            table.heightAnchor.constraint(greaterThanOrEqualToConstant: Config.tableHeight),
            table.bottomAnchor.constraint(equalTo: stack.bottomAnchor, constant: Config.tableBottomAnchor)
            ])
    }
    
    private func setupFillerViewConstraints() {
        fillerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fillerView.rightAnchor.constraint(equalTo: stack.rightAnchor),
            fillerView.leftAnchor.constraint(equalTo: stack.leftAnchor),
            fillerView.topAnchor.constraint(equalTo: table.bottomAnchor, constant: Config.TopAnchor),
            fillerView.bottomAnchor.constraint(equalTo: stack.bottomAnchor)
            ])
    }
    
    private func setupStackConstraints() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Config.stackPadding),
            stack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Config.stackPadding),
            stack.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: Config.stackPadding),
            stack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Config.stackPadding), // should be added on last item inside the container
            ])
    }
    
    private func setupSubstackConstraints() {
        subStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subStack.rightAnchor.constraint(equalTo: stack.rightAnchor),
            subStack.leftAnchor.constraint(equalTo: stack.leftAnchor)
            ])
    }
    
}

extension ViewController: ViewModelDelegate {
    func viewControllerDidUpdateData(_ viewController: ViewController) {
        print("did update")
    }
    
    func viewController(_ viewController: ViewController, didAddDataAt index: Int) {
        
    }
    
    func loadData(_ offset: Int, _ limit: Int) {
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
                if let lastVisibleCell = table.visibleCells[table.visibleCells.count-1] as? DevCell {
                    if lastVisibleCell.cellIndex == fireBaseModel.tableCellDataArray.count - 1 {
                        loadData(fireBaseModel.tableCellDataArray.count, 13)
                    }
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - tablview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fireBaseModel.getTableDatasize()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DevCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "DevCell")
        cell.cellIndex = indexPath.row
        let singleCellData: NSDictionary = fireBaseModel.getTableData(indexPath.row)
        let location = singleCellData[self.viewModel.fieldsArray[3]] as? String ?? ""
        let status = singleCellData["Status"] as? String ?? ""
        cell.textLabel!.text = location
        cell.detailTextLabel?.text = status
        cell.textLabel?.textColor = .orange
        cell.backgroundColor = .darkGray
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print(fireBaseModel.tableCellDataArray[indexPath.row] as Any)
        if let dictv = fireBaseModel.tableCellDataArray[indexPath.row] {
            guard let firstElement = dictv[viewModel.fieldsArray[0]] as? String,
                  let secondElement = dictv[viewModel.fieldsArray[1]] as? String,
                  let thirdElement = dictv[viewModel.fieldsArray[2]] as? String,
                  let fourthElement = dictv[viewModel.fieldsArray[3]] as? String else {
                return
            }
            
            firstTextField.text = firstElement
            secondTextField.text = secondElement
            thirdTextField.text = thirdElement
            fourthTextField.text = fourthElement
        }
        if let navigationController = navigationController {
            print("T##items: Any...##Any")
            print(indexPath.row)
            print("T##items: Any...##Any")
            guard let cellData = fireBaseModel.tableCellDataArray[indexPath.row] else { return }
            let userRequest = UserRequest(with: indexPath.row, andDictionary: cellData)
            let detailsViewModel = DetailViewModel(withUserRequest: userRequest)
            let detailViewController = RequestDetailsViewController(detailsViewModel)
            navigationController.pushViewController(detailViewController, animated: true)
        }
        //        let vc = RequestDetailsViewController()
        //        self.present(vc, animated: true, completion: nil)
        
    }
}

extension ViewController {
    // MARK: - Actions
    @objc func topBtnTapped() {
        UIView.animate(withDuration: 2.0) { [weak self] in
            guard let `self` = self else { return }
            self.subStack.removeArrangedSubview(self.secondTextField)
            self.subStack.removeArrangedSubview(self.fourthTextField)
            self.containerView.layoutIfNeeded()
        }
        
    }
    
    @objc func bottomBtnTapped() {
        UIView.animate(withDuration: 2.0, animations: {
            self.subStack.insertArrangedSubview(self.secondTextField, at: 1)
            self.subStack.insertArrangedSubview(self.fourthTextField, at: 3)
            self.containerView.layoutIfNeeded()
        })
        
    }
    
    @objc func submitBtnTapped() {
        
        guard let firstField = firstTextField.text,
            let secondField = secondTextField.text,
            let thirdField = thirdTextField.text,
            let fourthField = fourthTextField.text else {
                let alert = UIAlertController()
                alert.title = "Blank field"
                alert.message = "please fill all fields"
                alert.present(alert, animated: true, completion: nil)
                return
        }
        let entry = Requestes(firstField, secondField, thirdField, fourthField)
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

extension ViewController: FireBaseModelDelegate {
    
}

extension ViewController: StackViewModelDelegate {
    func stackViewModelDidSetDataSourceArray(_ stackViewModel: StackViewModel) {
        //update ui exactly like tableview delegate
    }
    
    func stackViewModelDidSetTableContentArray(_ stackViewModel: StackViewModel) {
        
    }
    
    func stackViewModelDidSetDataArray(_ stackViewModel: StackViewModel) {
        
    }
    
    
}
