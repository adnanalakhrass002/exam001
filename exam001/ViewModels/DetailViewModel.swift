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
    
    private var reference: DatabaseReference!
    public var userRequest: UserRequest?
    public weak var delegate: DetailsViewControllerViewModelDelegate?
    
    convenience init(withUserRequest userRequest: UserRequest) {
        self.init()
        self.userRequest = userRequest
        reference = Database.database().reference()
    }
}

extension DetailViewModel {
    public func buttonPressed() {
        guard let userRequest = userRequest else { return }
        userRequest.status = "Taken"
        guard let userRequestId = userRequest.id else { return }
        reference.child("Requests").child(String(userRequestId)).child("Status").setValue(userRequest.status)
    }
}

