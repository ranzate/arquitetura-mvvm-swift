//
//  PostTableViewCell.swift
//  arquitetura-mvvm
//
//  Created by Solutis on 05/01/18.
//  Copyright © 2018 Solutis. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!

    var post: Post! {
        didSet {
            title.text = post.title
        }
    }

}
