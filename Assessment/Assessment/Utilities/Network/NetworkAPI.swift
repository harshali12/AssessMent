//
//  NetworkAPIs.swift
//  Assessment
//
//  Created by APPLE on 14/01/21.
//

import Foundation
import UIKit
import Alamofire

typealias completionBlock = (_ data: AFDataResponse<Any>?, _ error: Error?) -> Void
typealias uploadProgressBlock = (_ progress: Progress?) -> Void
struct NetworkServiceInterface {
    
    /**
     * This method call webservice to post and get data from server
     * - Parameter serviceType: NertworkAPI value
     * - Parameter completionBlock: Closure value
     */
    static func callWebService(serviceType: NetworkAPI, completionBlock: @escaping completionBlock) {
        AF.request(serviceType.path, method: serviceType.method, parameters: serviceType.parameters, encoding: serviceType.encoding, headers: serviceType.headers).responseJSON { (response) in
            switch response.result {
            case .success:
                completionBlock(response, nil)
            case .failure(let error):
                completionBlock(nil, error)
            }
        }
    }
}
