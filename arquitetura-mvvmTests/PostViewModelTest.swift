//
//  PostViewModelTest.swift
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

class PostViewModelTest: BaseTest {
    
    var viewModel: PostViewModel?
    let disposeBag = DisposeBag()

    override func setUp() {
        viewModel = PostViewModel()
    }
    
    func testGetPosts_Success() {
        stub(uri(Endpoints.Posts.list.url), jsonData(getJson(name: "posts") as Data))
        let publisher = PublishSubject<[Post]>()
        
        viewModel?.getPosts()
        
        viewModel?.posts.asObservable().subscribe(onNext: {
            publisher.onNext($0)
        }).disposed(by: disposeBag)
        
        let posts = try! publisher.toBlocking().first()
        XCTAssertFalse((posts ?? []).isEmpty)
    }
    
    func testGetPosts_Error() {
        stub(uri(Endpoints.Posts.list.url), jsonData(getJson(name: "postsError") as Data, status: 400))
        let publisher = PublishSubject<String>()
        
        viewModel?.getPosts()
        
        viewModel?.error.asObservable().subscribe(onNext: {
            publisher.onNext($0)
        }).disposed(by: disposeBag)
        
        let message = try! publisher.toBlocking().first()
        
        XCTAssertEqual("Erro ao carregar os Posts", message)
    }
    
    func testGetPostIdSelected() {
        let posts:[Post] = jsonToObject(name: "posts")
        viewModel?.posts.accept(posts)
        let post = viewModel?.getPostIdSelected(0)
        
        XCTAssertEqual(posts.first?.id, post)
    }
    
    func testGetViewModelCell_Success() {
        let posts:[Post] = jsonToObject(name: "posts")
        viewModel?.posts.accept(posts)
        let viewModelCell = viewModel?.getViewModelCell(0)
        
        XCTAssertTrue(isEqual(posts.first, otherObject: viewModelCell?.post.value))
    }
    
    func testGetViewModelCell_IndexOutOfBound() {
        let posts:[Post] = jsonToObject(name: "posts")
        viewModel?.posts.accept(posts)
        let viewModelCell = viewModel?.getViewModelCell(101)

        XCTAssertTrue(isEqual(Post(), otherObject: viewModelCell?.post.value))
    }
    
    func testGetPosts_NoContent() {
        stub(uri(Endpoints.Posts.list.url), http(204))
        let publisher = PublishSubject<[Post]>()
        
        viewModel?.getPosts()
        
        viewModel?.posts.asObservable().subscribe(onNext: {
            publisher.onNext($0)
        }).disposed(by: disposeBag)
        
        let posts = try! publisher.toBlocking().first()
        XCTAssertTrue((posts ?? []).isEmpty)
    }
    
    func testGetPosts_ParseError() {
        stub(uri(Endpoints.Posts.list.url), jsonData(getJson(name: "post") as Data))
        let publisher = PublishSubject<[Post]>()
        
        viewModel?.getPosts()
        
        viewModel?.posts.asObservable().subscribe(onNext: {
            publisher.onNext($0)
        }).disposed(by: disposeBag)
        
        let posts = try! publisher.toBlocking().first()
        XCTAssertTrue((posts ?? []).isEmpty)
    }
    
    func testGetPosts_ErrorNoMessage() {
        stub(uri(Endpoints.Posts.list.url), http(400))
        let publisher = PublishSubject<String>()
        
        viewModel?.getPosts()
        
        viewModel?.error.asObservable().subscribe(onNext: {
            publisher.onNext($0)
        }).disposed(by: disposeBag)
        
        let message = try! publisher.toBlocking().first()
        
        XCTAssertEqual("", message)
    }

}
