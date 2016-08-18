 //
//  ViewController.swift
//  app_launcher
//
//  Created by Joohan Oh on 2016-08-08.
//  Copyright © 2016 Joohan Oh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, appModelDelegate {

    @IBOutlet weak var tableView: UITableView!

    // inputText is what the user typed into the search bar
    var userInput:String?

    var apps:[App] = [App]()
    let model:appModel = appModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("got from search view controller")
        print(userInput)
        
        self.model.delegate = self
        // Fire off request to get Apps
        model.getApps(userInput!)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - appModel Delegate Methods
    func dataReady() {
        // Access the app objects that have been downloaded
        self.apps =  self.model.appArray
    
        // Tell the tableview to reload
        self.tableView.reloadData()

    }
    
    //MARK: - TableView Delegate Methods
        
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(apps.count)
        return apps.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        
        // Get the title label for the cell
        let appTitle = apps[indexPath.row].appTitle
        let label = cell.viewWithTag(2) as! UILabel
        label.text = appTitle
        
    
        // Get the price label for the cell
        let appPrice = apps[indexPath.row].appPrice
        let label2 = cell.viewWithTag(3) as! UILabel
        if (appPrice != 0) {
            label2.text = "$" + appPrice.description
        }
        else {
            label2.text = "Free"
        }
        
        // Construct the app thumbnail url
        let appImageURLString = apps[indexPath.row].appImage
    
        // Create an NSURL object
        let appImageURL = NSURL(string: appImageURLString)
        
        if (appImageURL != nil) {
            
            // Create an NSURLRequest object
            let request = NSURLRequest(URL: appImageURL!)
            
            // Create an NSURLSession object
            let session = NSURLSession.sharedSession()
            
            // Create a datatask and pass in the request
            let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    // Get a reference to the imageView element of the cell
                    let imageView  = cell.viewWithTag(1) as! UIImageView
                    
                    // Create an image object, and assign it to into the imageView
                    imageView.image = UIImage(data: data!)
                })
            })
            dataTask.resume()
        }
        return cell
    }
}

