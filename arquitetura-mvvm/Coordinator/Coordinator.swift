//
//  Coordinator.swift
//  arquitetura-mvvm
//
//  Created by Solutis on 4/7/19.
//  Copyright © 2019 Solutis. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    func start<T: ViewModelFactory>(viewModel: T)
}

protocol ViewModelFactory {
    associatedtype viewModelType = BaseViewModel
    func viewModel() -> viewModelType
}
