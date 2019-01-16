//
//  UserRequest.swift
//  exam001
//
//  Created by Seif Ghotouk on 1/2/19.
//  Copyright © 2019 Adnan Al-Akhrass. All rights reserved.
//

import Foundation

class UserRequest {
    var id: Int?
    var publisher: String?
    var items: String?
    var status: String?
    var floor: String?
    var location: String?
    
    init() {}
    
    convenience init(with Id: Int?, andDictionary dictionary: NSDictionary?) {
        self.init()
        id = Id
        
        guard let keys = dictionary else { return }
        publisher = keys.value(forKey: "Full name") as? String
        floor = keys.value(forKey: "floor") as? String
        items = keys.value(forKey: "what do you want?") as? String
        status = keys.value(forKey: "Status") as? String
        location = keys.value(forKey: "where do you want items from?") as? String
    }
}
