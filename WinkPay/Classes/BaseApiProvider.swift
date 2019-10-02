//
//  File.swift
//  WinkPay
//
//  Created by Sathish on 01/10/19.
//

import Foundation
import Moya
import Result
import SwiftyJSON


typealias HelpCompletionBlock = (_ respJson: JSON?, _ response: Response?, _ error: Error?) -> Void

protocol BaseApiProvider { }

extension BaseApiProvider {
    
     static func defaultPlugins() -> [PluginType] {
        return [NetworkLoggerPlugin(verbose: false)]
    }
    
    typealias MoyaResponse = (json: JSON, error: Error?)
    
    func handleResponse(_ result: Result<Response, MoyaError>) -> MoyaResponse {
        
        switch result {
            
        case let .success(response):
            do {
                _ = try response.filterSuccessfulStatusCodes()
                let json = try JSON(data: response.data)
                return (json, nil)
                
            } catch let err {
                return (JSON.null, err)
            }
            
        case let .failure(error):
            return (JSON.null, error)
        }
    }
}
