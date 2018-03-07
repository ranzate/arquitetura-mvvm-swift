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
import ObjectMapper

protocol BaseRemoteServiceProtocol {
    func request<T: BaseMappable>(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> Observable<T?>
    
    func request<T: BaseMappable>(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> Observable<[T]>
}
