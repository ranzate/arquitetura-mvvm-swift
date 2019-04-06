//
//  BaseTest.swift
//  arquitetura-mvvmTests
//
//  Created by Solutis on 4/6/19.
//  Copyright © 2019 Solutis. All rights reserved.
//

import XCTest

class BaseTest: XCTestCase {
    
    func jsonToObject<T : Decodable>(name: String) -> T {
        let data: Data = getJson(name: name) as Data
        return try! JSONDecoder().decode(T.self, from: data)
    }
    
    func getJson(name: String) -> NSData {
        let path = Bundle(for: type(of: self)).path(forResource: name, ofType: "json")!
        return NSData(contentsOfFile: path)!
    }
    
    func isEqual<T: Codable>(_ object: T, otherObject: T) -> Bool {
        return objectToJson(object) == objectToJson(otherObject)
    }
    
    func objectToJson<T: Codable>(_ object: T) -> String {
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(object)
        return String(data: jsonData, encoding: String.Encoding.utf8) ?? ""
    }

}
