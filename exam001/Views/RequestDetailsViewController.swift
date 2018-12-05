//
//  RequestDetailsViewController.swift
//  exam001
//
//  Created by Seif Ghotouk on 11/19/18.
//  Copyright © 2018 Adnan Al-Akhrass. All rights reserved.
//

import UIKit

class RequestDetailsViewController: UIViewController {
    
    public var requestID: Int?
    public var requestPublisher: String?
    public var requestItems: String?
    public var requestStatus: String?
    public var requestFloor: String?
    public var requestLocation: String?
    private var scrollView: UIScrollView!
    private var containerView: UIView!
    private var fillerView: UIView!
    private var button: SampleButton!
    private var statusLabel: UILabel!
    private var locationImageView: UIImageView!
    private var basketImageView: UIImageView!
    private var locationLabel: UILabel!
    private var nameAndFloorImageView: UIImageView!
    private var nameAndFloorLabel: UILabel!
    private var itemsLabel: UILabel!
    
    private var detailVM: DetailViewModel?

    convenience init(_ selectedCellContent: NSDictionary,_ id: Int) {
        self.init()
        
        self.requestID = id
        self.requestPublisher = selectedCellContent.value(forKey: "Full name") as? String
        self.requestFloor = (selectedCellContent.value(forKey: "floor") as! String)
        self.requestItems = (selectedCellContent.value(forKey: "what do you want?") as! String)
        self.requestStatus = (selectedCellContent.value(forKey: "Status") as! String)
        self.requestLocation = (selectedCellContent.value(forKey: "where do you want items from?") as! String)
    }
    public convenience init(_ viewModel: DetailViewModel) {
        self.init()
        self.detailVM = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.tintColor = UIColor.orange
        self.navigationController?.navigationBar.tintColor = UIColor.orange
        view.backgroundColor = UIColor.darkGray
        detailVM = DetailViewModel(self.requestID!,self.requestPublisher!,self.requestItems!,self.requestStatus!,self.requestFloor!,self.requestLocation!)
        setupviews()
    }
    
    func setupviews(){
        setupbutton()
        setupScrollView()
        setupStatusLabel()
        setupLocationImage()
        setupLocationLabel()
        setupBasketImage()
        setupItemsLabel()
        setupNameAndFloorImage()
        setupNameAndFloorLabel()
        setupFillerView()
    }
    
