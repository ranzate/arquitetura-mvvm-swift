//
//  arquitetura_mvvmTests.swift
//  arquitetura-mvvmTests
//
//  Created by Solutis on 05/01/18.
//  Copyright © 2018 Solutis. All rights reserved.
//

import XCTest
import Mockingjay
import RxTest
import RxBlocking
import RxSwift
@testable import arquitetura_mvvm
import ObjectMapper

class arquitetura_mvvmTests: XCTestCase {
    
    var viewModel: PostViewModel!
    var service: PostRemoteService!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
    }
    
//    func testPostServiceError() {
//        let body = [
//            "message": "Error",
//            "statusCode": 400
//            ] as [String : Any]
//
//        stub(uri("/posts"), json(body, status: 400))
//
//        let ex = expectation(description: "Expecting a JSON data not nil")
//        service.getPosts(completion: { (posts) in
//            XCTAssertNil(posts)
//            ex.fulfill()
//        }) {
//            XCTAssertEqual($0, "Error")
//            ex.fulfill()
//        }
//
//        waitForExpectations(timeout: 10) { (error) in
//            if let error = error {
//                XCTFail("error: \(error)")
//            }
//        }
//    }
    
//    func testPostServiceNoContent() {
//        let notContentStub = http(204, headers: nil, download: nil)
//        stub(uri("/posts"), notContentStub)
//
//        let ex = expectation(description: "Expecting a JSON data not nil")
//        service.getPosts(completion: { (posts) in
//            XCTAssertNotNil(posts)
//            XCTAssertEqual(posts?.count, 0)
//            ex.fulfill()
//        }) {
//            XCTAssertEqual($0, "")
//            ex.fulfill()
//        }
//
//        waitForExpectations(timeout: 10) { (error) in
//            if let error = error {
//                XCTFail("error: \(error)")
//            }
//        }
//    }
//
//    func testPostServiceSuccess() {
//        let body = [[
//            "id": 1,
//            "userId": "23",
//            "title": "Teste",
//            "body": "Kyle"
//            ] as [String : Any]]
//        stub(http(.get, uri: "/posts"), json(body))
//
//        let ex = expectation(description: "Expecting a JSON data not nil")
//        service.getPosts(completion: { (posts) in
//            XCTAssertNotNil(posts)
//            XCTAssertEqual(posts?.first?.title, "Teste")
//            ex.fulfill()
//        }) {
//            XCTAssertEqual($0, "")
//        }
//
//        waitForExpectations(timeout: 10) { (error) in
//            if let error = error {
//                XCTFail("error: \(error)")
//            }
//        }
//    }
    
    func testGetPosts() {
        let body = [[
            "id": 1,
            "userId": "23",
            "title": "Teste",
            "body": "Kyle"
            ] as [String : Any]]
        
        stub(http(.get, uri: "https://jsonplaceholder.typicode.com/posts"), json(body))
        
        let scheduler = TestScheduler(initialClock: 0)
        
        let observer = scheduler.createObserver(Array<Post>.self)
        
        let observable = scheduler.createColdObservable([
            next(100, Mapper<Post>().mapArray(JSONArray: body))
            ])
        
        let service = MockPostRemoteService(response: observable)
        
        self.viewModel = PostViewModel(service: service)
    
        scheduler.scheduleAt(100) {
            self.viewModel.posts.asObservable()
                .subscribe(observer)
            .disposed(by: self.disposeBag)
        }
        
        scheduler.scheduleAt(200) {
            self.viewModel.getPosts()
        }
        
        scheduler.start()
        
        
        // 8. Inspect the events that the observer received
        let expectedEvents = [
            next(100, [Post]()),
            next(3000, Mapper<Post>().mapArray(JSONArray: body))
        ]
        
        XCTAssertEqual(observer.events.count, expectedEvents.count)
        
    }
}
