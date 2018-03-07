//
//  PostRemoteServiceProtocol.swift
//  arquitetura-mvvm
//
//  Created by Solutis on 06/03/18.
//  Copyright © 2018 Solutis. All rights reserved.
//

import Foundation
import RxSwift

protocol PostRemoteServiceProtocol {
    func getPosts() -> Observable<[Post]>
    func getPost(_ id: Int) -> Observable<Post?>
}
