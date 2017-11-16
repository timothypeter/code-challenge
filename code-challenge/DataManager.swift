//
//  DataManager.swift
//  Stock-Quote-API-Demo-Project
//
//  Created by Tim on 11/15/17.
//  Copyright © 2017 Timothy Peter. All rights reserved.
//

import Foundation

class DataManager{
    
    static let sharedInstance: DataManager = {
        var manager = DataManager()
        
        return manager
    }()
    
    init() {
        print("Singleton Initialized")
    }
    
    var quotesForStocks = [[String:Any]]()
    
    func getStockQuotes(){
        // Create a URL for a web page to be downloaded.
        let url = URL(string: Globals.APIKey)!
        
        // Create a background task to download the web page.
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                if let query = json["query"] as? [String: Any]{
                    if let results = query["results"] as? [String: Any]{
                        if let quotes = results["quote"] as? [[String: Any]]{
                            self.quotesForStocks = quotes
                           // NotificationCenter.default.post(name: Notification.Name(Globals.kQuotesObtainedNotification), object: nil)
                        }
                        
                    }
                }
                
            } catch let error as NSError {
                print(error)
            }
            
            // Make sure we downloaded some data.
        }
        
        // Start the download task.
        dataTask.resume()
    }
}

