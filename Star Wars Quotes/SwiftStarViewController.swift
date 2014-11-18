//
//  SwiftStarViewController.swift
//  Star Wars Quotes
//
//  Created by Blaise Rivet on 11/17/14.
//  Copyright (c) 2014 ICAppSoc. All rights reserved.
//

import UIKit

class SwiftStarViewController: UIViewController {
    
    @IBOutlet var quoteLabel :UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show a quote when the view first loads
        showNewQuote(nil)
    }
    
    @IBAction func showNewQuote(sender: AnyObject?) {
        let starWarsUrl = "http://www.iheartquotes.com/api/v1/random?source=starwars&format=json"
        
        let session = NSURLSession.sharedSession()
        session.dataTaskWithURL(NSURL(string: starWarsUrl)!, completionHandler: {
            (data, response, error) in
            if error != nil {
                println("Error retrieveing quote: \(error.localizedDescription)")
                return
            }
            var errorJSON: NSError?
            let quoteAny: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: .allZeros, error: &errorJSON)
            if errorJSON != nil {
                println("Error parsing quote: \(errorJSON!.localizedDescription)")
                return
            }
            
            
            if let quoteJSON = quoteAny as? [String: AnyObject] { // Dictionary<String,AnyObject> also works
               
                let quote = quoteJSON["quote"] as String
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.quoteLabel.text = quote
                })
            }
        }).resume()
    }
    
}