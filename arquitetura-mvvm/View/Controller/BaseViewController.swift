//
//  BaseViewController.swift
//  arquitetura-mvvm
//
//  Created by Solutis on 05/01/18.
//  Copyright © 2018 Solutis. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class BaseViewController: UIViewController, Storyboarded {

    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }
    
    internal func bindView() {}

}
