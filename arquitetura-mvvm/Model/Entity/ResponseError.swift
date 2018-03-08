//
//  ResponseError.swift
//  arquitetura-mvvm
//
//  Created by Solutis on 02/03/18.
//  Copyright © 2018 Solutis. All rights reserved.
//

import Foundation

import ObjectMapper

struct ResponseError {
    var message: String?
    var statusCode: Int?
}

extension ResponseError: Mappable, Error {

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        message <- map["message"]
        statusCode <- map["status_code"]
    }
}
