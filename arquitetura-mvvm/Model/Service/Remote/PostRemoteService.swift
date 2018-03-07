//
//  PostService.swift
//  arquitetura-mvvm
//
//  Created by Solutis on 05/01/18.
//  Copyright © 2018 Solutis. All rights reserved.
//

import Foundation
import RxAlamofire
import RxSwift
import ObjectMapper

class PostRemoteService: BaseRemoteService, PostRemoteServiceProtocol {
    
    func getPosts() -> Observable<[Post]> {
        return request(Endpoints.Posts.list.url, method: .get, parameters: nil, encoding: encoding)
    }
    
    func getPost(_ id: Int) -> Observable<Post?> {
        return request(Endpoints.Posts.get(id).url, method: .get, parameters: nil, encoding: encoding)
    }
}
