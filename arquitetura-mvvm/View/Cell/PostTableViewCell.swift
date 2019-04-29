//
//  PostTableViewCell.swift
//  arquitetura-mvvm
//
//  Created by Solutis on 05/01/18.
//  Copyright © 2018 Solutis. All rights reserved.
//

import UIKit

class PostTableViewCell: BaseTableViewCell {

    @IBOutlet weak var title: UILabel!

    var viewModel: PostTableViewCellViewModel!

    func setup(_ viewModel: PostTableViewCellViewModel) {
        self.viewModel = viewModel
        bindView()
    }

    fileprivate func bindView() {
        viewModel.post.asObservable().bind(onNext: { [title] in
            title?.text = $0.title
        }).disposed(by: disposeBag)
    }

}
