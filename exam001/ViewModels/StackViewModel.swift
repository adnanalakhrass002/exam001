//
//  StackViewModel.swift
//  exam001
//
//  Created by Seif Ghotouk on 11/12/18.
//  Copyright © 2018 Adnan Al-Akhrass. All rights reserved.
//

import UIKit

class StackViewModel: NSObject {
    
    weak var delegate: ViewModelDelegate!
    private var dataSourceArray = [String]()
    
    public var tableContentArray = [String]()

    // MARK: - Attributes
    var fieldsArray: [String] = ["Full name", "floor", "where do you want items from?", "what do you want?"]
    
    var dataArray: [Requestes] = [] {
        didSet {
            delegate.didUpdateData()
            self.update()
        }
    }
    
    init(_ delegate: ViewModelDelegate) {
        self.delegate = delegate
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

