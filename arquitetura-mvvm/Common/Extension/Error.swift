//
//  Error.swift
//  arquitetura-mvvm
//
//  Created by Solutis on 07/03/18.
//  Copyright © 2018 Solutis. All rights reserved.
//

import Foundation

extension Error {
    func getMessage() -> String {
        return (self as? ResponseError)?.message ?? ""
    }
}
