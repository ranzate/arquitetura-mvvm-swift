//
//  ViewController.swift
//  arquitetura-mvvm
//
//  Created by Solutis on 05/01/18.
//  Copyright © 2018 Solutis. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: BaseViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = PostViewModel()
    var coordinator: MainCoordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.accessibilityIdentifier = "Cell"
        viewModel.getPosts()
    }
    
    override func bindView() {
        viewModel.posts.asObservable().bind(to: tableView.rx.items(cellIdentifier: "postItemCell", cellType: PostTableViewCell.self)) {[viewModel] index, _, cell in
            cell.setup(viewModel.getViewModelCell(index))
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: {[weak self] indexPath in
            self?.coordinator.postDetail(viewModel: PostDetailViewModel(self!.viewModel.getPostIdSelected(indexPath.row)))
        }).disposed(by: disposeBag)
    }
    
}
