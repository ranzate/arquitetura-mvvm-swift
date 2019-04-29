//
//  MainCoordinator.swift
//  arquitetura-mvvm
//
//  Created by Solutis on 4/7/19.
//  Copyright © 2019 Solutis. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start(animated: Bool) {
        let viewController = ViewController.instantiate("Main")
        viewController.coordinator = MainCoordinator(navigationController: navigationController)
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func start<T>(viewModel: T) where T : ViewModelFactory {
        let view = PostDetailViewController.instantiate("Main")
        view.viewModel = viewModel.viewModel() as? PostDetailViewModel
    }

    func postDetail(viewModel: PostDetailViewModel, animated: Bool = true) {
        let viewController = PostDetailViewController.instantiate("Main")
        viewController.viewModel = viewModel
        viewController.coordinator = PostDetailCoordinator(navigationController: navigationController)
        start(viewController: viewController, animated: animated)
    }
    
}
