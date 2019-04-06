//
//  BaseViewModel.swift
//  arquitetura-mvvm
//
//  Created by Solutis on 22/05/18.
//  Copyright © 2018 Solutis. All rights reserved.
//

import RxCocoa
import RxSwift

class BaseViewModel {
    var loading = BehaviorRelay<Bool>(value: false)
    var error = BehaviorRelay<String>(value: "")
    var disposeBag = DisposeBag()
}
