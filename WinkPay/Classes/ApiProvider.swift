//
//  ApiProvider.swift
//  WinkPay
//
//  Created by Sathish on 30/09/19.
//

import Foundation
import Moya

// MARK: Api Request Construction
enum WinkApi {
    case sampleApi
}

extension WinkApi: TargetType {
    
    var baseURL: URL {
        return URL(string: "")!
    }
    
    var path: String {
        switch self {
        case .sampleApi:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sampleApi:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .sampleApi:
            let dict: [String: Any] = [:]
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .sampleApi:
            let dict: [String: String] = [:]
            return dict
        }
    }
}

// MARK: Api Manager
struct WinkApiManager: BaseApiProvider {
    
    let provider = MoyaProvider<WinkApi>(plugins: defaultPlugins())
    
    
    /// Use Promise kit
}
