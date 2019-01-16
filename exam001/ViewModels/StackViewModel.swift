//
//  StackViewModel.swift
//  exam001
//
//  Created by Seif Ghotouk on 11/12/18.
//  Copyright © 2018 Adnan Al-Akhrass. All rights reserved.
//

import UIKit

protocol StackViewModelDelegate: class {
    //write delegate whenever you update data in a viewmodel
    func stackViewModelDidSetDataSourceArray(_ stackViewModel: StackViewModel)
    func stackViewModelDidSetTableContentArray(_ stackViewModel: StackViewModel)
    func stackViewModelDidSetDataArray(_ stackViewModel: StackViewModel)
}

class StackViewModel: NSObject {
    
    private var dataSourceArray: [String]? {
        didSet {
            stackViewModelDelegate?.stackViewModelDidSetDataSourceArray(self)
        }
    }
    
    public var tableContentArray: [String]? {
        didSet {
            stackViewModelDelegate?.stackViewModelDidSetTableContentArray(self)
        }
    }
    
    private var targetViewController: ViewController?
    weak var delegate: ViewModelDelegate!
    weak var stackViewModelDelegate: StackViewModelDelegate?

    // MARK: - Attributes
    var fieldsArray: [String] = ["Full name", "floor", "where do you want items from?", "what do you want?"]
    
    var dataArray: [Requestes] = [] {
        didSet {
            guard let targetViewController = targetViewController else { return }
            delegate.viewControllerDidUpdateData(targetViewController)
            self.update()
        }
    }
    
    init(_ targetViewController: ViewController) {
        self.targetViewController = targetViewController
        self.delegate = targetViewController
    }

    override init() {
        
    }
}

extension StackViewModel {
    
    // MARK: - Methods
    func update() {
       // delegate.didAddData(-1)
        //submit data to firebase
    }
    
}

