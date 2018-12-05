////
////  scrollView sampleguide.swift
////  exam001
////
////  Created by Seif Ghotouk on 11/14/18.
////  Copyright © 2018 Adnan Al-Akhrass. All rights reserved.
////
//
//import Foundation
//
//
//private func setupScrollView() {
//
//    scrollView = UIScrollView()
//    scrollView.translatesAutoresizingMaskIntoConstraints = false
//    view.addSubview(scrollView)
//
//    containerView = UIView()
//    containerView.backgroundColor = UIColor.purple
//    containerView.translatesAutoresizingMaskIntoConstraints = false
//    scrollView.addSubview(containerView)
//
//    let lbl = UILabel()
//    lbl.backgroundColor = UIColor.red
//    lbl.translatesAutoresizingMaskIntoConstraints = false
//    containerView.addSubview(lbl)
//
//    let lbl2 = UILabel()
//    lbl2.backgroundColor = UIColor.yellow
//    lbl2.translatesAutoresizingMaskIntoConstraints = false
//    containerView.addSubview(lbl2)
//
//    NSLayoutConstraint.activate([
//        // rule 1
//        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
//        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
//        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
//        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
//
//        // rule 2
//        containerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
//        containerView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
//        containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//        containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
//
//        lbl.topAnchor.constraint(equalTo: scrollView.topAnchor),
//        lbl.leftAnchor.constraint(equalTo: containerView.leftAnchor),
//        lbl.widthAnchor.constraint(equalTo: containerView.widthAnchor),
//        lbl.heightAnchor.constraint(equalToConstant: 40),
//
//        // rule 4
//        lbl2.topAnchor.constraint(equalTo: lbl.bottomAnchor, constant: 800),
//        lbl2.leftAnchor.constraint(equalTo: lbl.leftAnchor),
//        lbl2.widthAnchor.constraint(equalTo: lbl.widthAnchor),
//        lbl2.bottomAnchor.constraint(equalTo: containerView.bottomAnchor), // should be added on last item inside the container
//        lbl2.heightAnchor.constraint(equalToConstant: 40),
//
//        // lbl3
//        ])
//
//    // rule 3
//    let containerHeightConstraint = containerView.heightAnchor.constraint(equalTo: view.heightAnchor)
//    containerHeightConstraint.priority = UILayoutPriority(250)
//    containerHeightConstraint.isActive = true
//
//}
