//
//  PostDetailViewModel.swift
//  arquitetura-mvvm
//
//  Created by Solutis on 25/05/18.
//  Copyright © 2018 Solutis. All rights reserved.
//

import RxCocoa

class PostDetailViewModel: BaseViewModel {
    private var service = PostRemoteService()
    private var id: Int!

    var postModel = BehaviorRelay<Post?>(value: nil)

    init(_ id: Int) {
        self.id = id
    }

    func getPost() {
        service.getPost(id)
            .subscribe(onNext: {[postModel] (post) in
                postModel.accept(post)
            }, onError: { [error] (errorMessage) in
                error.accept(errorMessage.getMessage())
            }).disposed(by: disposeBag)
    }
}
