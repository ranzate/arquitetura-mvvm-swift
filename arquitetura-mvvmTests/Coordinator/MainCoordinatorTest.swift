//
//  MainCoordinatorTest.swift
//  arquitetura-mvvmTests
//
//  Created by Igor Vaz on 29/04/19.
//  Copyright © 2019 Solutis. All rights reserved.
//

import UIKit
import XCTest

@testable import arquitetura_mvvm
class MainCoordinatorTest: BaseTest {

    var sut: MainCoordinator!
    
    override func setUp() {
        super.setUp()
        let navigationController = UINavigationController()
        sut = MainCoordinator(navigationController: navigationController)
    }
    
    func testStart() {
        
        let oldViewControllersCount = sut.navigationController.viewControllers.count
        
        sut.start(animated: false)
        
        XCTAssert(sut.navigationController.topViewController is ViewController)
        XCTAssertNotNil((sut.navigationController.topViewController as! ViewController).coordinator)
        XCTAssertEqual(sut.navigationController.viewControllers.count, oldViewControllersCount + 1)
        
    }
    
    func testStartWithViewController() {
        
        let oldViewControllersCount = sut.navigationController.viewControllers.count
        let viewController = ViewController.instantiate("Main")
        viewController.coordinator = MainCoordinator(navigationController: sut.navigationController)
        
        sut.start(viewController: viewController, animated: true)
        
        XCTAssert(sut.navigationController.topViewController is ViewController)
        XCTAssertNotNil((sut.navigationController.topViewController as! ViewController).coordinator)
        XCTAssertEqual(sut.navigationController.viewControllers.count, oldViewControllersCount + 1)
        
    }
    
    func testPostDetail() {
        
        let viewModel = PostDetailViewModel(1)
        let oldViewControllersCount = sut.navigationController.viewControllers.count
        let viewController = PostDetailViewController.instantiate("Main")
        viewController.viewModel = viewModel
        viewController.coordinator = PostDetailCoordinator(navigationController: sut.navigationController)
        
        sut.postDetail(viewModel: viewModel)
        
        XCTAssertNotNil((sut.navigationController.topViewController as! PostDetailViewController).viewModel)
        XCTAssert(sut.navigationController.topViewController is PostDetailViewController)
        XCTAssertNotNil((sut.navigationController.topViewController as! PostDetailViewController).coordinator)
        XCTAssertEqual(sut.navigationController.viewControllers.count, oldViewControllersCount + 1)
        
    }
    
}
