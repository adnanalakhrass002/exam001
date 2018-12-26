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
    
    private lazy var scrollView: UIScrollView! = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var containerView: UIView! = {
        let containerView = UIView()
        return containerView
    }()
    
    private lazy var fillerView: UIView! = {
        let fillerView = UIView()
        fillerView.backgroundColor = .clear
        return fillerView
    }()
    
    private lazy var button: SampleButton! = { [weak self] in
        let button = SampleButton(title: "Take", buttonAdds: true)
        button.addTarget(self, action: #selector(ButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.orange.cgColor
        button.clipsToBounds = true
        checkStatus()
        return button
    }()
    
    private lazy var statusLabel: UILabel! = {
        let statusLabel = UILabel()
        statusLabel.font = UIFont.boldSystemFont(ofSize: 40.0)
        statusLabel.text = detailVM?.requestStatus!
        statusLabel.textAlignment = .center
        statusLabel.textColor = .orange
        return statusLabel
    }()
    
    private lazy var locationImageView: UIImageView! = {
        let locationImageView = UIImageView()
        let locationImage: UIImage! = UIImage(named: "outline_place_black_48pt")
        locationImageView.image = locationImage
        return locationImageView
    }()
    
    private lazy var basketImageView: UIImageView! = {
        let basketImageView = UIImageView()
        let basketimage: UIImage! = UIImage(named: "outline_local_grocery_store_black_48pt")
        basketImageView.image = basketimage
        return basketImageView
    }()
    
    private lazy var locationLabel: UILabel! = {
        let locationLabel = UILabel()
        locationLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        locationLabel.text = detailVM?.requestLocation!
        locationLabel.textAlignment = .center
        locationLabel.textColor = .orange
        return locationLabel
    }()
    
    private lazy var nameAndFloorImageView: UIImageView! = {
        let nameAndFloorImageView = UIImageView()
        let nameAndFloorImage = UIImage(named: "outline_perm_identity_black_48pt")
        nameAndFloorImageView.image = nameAndFloorImage
        return nameAndFloorImageView
    }()
    
    private lazy var nameAndFloorLabel: UILabel! = {
        let nameAndFloorLabel = UILabel()
        nameAndFloorLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        nameAndFloorLabel.text = (detailVM?.requestPublisher)! + " On Floor: " + (detailVM?.requestFloor)!
        nameAndFloorLabel.textAlignment = .center
        nameAndFloorLabel.textColor = .orange
        return nameAndFloorLabel
    }()
    
    private lazy var itemsLabel: UILabel! = {
        let itemsLabel = UILabel()
        itemsLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        itemsLabel.text = detailVM?.requestItems!
        itemsLabel.textAlignment = .center
        itemsLabel.textColor = .orange
        return itemsLabel
    }()
    
    private var detailVM: DetailViewModel?
    
    enum Config {
        static let scrollViewTopAnchor: CGFloat = 0.0
        static let scrollViewBottomAnchor: CGFloat = 10.0
        static let scrollLeftandRightTopAnchors: CGFloat = 0.0
        static let buttonBottomAnchor: CGFloat = 0.0
        static let subviewsHorizontalAnchor: CGFloat = 20.0
        static let statusLabelHeight: CGFloat = 40.0
        static let imageTopAnchor: CGFloat = 40.0
        static let labelTopAnchor: CGFloat = 20.0
        static let fillerViewTopAnchor: CGFloat = 15.0
    }

    convenience init(_ selectedCellContent: NSDictionary,_ id: Int) {
        self.init()
        
        requestID = id
        requestPublisher = selectedCellContent.value(forKey: "Full name") as? String
        requestFloor = (selectedCellContent.value(forKey: "floor") as! String)
        requestItems = (selectedCellContent.value(forKey: "what do you want?") as! String)
        requestStatus = (selectedCellContent.value(forKey: "Status") as! String)
        requestLocation = (selectedCellContent.value(forKey: "where do you want items from?") as! String)
    }
    public convenience init(_ viewModel: DetailViewModel) {
        self.init()
        detailVM = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailVM = DetailViewModel(self.requestID!,self.requestPublisher!,self.requestItems!,self.requestStatus!,self.requestFloor!,self.requestLocation!)
        setupviews()
    }
    
    func setupviews(){
        view.tintColor = .orange
        self.navigationController?.navigationBar.tintColor = .orange
        view.backgroundColor = .darkGray

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
        view.addSubview(button)
        setupButtonConstraints()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        setupScrollViewConstraints()
    }
    
    private func setupStatusLabel() {
        containerView.addSubview(statusLabel)
        setupStatusLabelConstraints()
    }
    
    private func setupLocationImage() {
        containerView.addSubview(locationImageView)
        setupLocationImageConstraints()
    }
    
    private func setupLocationLabel() {
        containerView.addSubview(locationLabel)
        setupLocationLabelConstraints()
    }
    
    private func setupBasketImage() {
        containerView.addSubview(basketImageView)
        setupBasketImageConstraints()
    }
    
    private func setupItemsLabel() {
        containerView.addSubview(itemsLabel)
        setupItemsLabelConstraints()
    }
    
    private func setupNameAndFloorImage() {
        containerView.addSubview(nameAndFloorImageView)
        setupNameAndFloorImageConstraints()
    }
    
    private func setupNameAndFloorLabel() {
        containerView.addSubview(nameAndFloorLabel)
        setupNameAndFloorLabelConstraints()
    }
    
    private func setupFillerView() {
        containerView.addSubview(fillerView)
        setupFillerViewConstraints()
    }
    
    // MARK: - Setup Subviews' Constraints
    private func setupScrollViewConstraints(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: Config.scrollViewTopAnchor),
            scrollView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -Config.scrollViewBottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Config.scrollLeftandRightTopAnchors),
            scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: Config.scrollLeftandRightTopAnchors),
            
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
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Config.buttonBottomAnchor),
            button.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Config.subviewsHorizontalAnchor),
            button.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -Config.subviewsHorizontalAnchor)
            ])
    }
    
    private func setupStatusLabelConstraints() {
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Config.labelTopAnchor),
            statusLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: Config.subviewsHorizontalAnchor),
            statusLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -Config.subviewsHorizontalAnchor),
            statusLabel.heightAnchor.constraint(equalToConstant: Config.statusLabelHeight),
            ])
    }
    
    private func setupLocationImageConstraints() {
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationImageView.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: Config.imageTopAnchor),
            locationImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            ])
    }
    
    private func setupLocationLabelConstraints() {
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: locationImageView.bottomAnchor, constant: Config.labelTopAnchor),
            locationLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -Config.subviewsHorizontalAnchor),
            locationLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: Config.subviewsHorizontalAnchor)
            ])
    }
    
    private func setupBasketImageConstraints() {
        basketImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            basketImageView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: Config.imageTopAnchor),
            basketImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            ])
    }
    
    private func setupItemsLabelConstraints() {
        itemsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemsLabel.topAnchor.constraint(equalTo: basketImageView.bottomAnchor, constant: Config.labelTopAnchor),
            itemsLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: Config.subviewsHorizontalAnchor),
            itemsLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -Config.subviewsHorizontalAnchor)
            ])
    }
    
    private func setupNameAndFloorImageConstraints() {
        nameAndFloorImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameAndFloorImageView.topAnchor.constraint(equalTo: itemsLabel.bottomAnchor, constant: Config.imageTopAnchor),
            nameAndFloorImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            ])
    }
    
    private func setupNameAndFloorLabelConstraints() {
        nameAndFloorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameAndFloorLabel.topAnchor.constraint(equalTo: nameAndFloorImageView.bottomAnchor, constant: Config.labelTopAnchor),
            nameAndFloorLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: Config.subviewsHorizontalAnchor),
            nameAndFloorLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -Config.subviewsHorizontalAnchor)
            ])
    }
    
    private func setupFillerViewConstraints() {
        fillerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fillerView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            fillerView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            fillerView.topAnchor.constraint(equalTo: nameAndFloorLabel.bottomAnchor, constant: Config.fillerViewTopAnchor),
            fillerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
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

extension RequestDetailsViewController {
    
    @objc func ButtonTapped() {
        detailVM?.buttonPressed()
        checkStatus()
    }
    
}
