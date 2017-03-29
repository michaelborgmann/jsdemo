//
//  ViewController.swift
//  JSDemo
//
//  Created by Michael Borgmann on 29/03/2017.
//  Copyright © 2017 Michael Borgmann. All rights reserved.
//

import UIKit
import JavaScriptCore

class ViewController: UIViewController {
    
    lazy var context: JSContext? = {
        let context = JSContext()
        
        guard let javaScriptFile = Bundle.main.path(forResource: "jsdemo", ofType: "js") else {
            print("File not found")
            return nil
        }
        
        do {
            // TODO: Contents of URL
            let script = try String(contentsOfFile: javaScriptFile, encoding: String.Encoding.utf8)
            _ = context?.evaluateScript(script)
        } catch (let error) {
            print("Error processing JavaScript file: \(error)")
        }
        
        return context
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        guard let context = context else {
            print("Context not found")
            return
        }
        
        if let hello = context.evaluateScript("helloFromJavaScript") {
            let value = hello.call(withArguments: nil)
            print(value!)
        }
        
        if let greet = context.objectForKeyedSubscript("greet") {
            let value = greet.call(withArguments: ["Michael"]).toString()
            print(value!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

