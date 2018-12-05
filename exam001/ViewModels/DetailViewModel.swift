//
//  DetailViewModel.swift
//  exam001
//
//  Created by Seif Ghotouk on 11/27/18.
//  Copyright © 2018 Adnan Al-Akhrass. All rights reserved.
//

import UIKit
import Firebase

class DetailViewModel: NSObject {
    
    public var ref : DatabaseReference!
    weak var delegate: DetailModelDelegate?
    public var requestID: Int?
    public var requestPublisher: String?
    public var requestItems: String?
    public var requestStatus: String?
    public var requestFloor: String?
    public var requestLocation: String?
    
    public convenience init(_ id: Int ,_ name: String,_ items: String,_ status: String,_ floor:String,_ location: String) {
        self.init()
        requestID = id
        requestPublisher = name
        requestStatus = status
        requestLocation = location
        requestFloor = floor
        requestItems = items
        ref = Database.database().reference()
    }
    
    init(_ delegate: DetailModelDelegate) {
        self.delegate = delegate
        ref = Database.database().reference()
    }
    
    override init() {
        
    }
    
}

extension DetailViewModel {
    public func buttonPressed() {
        requestStatus = "Taken"
        self.ref.child("Requests").child(String(requestID!)).child("Status").setValue(requestStatus as! String)
    }
}

