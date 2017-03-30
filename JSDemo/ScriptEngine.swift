//
//  ScriptEngine.swift
//  JSDemo
//
//  Created by Michael Borgmann on 29/03/2017.
//  Copyright © 2017 Michael Borgmann. All rights reserved.
//

import Foundation
import JavaScriptCore

@objc protocol ScriptExports: JSExport {
    var version: String { get set }
    static func create() -> ScriptEngine
    func wait(seconds: Int)
    func show(text: String)
}

class ScriptEngine: NSObject, ScriptExports {
    
    dynamic var version = "Script Engine v1.0"
    
    var context: JSContext!
    
    override init() {
        super.init()
        context = JSContext()
        context?.setObject(ScriptEngine.self, forKeyedSubscript: "ScriptEngine" as (NSCopying & NSObjectProtocol)!)
    }
    
    class func create() -> ScriptEngine {
        return ScriptEngine()
    }
    
    func runScript(scriptName: String) {
        guard let file = Bundle.main.path(forResource: scriptName, ofType: "js") else {
            print("File not found")
            return
        }
        
        do {
            let script = try String(contentsOfFile: file, encoding: String.Encoding.utf8)
            _ = context.evaluateScript(script)
        } catch (let error) {
            print("Error processing JavaScript file: \(error)")
        }
    }
    
    func wait(seconds: Int) {
        sleep(UInt32(seconds))
    }
    
    func show(text: String) {
        print(text)
    }
}
