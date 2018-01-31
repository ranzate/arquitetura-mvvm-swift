//
//  PostViewModel.swift
//  arquitetura-mvvm
//
//  Created by Solutis on 05/01/18.
//  Copyright © 2018 Solutis. All rights reserved.
//

import Foundation
import RxSwift

struct PostViewModel {
    var posts = Variable<[Post]>([Post]())
    var error = Variable<String>("")
    
    func getPosts() {
        PostRemoteService.getPosts(completion: {
            self.posts.value = $0 ?? [Post]()
        }) {
            self.error.value = "Deu erro!!!"
        }
    }
}
