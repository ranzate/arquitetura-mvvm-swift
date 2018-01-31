//
//  BaseService.swift
//  arquitetura-mvvm
//
//  Created by Solutis on 05/01/18.
//  Copyright © 2018 Solutis. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class BaseRemoteService {
    
    static let encoding = JSONEncoding.default
    
    //    static let privateAdapter : PrivateAdapter = {
    //        let instance = PrivateAdapter(
    //            baseURLString: baseUri
    //        )
    //        return instance
    //    }()
    
    static let sessionManager : SessionManager = {
        let serverTrustPolicies: [String:ServerTrustPolicy] = [
            API.baseUrl: ServerTrustPolicy.pinCertificates(
                certificates: ServerTrustPolicy.certificates(),
                validateCertificateChain: true,
                validateHost: true
            )
        ]
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30 // seconds
        configuration.timeoutIntervalForResource = 30
        let instance = SessionManager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
        
        //        instance.adapter = privateAdapter
        //        instance.retrier = privateAdapter
        return instance
    }()
    
    static func handlerResultObject<T: BaseMappable>(completion: (T?) -> (), error: () -> (), response: DataResponse<Any>) {
        if(response.response != nil && response.response!.statusCode == HTTPCodes.noContent) {
            completion(nil)
        } else if(response.result.isSuccess) {
            completion(Mapper<T>().map(JSONObject: response.result.value))
        } else {
            error()
        }
    }
    
    static func handlerResultArray<T: BaseMappable>(completion: ([T]?) -> (), error: () -> (), response: DataResponse<Any>) {
        if(response.response != nil && response.response!.statusCode == HTTPCodes.noContent) {
            completion([T]())
        } else if(response.result.isSuccess) {
            completion(Mapper<T>().mapArray(JSONObject: response.result.value))
        } else {
            error()
        }
    }
    
    static func validateResponse(response: DataResponse<Any>, requestSucess: Bool = false) -> String? {
        if let statuscode =  response.response?.statusCode,  statuscode != HTTPCodes.created {
            return ""
        }
        return nil
    }
}
