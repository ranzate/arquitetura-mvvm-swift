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

    private var service: PostRemoteServiceProtocol!

    var posts = Variable<[Post]>([Post]())
    var post = Variable<Post?>(Post())
    var error = Variable<String>("")
    var disposeBag = DisposeBag()

    init(service: PostRemoteServiceProtocol = PostRemoteService()) {
        self.service = service
    }

    func getPosts() {
        service.getPosts()
            .subscribe(onNext: { (posts) in
                self.posts.value = posts
            }, onError: { (error) in
                self.error.value = error.getMessage()
            }).disposed(by: disposeBag)
    }

    func getPost(_ id: Int) {
        service.getPost(id)
            .subscribe(onNext: { (post) in
                self.post.value = post
            }, onError: { (error) in
                self.error.value = error.getMessage()
            }).disposed(by: disposeBag)
    }
}
