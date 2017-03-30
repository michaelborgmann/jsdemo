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
        
        guard let file = Bundle.main.path(forResource: "code", ofType: "js") else {
            print("File not found")
            return nil
        }
        
        do {
            // TODO: Contents of URL
            let script = try String(contentsOfFile: file, encoding: String.Encoding.utf8)
            _ = context?.evaluateScript(script)
        } catch (let error) {
            print("Error processing JavaScript file: \(error)")
        }

        return context
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let context = context else {
            print("Context not found")
            return
        }
        
        // Call JavaScript method
        if let greet = context.objectForKeyedSubscript("greet") {
            let value = greet.call(withArguments: ["from JavaScript"]).toString()
            print(value!)
        }
        
        // Access JavaScript value
        if let value = context.objectForKeyedSubscript("value") {
            print("JS Property: \(value.toInt32())")
        }
        
        // Expose block to JavaScript
        context.setObject(hello, forKeyedSubscript: "hello" as (NSCopying & NSObjectProtocol)!)
        print(context.evaluateScript("hello('block')"))

        let scriptEngine = ScriptEngine()
        scriptEngine.runScript(scriptName: "script")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let hello: @convention(block) (String) -> String = { name in
        return "Hello " + name
    }
    
}
