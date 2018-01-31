//
//  Post.swift
//  arquitetura-mvvm
//
//  Created by Solutis on 05/01/18.
//  Copyright © 2018 Solutis. All rights reserved.
//

import Foundation
import ObjectMapper

struct Post {
    var userId = ""
    var id = 0
    var title = ""
    var body = ""
}

extension Post: Mappable {
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        userId <- map["userId"]
        id <- map["id"]
        title <- map["title"]
        body <- map["body"]
    }
    
}
