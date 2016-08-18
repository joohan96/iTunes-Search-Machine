//
//  appModel.swift
//  app_launcher
//
//  Created by Joohan Oh on 2016-08-08.
//  Copyright © 2016 Joohan Oh. All rights reserved.
//

import UIKit
import Alamofire

protocol appModelDelegate {
    func dataReady()
}

class appModel: NSObject {

    var delegate:appModelDelegate?
    var appArray = [App]()
    
    func getApps(inputText: String) {
        // Fetch the apps dynamically through the iTunes API
        
        Alamofire.request(.GET, "https://itunes.apple.com/search?", parameters: ["term": inputText, "country": "CA", "limit": "80"], encoding: ParameterEncoding.URL, headers: nil) .responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                // Create App objects off of the JSON response
                
                var arrayOfApps = [App]()
                
                for app in JSON["results"] as! NSArray {
                    let appObj = App()
                    
                    appObj.appTitle = app.valueForKey("trackName") as! String
                    print(app.valueForKey("trackPrice"))
                    if (app.valueForKey("trackPrice") == nil) {
                        appObj.appPrice = 0
                    }
                    else {
                        appObj.appPrice = app.valueForKey("trackPrice") as! Double
                    }
                    appObj.appImage = app.valueForKey("artworkUrl100") as! String
                    
                    print(appObj.appTitle)
                    print(appObj.appPrice)
                    print(appObj.appImage)
                    
                    arrayOfApps.append(appObj)

                }
        
                // When all the app objects have been constructed, assign the array to the appModel property
                self.appArray = arrayOfApps
                
                // Notify the delegate that the data is ready
                if (self.delegate != nil){
                    self.delegate!.dataReady()
                }
            }
        }
    }
}
