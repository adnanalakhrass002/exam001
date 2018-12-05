//
//  fireBaseViewModel.swift
//  exam001
//
//  Created by Seif Ghotouk on 11/18/18.
//  Copyright © 2018 Adnan Al-Akhrass. All rights reserved.
//

import UIKit
import Firebase

class fireBaseViewModel: NSObject {
    
    weak var delegate: FireBaseModelDelegate?
    public var ref: DatabaseReference!
    public var refcellCountFunc: DatabaseReference!
    public var tableCellDataArray = [NSDictionary?]()
    private var viewModel: StackViewModel!
    
    public convenience init(_ viewModel: StackViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    init(_ delegate: FireBaseModelDelegate) {
        viewModel = StackViewModel()
        self.delegate = delegate
        ref = Database.database().reference()
        refcellCountFunc = Database.database().reference()
    }
    
    override init() {
        
    }
    
    func getTodayString() -> String{
        
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        
        let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
        
        return today_string
        
    }

    
}

extension fireBaseViewModel {
    
    public func numberofcells(completion: @escaping (_ num: Int)->()) {
        var value = 0
        refcellCountFunc.child("numberOfRequests").observeSingleEvent(of: .value, with: { (snapshot) in
            value = (snapshot.value as? Int)!
            completion(value)
        }) { (error) in
            print(error.localizedDescription)
            completion(value)
        }
    }
    
    public func getCellItem(completion: @escaping (_ result: NSDictionary)->()) {
        ref.child("Requests").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as! NSDictionary
            completion(value)
        }) { (error) in
            print(error.localizedDescription)
            completion(NSDictionary())
        }
    }
    
    func getCellDataFromFirebase(_ offset: Int, _ limit: Int, completion: @escaping (_ success: Bool)->()) {
        var count = 0
        for index in offset..<limit + offset {
            ref.child("Requests").child(String(index)).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value {
                    self.tableCellDataArray.append(dictionary as? NSDictionary)
                }
                print("called success \(index)")
                count += 1
                if count == limit {
                    completion(true)
                }
            }) { (error) in
                print(error.localizedDescription)
                count += 1
                completion(false)
            }
        }
    }
    public func clearData() {
        self.tableCellDataArray.removeAll()
    }
    
    public func getTableDatasize() -> Int {
        let x = self.tableCellDataArray.compactMap { $0 }
        return x.count
        
    }
    
    public func getTableData(_ index: Int) -> NSDictionary {
        let x = self.tableCellDataArray.compactMap { $0 }
        return x[index]
    }
    
    public func appendNewEntry(_ entry: Requestes, completion: @escaping (_ success: Bool)->()) {
        numberofcells { (numOfEntries) in
            self.ref.child("Requests").child(String(numOfEntries)).setValue([self.viewModel.fieldsArray[0] : entry.fullName, self.viewModel.fieldsArray[1] : entry.floor, self.viewModel.fieldsArray[2] : entry.location, self.viewModel.fieldsArray[3] : entry.items, "Status" : "Available", "Posted at" : self.getTodayString()])
            
            self.ref.child("numberOfRequests").setValue(numOfEntries + 1)
            completion(true)
        }
    }
    
}
