//
//  BaseRemoteServiceProtocol.swift
//  arquitetura-mvvm
//
//  Created by Solutis on 07/03/18.
//  Copyright © 2018 Solutis. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

protocol BaseRemoteServiceProtocol {
    func request<T>(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> Observable<T?> where T : Decodable

    func request<T>(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> Observable<[T]> where T : Decodable
}
