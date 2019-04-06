//
//  ResponseError.swift
//  arquitetura-mvvm
//
//  Created by Solutis on 02/03/18.
//  Copyright © 2018 Solutis. All rights reserved.
//

import Foundation

class ResponseError: Codable, Error {
    var message: String?
    var statusCode: Int?
    
    init() {
    }
    
    enum CodingKeys: String, CodingKey {
        case message
        case statusCode
    }
}
