//
//  ViewController.swift
//  arquitetura-mvvm
//
//  Created by Solutis on 05/01/18.
//  Copyright © 2018 Solutis. All rights reserved.
//

import UIKit
import RxCocoa
import RxDataSources
import RxSwift

class ViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var postViewModel = PostViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
//        postViewModel.getPosts()
    }
    
    fileprivate func bindView() {
        postViewModel.posts.asObservable().bind(to: tableView.rx.items(cellIdentifier: "postItemCell", cellType: PostTableViewCell.self)) { index, model, cell in
            cell.post = model
            }.disposed(by: disposeBag)
    }
}

