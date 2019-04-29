//
//  PostDetailCoordinator.swift
//  arquitetura-mvvm
//
//  Created by Igor Vaz on 26/04/19.
//  Copyright © 2019 Solutis. All rights reserved.
//

import UIKit

class PostDetailCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
        let viewController = PostDetailViewController.instantiate("Main")
        start(viewController: viewController, animated: animated)
    }
    
    func start(viewController: UIViewController, animated: Bool) {
        navigationController.pushViewController(viewController, animated: true)
    }

}
