//
//  PostDetailViewController.swift
//  arquitetura-mvvm
//
//  Created by Solutis on 25/05/18.
//  Copyright © 2018 Solutis. All rights reserved.
//

import UIKit

class PostDetailViewController: BaseViewController, Storyboarded {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    var viewModel: PostDetailViewModel!
    var coordinator: PostDetailCoordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getPost()
    }
    
    override func bindView() {
        viewModel.postModel.bind {[idLabel, userIdLabel, titleLabel, bodyLabel] (post) in
            guard let post = post else { return }
            idLabel?.text = post.id.description
            userIdLabel?.text = post.userId.description
            titleLabel?.text = post.title
            bodyLabel?.text = post.body
        }.disposed(by: disposeBag)
    }

}
