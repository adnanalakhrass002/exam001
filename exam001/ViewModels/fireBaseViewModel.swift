//
//  fireBaseViewModel.swift
//  exam001
//
//  Created by Seif Ghotouk on 11/18/18.
//  Copyright © 2018 Adnan Al-Akhrass. All rights reserved.
//

import UIKit
import Firebase
import Alamofire

enum Request: String {
    case post
    case get
    case delete
    case json
}

struct Data: Codable {
    var slideshow: SlideShow
}

struct SlideShow: Codable {
    var author: String
    var date: String
    var slides: [Slide]
    var title: String
}

struct Slide: Codable {
    var items: [String]?
    var title: String
    var type: String
}

class fireBaseViewModel: NSObject {
    
    weak var delegate: FireBaseModelDelegate?
    public var reference: DatabaseReference!
    public var referenceCellCountFunc: DatabaseReference!
    public var tableCellDataArray = [NSDictionary?]()
    private var viewModel: StackViewModel!
    
    public convenience init(_ viewModel: StackViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    init(_ delegate: FireBaseModelDelegate) {
        viewModel = StackViewModel()
        self.delegate = delegate
        reference = Database.database().reference()
        referenceCellCountFunc = Database.database().reference()
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
    
    func request(_ url: String!) {
        AF.request(url).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
                let decoder = JSONDecoder()
                //move decoder to model which returns success and object or failure and error
                var decoded: Data?
                do {
                    decoded = try decoder.decode(Data.self, from: data)
                }catch {
                    print(error)
                }
                
                if let slideShow = decoded?.slideshow {
                    print(slideShow)
                }
                print("//////////////////////////////")
//                print(decoded.slides)
                print("//////////////////////////////")
            }
        }
    }

    
}

extension fireBaseViewModel {
    
    public func numberofcells(completion: @escaping (_ num: Int)->()) {
        var value = 0
        referenceCellCountFunc.child("numberOfRequests").observeSingleEvent(of: .value, with: { (snapshot) in
            value = (snapshot.value as? Int)!
            completion(value)
        }) { (error) in
            print(error.localizedDescription)
            completion(value)
        }
    }
    
    public func getCellItem(completion: @escaping (_ result: NSDictionary)->()) {
        reference.child("Requests").observeSingleEvent(of: .value, with: { (snapshot) in
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
            reference.child("Requests").child(String(index)).observeSingleEvent(of: .value, with: { (snapshot) in
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
        let x = tableCellDataArray.compactMap { $0 }
        return x.count
        
    }
    
    public func getTableData(_ index: Int) -> NSDictionary {
        let x = tableCellDataArray.compactMap { $0 }
        return x[index]
    }
    
    public func appendNewEntry(_ entry: Requestes, completion: @escaping (_ success: Bool)->()) {
        numberofcells { (numOfEntries) in
            self.reference.child("Requests").child(String(numOfEntries)).setValue([self.viewModel.fieldsArray[0] : entry.fullName, self.viewModel.fieldsArray[1] : entry.floor, self.viewModel.fieldsArray[2] : entry.location, self.viewModel.fieldsArray[3] : entry.items, "Status" : "Available", "Posted at" : self.getTodayString()])
            
            self.reference.child("numberOfRequests").setValue(numOfEntries + 1)
            completion(true)
        }
    }
    
    public func performRequest(_ requestType: String){
        var url = "https://httpbin.org/"
        switch requestType.lowercased() {
        case Request.post.rawValue:
            url = url + "post"
        case Request.get.rawValue:
            url = url + "get"
        case Request.delete.rawValue:
            url = url + "delete"
        case Request.json.rawValue:
            url = url + "json"
        default:
            print("Error: bad request")
            return
        }
        request(url)
    }
    
}
