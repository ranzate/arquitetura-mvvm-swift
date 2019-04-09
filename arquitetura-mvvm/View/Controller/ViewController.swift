//
//  ViewController.swift
//  arquitetura-mvvm
//
//  Created by Solutis on 05/01/18.
//  Copyright © 2018 Solutis. All rights reserved.
//

import UIKit
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
        viewModel.posts.asObservable().bind(onNext: {[weak self] _ in
            self?.tableView.reloadData()
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

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getPostsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let postCell = tableView.dequeueReusableCell(withIdentifier: "postItemCell") as? PostTableViewCell else {
            return UITableViewCell()
        }
        postCell.setup(viewModel.getViewModelCell(indexPath.row))
        return postCell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "postDetailSegue", sender: indexPath.row)
    }
}
