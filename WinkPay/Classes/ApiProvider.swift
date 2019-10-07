//
//  ApiProvider.swift
//  WinkPay
//
//  Created by Sathish on 30/09/19.
//

import Foundation
import PromiseKit
import SwiftyJSON
import Moya

// MARK: Api Request Construction
enum WinkApi {
    case getWalletbalance(clientId: String, userId: String)
}

extension WinkApi: TargetType {
    
    var baseURL: URL {
        return URL(string: "http://167.71.86.28:8080/")!
    }
    
    var path: String {
        switch self {
        case .getWalletbalance:
            return "api/v1/wallet/balance"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getWalletbalance:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getWalletbalance(let clientId, let userId):
            let dict: [String: Any] = ["client": clientId, "user": userId]
            return .requestParameters(parameters: dict, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default: return nil
        }
    }
}

// MARK: Api Manager
struct WinkApiManager: BaseApiProvider {
    
    let provider = MoyaProvider<WinkApi>(plugins: defaultPlugins())
    
    func fetchWalletBalance(clientId: String, userId: String) -> Promise<JSON> {
        
        return Promise<JSON> { promise in
            provider.request(.getWalletbalance(clientId: clientId, userId: userId)) { (result) in
                let response = self.handleResponse(result)
                if let error = response.error {
                    return promise.reject(error)
                }
                return promise.fulfill(response.json)
            }
        }
    }
}


extension BaseApiProvider {
    
    static func handleResp(_ result: MoyaResponse) -> Promise<JSON> {
        return Promise<JSON> { promise in
            if let err = result.error {
                promise.reject(err)
                return
            }
            promise.fulfill(result.json)
        }
    }
}
