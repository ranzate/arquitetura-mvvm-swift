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

class PostSpec: QuickSpec {
    
    var viewModel: PostViewModel!
    var service: PostRemoteService!
    var disposeBag: DisposeBag!
    
    override func spec() {
        
        beforeEach {
            self.disposeBag = DisposeBag()
            self.service = PostRemoteService()
        }
        
        describe("Get Post Failure") {
            
            beforeEach {
                let body = [
                    "message": "Error",
                    "statusCode": 400
                    ] as [String : Any]
                
                self.stub(uri("/posts/1"), json(body, status: 400))
            }
            it("Request", closure: {
                waitUntil(timeout: 10, action: { (done) in
                    self.service.getPost(1).subscribe(onError: { (error) in
                        expect(error.getMessage()).to(equal("Error"))
                        done()
                    }).disposed(by: self.disposeBag)
                })
            })
        }
        
        describe("Get Posts Failure") {
            
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
        
        describe("Get Post Failure Without Message") {
            
            beforeEach {
                let body = [:] as [String : Any]
                
                self.stub(uri("/posts/1"), json(body, status: 400))
            }
            it("Request", closure: {
                waitUntil(timeout: 10, action: { (done) in
                    self.service.getPost(1).subscribe(onError: { (error) in
                        expect(error.getMessage()).to(equal(""))
                        done()
                    }).disposed(by: self.disposeBag)
                })
            })
        }
        
        describe("Get Posts Failure Without Message") {
            
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
        
        describe("Get Post Success Without Content") {
            
            beforeEach {
                let body = [[
                    "id": 1,
                    "userId": "23",
                    "title": "Teste",
                    "body": "Kyle"
                    ] as [String : Any]]
                
                self.stub(http(.get, uri: "/posts/1"), json(body))
            }
            
            it("Request", closure: {
                waitUntil(timeout: 10, action: { (done) in
                    self.service.getPost(1).subscribe(onNext: { (post) in
                        expect(post).to(beNil())
                        done()
                    }).disposed(by: self.disposeBag)
                })
            })
        }
        
        describe("Get Posts Success Without Content") {
            
            beforeEach {
                let body = [
                    "id": 1,
                    "userId": "23",
                    "title": "Teste",
                    "body": "Kyle"
                    ] as [String : Any]
                
                self.stub(http(.get, uri: "/posts"), json(body))
            }
            
            it("Request", closure: {
                waitUntil(timeout: 10, action: { (done) in
                    self.service.getPosts().subscribe(onNext: { (posts) in
                        expect(posts.count).to(equal(0))
                        done()
                    }).disposed(by: self.disposeBag)
                })
            })
        }
        
        describe("Get Post Success") {
            
            beforeEach {
                let body = [
                    "id": 1,
                    "userId": "23",
                    "title": "Teste",
                    "body": "Kyle"
                    ] as [String : Any]
                
                self.stub(http(.get, uri: "/posts/1"), json(body))
            }
            
            it("Request", closure: {
                waitUntil(timeout: 10, action: { (done) in
                    self.service.getPost(1).subscribe(onNext: { (post) in
                        expect(post?.title).to(equal("Teste"))
                        done()
                    }).disposed(by: self.disposeBag)
                })
            })
        }
        
        describe("Get Posts Success") {
            
            beforeEach {
                let body = [[
                    "id": 1,
                    "userId": "23",
                    "title": "Teste",
                    "body": "Kyle"
                    ] as [String : Any]]
                
                self.stub(http(.get, uri: "/posts"), json(body))
            }
            
            it("Request", closure: {
                waitUntil(timeout: 10, action: { (done) in
                    self.service.getPosts().subscribe(onNext: { (posts) in
                        expect(posts.first?.title).to(equal("Teste"))
                        done()
                    }).disposed(by: self.disposeBag)
                })
            })
        }
        
        describe("Get Post No Content") {
            
            beforeEach {
                let body = [[:] as [String : Any]]
                
                self.stub(http(.get, uri: "/posts/1"), json(body, status: 204))
            }
            
            it("Request", closure: {
                waitUntil(timeout: 10, action: { (done) in
                    self.service.getPost(1).subscribe(onNext: { (post) in
                        expect(post).to(beNil())
                        done()
                    }).disposed(by: self.disposeBag)
                })
            })
        }
        
        describe("Get Posts No Content") {
            
            beforeEach {
                let body = [[:] as [String : Any]]
                
                self.stub(http(.get, uri: "/posts"), json(body, status: 204))
            }
            
            it("Request", closure: {
                waitUntil(timeout: 10, action: { (done) in
                    self.service.getPosts().subscribe(onNext: { (posts) in
                        expect(posts.count).to(equal(0))
                        done()
                    }).disposed(by: self.disposeBag)
                })
            })
        }
        
        describe("Call Method getPosts") {
            
            let body = [[
                "id": 1,
                "userId": "23",
                "title": "Teste",
                "body": "Kyle"
                ] as [String : Any]]
            
            it("Call Method Return Success", closure: {
                let scheduler = TestScheduler(initialClock: 0)
                
                let observer = scheduler.createObserver(Array<Post>.self)
                
                let observable = scheduler.createColdObservable([
                    Recorded.next(100, Mapper<Post>().mapArray(JSONArray: body))
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
                    Recorded.next(100, [Post]()),
                    Recorded.next(300, Mapper<Post>().mapArray(JSONArray: body))
                ]
                
                expect(expectedEvents.count).to(equal(observer.events.count))
            })
            
            let errorBody = [
                "status": 400,
                "message": "Error",
                ] as [String : Any]
            
            it("Call Method Return Error", closure: {
                let scheduler = TestScheduler(initialClock: 0)
                
                let observer = scheduler.createObserver(String.self)
                
                let observable = scheduler.createColdObservable([
                    Recorded.next(100, [Post]()),
                    Recorded.error(100, Mapper<ResponseError>().map(JSON: errorBody)!)
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
                    Recorded.next(100, ""),
                    Recorded.next(300, "Error")
                ]
                
                expect(expectedEvents.count).to(equal(observer.events.count))
            })
        }
        
        describe("Call Method getPost") {
            
            let body = [
                "id": 1,
                "userId": "23",
                "title": "Teste",
                "body": "Kyle"
                ] as [String : Any]
            
            it("Call Method Return Success", closure: {
                let scheduler = TestScheduler(initialClock: 0)
                
                let observer = scheduler.createObserver(Post?.self)
                
                let observable = scheduler.createColdObservable([
                    Recorded.next(100, Mapper<Post>().map(JSON: body))
                    ])
                
                let service = MockPostRemoteService(response: observable)
                
                self.viewModel = PostViewModel(service: service)
                
                scheduler.scheduleAt(100) {
                    self.viewModel.post.asObservable()
                        .subscribe(observer)
                        .disposed(by: self.disposeBag)
                }
                
                
                scheduler.scheduleAt(200) {
                    self.viewModel.getPost(1)
                }
                
                scheduler.start()
                
                let expectedEvents = [
                    Recorded.next(100, Post()),
                    Recorded.next(300, Mapper<Post>().map(JSON: body))
                    ] as [Any]
                
                expect(expectedEvents.count).to(equal(observer.events.count))
            })
            
            let errorBody = [
                "status": 400,
                "message": "Error",
                ] as [String : Any]
            
            it("Call Method Return Error", closure: {
                let scheduler = TestScheduler(initialClock: 0)
                
                let observer = scheduler.createObserver(String.self)
                
                let observable = scheduler.createColdObservable([
                    Recorded.next(100, Mapper<Post>().map(JSON: body)),
                    Recorded.error(100, Mapper<ResponseError>().map(JSON: errorBody)!)
                    ])
                
                let service = MockPostRemoteService(response: observable)
                
                self.viewModel = PostViewModel(service: service)
                
                scheduler.scheduleAt(100) {
                    self.viewModel.error.asObservable()
                        .subscribe(observer)
                        .disposed(by: self.disposeBag)
                }
                
                
                scheduler.scheduleAt(200) {
                    self.viewModel.getPost(1)
                }
                
                scheduler.start()
                
                let expectedEvents = [
                    Recorded.next(100, ""),
                    Recorded.next(300, "Error")
                ]
                
                expect(expectedEvents.count).to(equal(observer.events.count))
            })
        }
    }
    
}
