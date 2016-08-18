//
//  SearchAppViewController.swift
//  app_launcher
//
//  Created by Joohan Oh on 2016-08-08.
//  Copyright © 2016 Joohan Oh. All rights reserved.
//

import UIKit

class SearchAppViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var inputText: UITextField!
    //var text:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(textField: UITextField) {
        inputText.text = textField.text
        print(inputText.text);
    }
    
    // MARK: Search button pressed.
    @IBAction func searchButtonPressed(sender: AnyObject) {
        viewDidLoad()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get a reference to the destination view controller
        let destinationViewController = segue.destinationViewController as! ViewController
        
        // Set the inputText as property of search URL in ViewController
        destinationViewController.userInput = inputText.text!
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
