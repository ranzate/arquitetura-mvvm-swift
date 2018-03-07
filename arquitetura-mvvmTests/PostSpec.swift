//
//  TestSpec.swift
//  arquitetura-mvvmTests
//
//  Created by Solutis on 06/03/18.
//  Copyright © 2018 Solutis. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Mockingjay
import RxSwift
import RxTest
import ObjectMapper
@testable import arquitetura_mvvm

class TestSpec: QuickSpec {
    
    var viewModel: PostViewModel!
    var service: PostRemoteService!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func spec() {
        
        beforeEach {
            self.disposeBag = DisposeBag()
            self.service = PostRemoteService()
        }
        
        describe("Get Failure") {
            
            beforeEach {
                let body = [
                    "message": "Error",
                    "statusCode": 400
                    ] as [String : Any]
                
                self.stub(uri("/posts"), json(body, status: 400))
            }
            it("Request", closure: {
                waitUntil(timeout: 10, action: { (done) in
                    self.service.getPosts().subscribe(onError: { (error) in
                        expect(error.getMessage()).toNot(beNil())
                        done()
                    }).disposed(by: self.disposeBag)
                })
            })
        }
        
        describe("Get Failure Without Message") {
            
            beforeEach {
                let body = [:] as [String : Any]
                
                self.stub(uri("/posts"), json(body, status: 400))
            }
            it("Request", closure: {
                waitUntil(timeout: 10, action: { (done) in
                    self.service.getPosts().subscribe(onError: { (error) in
                        expect(error.getMessage()).to(equal(""))
                        done()
                    }).disposed(by: self.disposeBag)
                })
            })
        }
        
        describe("Get Success Without Content") {
            
            beforeEach {
                let body = [
                    "id": 1,
                    "userId": "23",
                    "title": "Teste",
                    "body": "Kyle"
                    ] as [String : Any]
                
                self.stub(http(.get, uri: "/posts"), json(body))
            }
            
            it("Chamando", closure: {
                waitUntil(timeout: 10, action: { (done) in
                    self.service.getPosts().subscribe(onNext: { (posts) in
                        expect(posts.count).to(equal(0))
                        done()
                    }).disposed(by: self.disposeBag)
                })
            })
        }
        
        describe("Get Success") {
            
            beforeEach {
                let body = [[
                    "id": 1,
                    "userId": "23",
                    "title": "Teste",
                    "body": "Kyle"
                    ] as [String : Any]]
                
                self.stub(http(.get, uri: "/posts"), json(body))
            }
            
            it("Chamando", closure: {
                waitUntil(timeout: 10, action: { (done) in
                    self.service.getPosts().subscribe(onNext: { (posts) in
                        expect(posts.first?.title).to(equal("Teste"))
                        done()
                    }).disposed(by: self.disposeBag)
                })
            })
        }
        
        describe("Get No Content") {
            
            beforeEach {
                let body = [[:] as [String : Any]]
                
                self.stub(http(.get, uri: "/posts"), json(body, status: 204))
            }
            
            it("Chamando", closure: {
                waitUntil(timeout: 10, action: { (done) in
                    self.service.getPosts().subscribe(onNext: { (posts) in
                        expect(posts.count).to(equal(0))
                        done()
                    }).disposed(by: self.disposeBag)
                })
            })
        }
        
        describe("Obtendo Posts") {
            
            let body = [[
                "id": 1,
                "userId": "23",
                "title": "Teste",
                "body": "Kyle"
                ] as [String : Any]]
            
            it("Chamando requisição", closure: {
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
                
                let expectedEvents = [
                    next(100, [Post]()),
                    next(300, Mapper<Post>().mapArray(JSONArray: body))
                ]
                
                expect(expectedEvents.count).to(equal(observer.events.count))
            })
            
            let errorBody = [
                "status": 400,
                "message": "Error",
                ] as [String : Any]
            
            it("Chamando requisição com error", closure: {
                let scheduler = TestScheduler(initialClock: 0)
                
                let observer = scheduler.createObserver(String.self)
                
                let observable = scheduler.createColdObservable([
                    next(100, [Post]()),
                    error(100, Mapper<ResponseError>().map(JSON: errorBody)!)
                    ])
                
                let service = MockPostRemoteService(response: observable)
                
                self.viewModel = PostViewModel(service: service)
                
                scheduler.scheduleAt(100) {
                    self.viewModel.error.asObservable()
                        .subscribe(observer)
                        .disposed(by: self.disposeBag)
                }
                
                
                scheduler.scheduleAt(200) {
                    self.viewModel.getPosts()
                }
                
                scheduler.start()
                
                let expectedEvents = [
                    next(100, ""),
                    next(300, "Error")
                ]
                
                expect(expectedEvents.count).to(equal(observer.events.count))
            })
        }
    }
    
}
