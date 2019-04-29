//
//  MainCoordinator.swift
//  arquitetura-mvvm
//
//  Created by Solutis on 4/7/19.
//  Copyright © 2019 Solutis. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = ViewController.instantiate("Main")
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func start<T>(viewModel: T) where T : ViewModelFactory {
        let view = PostDetailViewController.instantiate("Main")
        view.viewModel = viewModel.viewModel() as? PostDetailViewModel
    }
    
}
