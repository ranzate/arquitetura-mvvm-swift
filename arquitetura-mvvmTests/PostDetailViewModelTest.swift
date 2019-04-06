//
//  PostDetailViewModel.swift
//  arquitetura-mvvmTests
//
//  Created by Solutis on 4/6/19.
//  Copyright © 2019 Solutis. All rights reserved.
//

import XCTest
import Mockingjay
import RxBlocking
import RxSwift
import RxCocoa

@testable import arquitetura_mvvm

class PostDetailViewModelTest: BaseTest {
    
    var viewModel: PostDetailViewModel?
    let disposeBag = DisposeBag()
    
    override func setUp() {
        viewModel = PostDetailViewModel(9)
    }
    
    func testGetPost_Success() {
        stub(uri(Endpoints.Posts.get(9).url), jsonData(getJson(name: "post") as Data))
        let publisher = PublishSubject<Post?>()
        
        viewModel?.getPost()
        
        viewModel?.postModel.asObservable().subscribe(onNext: {
            publisher.onNext($0)
        }).disposed(by: disposeBag)
        
        let post = try! publisher.toBlocking().first()
        XCTAssertNotNil(post as? Post)
    }
    
    func testGetPost_Error() {
        stub(uri(Endpoints.Posts.get(9).url), jsonData(getJson(name: "postError") as Data, status: 400))
        let publisher = PublishSubject<String>()
        
        viewModel?.getPost()
        
        viewModel?.error.asObservable().subscribe(onNext: {
            publisher.onNext($0)
        }).disposed(by: disposeBag)
        
        let message = try! publisher.toBlocking().first()
        
        XCTAssertEqual("Erro ao carregar o Post de Id 9", message)
    }
    
    func testGetPost_NoContent() {
        stub(uri(Endpoints.Posts.get(9).url), http(204))
        let publisher = PublishSubject<Post?>()
        
        viewModel?.getPost()
        
        viewModel?.postModel.asObservable().subscribe(onNext: {
            publisher.onNext($0)
        }).disposed(by: disposeBag)
        
        let post = try! publisher.toBlocking().first()
        
        XCTAssertNil(post as? Post)
    }
    
    func testGetPost_ParseError() {
        stub(uri(Endpoints.Posts.get(9).url), jsonData(getJson(name: "posts") as Data))
        let publisher = PublishSubject<Post?>()
        
        viewModel?.getPost()
        
        viewModel?.postModel.asObservable().subscribe(onNext: {
            publisher.onNext($0)
        }).disposed(by: disposeBag)
        
        let post = try! publisher.toBlocking().first()
        XCTAssertNil(post as? Post)
    }
    
    func testGetPost_ErrorNoMessage() {
        stub(uri(Endpoints.Posts.get(9).url), http(400))
        let publisher = PublishSubject<String>()
        
        viewModel?.getPost()
        
        viewModel?.error.asObservable().subscribe(onNext: {
            publisher.onNext($0)
        }).disposed(by: disposeBag)
        
        let message = try! publisher.toBlocking().first()
        
        XCTAssertEqual("", message)
    }

}
