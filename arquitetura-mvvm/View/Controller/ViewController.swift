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
    
    var viewModel = PostViewModel()
    
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
            self?.performSegue(withIdentifier: "postDetailSegue", sender: indexPath.row)
        }).disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? PostDetailViewController else {
            return
        }
        
        guard let row = sender as? Int else {
            return
        }
        
        controller.viewModel = PostDetailViewModel(viewModel.getPostIdSelected(row))
        
    }
}