    private func setupbutton() {
        button = SampleButton(title: "Take", buttonAdds: true)
        button.addTarget(self, action: #selector(ButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.orange.cgColor
        button.clipsToBounds = true
        checkStatus()
        view.addSubview(button)
        setupButtonConstraints()
    }
    
    private func setupScrollView() {
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        containerView = UIView()
        scrollView.addSubview(containerView)
        
        setupScrollViewConstraints()
    }
    
    private func setupStatusLabel() {
        statusLabel = UILabel()
        statusLabel.font = UIFont.boldSystemFont(ofSize: 40.0)
        statusLabel.text = detailVM?.requestStatus!
        statusLabel.textAlignment = .center
        statusLabel.textColor = UIColor.orange
        self.containerView.addSubview(statusLabel)
        setupStatusLabelConstraints()
    }
    
    private func setupLocationImage() {
        locationImageView = UIImageView()
        let locationImage: UIImage! = UIImage(named: "outline_place_black_48pt")
        locationImageView.image = locationImage
        self.containerView.addSubview(locationImageView)
        setupLocationImageConstraints()
    }
    
    private func setupLocationLabel() {
        locationLabel = UILabel()
        locationLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        locationLabel.text = detailVM?.requestLocation!
        locationLabel.textAlignment = .center
        locationLabel.textColor = UIColor.orange
        self.containerView.addSubview(locationLabel)
        setupLocationLabelConstraints()
    }
    
    private func setupBasketImage() {
        basketImageView = UIImageView()
        let basketimage: UIImage! = UIImage(named: "outline_local_grocery_store_black_48pt")
        basketImageView.image = basketimage
        self.containerView.addSubview(basketImageView)
        setupBasketImageConstraints()
    }
    
    private func setupItemsLabel() {
        itemsLabel = UILabel()
        itemsLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        itemsLabel.text = detailVM?.requestItems!
        itemsLabel.textAlignment = .center
        itemsLabel.textColor = UIColor.orange
        self.containerView.addSubview(itemsLabel)
        setupItemsLabelConstraints()
    }
    
    private func setupNameAndFloorImage() {
        nameAndFloorImageView = UIImageView()
        let nameAndFloorImage = UIImage(named: "outline_perm_identity_black_48pt")
        nameAndFloorImageView.image = nameAndFloorImage
        self.containerView.addSubview(nameAndFloorImageView)
        setupNameAndFloorImageConstraints()
    }
    
    private func setupNameAndFloorLabel() {
        nameAndFloorLabel = UILabel()
        nameAndFloorLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        nameAndFloorLabel.text = (detailVM?.requestPublisher)! + " On Floor: " + (detailVM?.requestFloor)!
        nameAndFloorLabel.textAlignment = .center
        nameAndFloorLabel.textColor = UIColor.orange
        self.containerView.addSubview(nameAndFloorLabel)
        setupNameAndFloorLabelConstraints()
    }
    
    private func setupFillerView() {
        fillerView = UIView()
        fillerView.backgroundColor = UIColor.clear
        self.containerView.addSubview(fillerView)
        setupFillerViewConstraints()
    }
    
    // MARK: - Setup Subviews' Constraints
    private func setupScrollViewConstraints(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -10),
            scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            
            containerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
        let containerHeightConstraint = containerView.heightAnchor.constraint(equalTo: view.heightAnchor)
        containerHeightConstraint.priority = UILayoutPriority(250)
        containerHeightConstraint.isActive = true
    }
    
    private func setupButtonConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            button.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            button.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
            ])
    }
    
    private func setupStatusLabelConstraints() {
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            statusLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            statusLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20),
            statusLabel.heightAnchor.constraint(equalToConstant: 40),
            ])
    }
    
    private func setupLocationImageConstraints() {
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationImageView.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 40),
            locationImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            ])
    }
    
    private func setupLocationLabelConstraints() {
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: locationImageView.bottomAnchor, constant: 20),
            locationLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20),
            locationLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20)
            ])
    }
    
    private func setupBasketImageConstraints() {
        basketImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            basketImageView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 40),
            basketImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            ])
    }
    
    private func setupItemsLabelConstraints() {
        itemsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemsLabel.topAnchor.constraint(equalTo: basketImageView.bottomAnchor, constant: 20),
            itemsLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            itemsLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20)
            ])
    }
    
    private func setupNameAndFloorImageConstraints() {
        nameAndFloorImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameAndFloorImageView.topAnchor.constraint(equalTo: itemsLabel.bottomAnchor, constant: 40),
            nameAndFloorImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            ])
    }
    
    private func setupNameAndFloorLabelConstraints() {
        nameAndFloorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameAndFloorLabel.topAnchor.constraint(equalTo: nameAndFloorImageView.bottomAnchor, constant: 20),
            nameAndFloorLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            nameAndFloorLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20)
            ])
    }
    
    private func setupFillerViewConstraints() {
        fillerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fillerView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            fillerView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            fillerView.topAnchor.constraint(equalTo: nameAndFloorLabel.bottomAnchor, constant: 15),
            fillerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
    }
    
    @objc func ButtonTapped() {
        detailVM?.buttonPressed()
        checkStatus()
    }
    
}

extension RequestDetailsViewController: DetailModelDelegate {
    
    func checkStatus() {
        requestStatus = "Taken"
        if detailVM!.requestStatus != "Available" {
            button.isEnabled = false
            button.alpha = 0.5
            button.titleLabel?.text = "Taken"
        } else {
            button.isEnabled = true
            button.alpha = 1.0
            button.titleLabel?.text = "Take"
        }
    }
}
