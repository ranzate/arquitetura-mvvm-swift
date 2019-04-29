//
//  PostViewModel.swift
//  arquitetura-mvvm
//
//  Created by Solutis on 05/01/18.
//  Copyright © 2018 Solutis. All rights reserved.
//

import RxCocoa

class PostViewModel : BaseViewModel {

    private var service = PostRemoteService()

    var posts = BehaviorRelay<[Post]>(value: [Post]())
    var post = BehaviorRelay<Post?>(value: nil)

    func getPosts() {
        service.getPosts()
            .subscribe(onNext: { (posts) in
                self.posts.accept(posts)
            }, onError: { (error) in
                self.error.accept(error.getMessage())
            }).disposed(by: disposeBag)
    }
    
    func getPostIdSelected(_ index: Int) -> Int {
        return posts.value[index].id
    }

    func getViewModelCell(_ index: Int) -> PostTableViewCellViewModel {
        if posts.value.count > index {
            return PostTableViewCellViewModel(posts.value[index])
        }
        return PostTableViewCellViewModel(nil)
    }
}

extension PostViewModel : ViewModelFactory {
    func viewModel() -> PostDetailViewModel {
        return PostDetailViewModel(1)
    }
    
}
