//
//  MockPostRemoteService.swift
//  arquitetura-mvvmTests
//
//  Created by Solutis on 06/03/18.
//  Copyright © 2018 Solutis. All rights reserved.
//

import Foundation
@testable import arquitetura_mvvm
import RxSwift
import RxTest

class MockPostRemoteService: PostRemoteServiceProtocol {

    var viewModel: PostViewModel!
    var disposeBag: DisposeBag!

    var responseArray: TestableObservable<[Post]>!
    var response: TestableObservable<Post?>!

    init(response: TestableObservable<[Post]>) {
        self.responseArray = response
    }

    init(response: TestableObservable<Post?>) {
        self.response = response
    }

    func getPosts() -> Observable<[Post]> {
        return responseArray.asObservable()
    }

    func getPost(_ id: Int) -> Observable<Post?> {
        return response.asObservable()
    }
}
