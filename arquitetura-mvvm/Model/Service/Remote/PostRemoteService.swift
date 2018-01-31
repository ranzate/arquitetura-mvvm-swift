//
//  PostService.swift
//  arquitetura-mvvm
//
//  Created by Solutis on 05/01/18.
//  Copyright © 2018 Solutis. All rights reserved.
//

import Foundation

class PostRemoteService: BaseRemoteService {
    static func getPosts(completion: @escaping ([Post]?) -> (), error: @escaping () -> ()) {
        sessionManager.request(Endpoints.Posts.list.url, method: .get, parameters: nil, encoding: encoding)
            .validate()
            .responseJSON(completionHandler: {
                handlerResultArray(completion: completion, error: error, response: $0)
            })
    }
}
