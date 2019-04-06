//
//  PostTableViewCellViewModel.swift
//  arquitetura-mvvm
//
//  Created by Solutis on 22/05/18.
//  Copyright © 2018 Solutis. All rights reserved.
//

import RxCocoa

class PostTableViewCellViewModel: BaseViewModel {
    var post = BehaviorRelay<Post>(value: Post())

    init(_ post: Post?) {
        if let post = post {
            self.post.accept(post)
        }
    }
}
