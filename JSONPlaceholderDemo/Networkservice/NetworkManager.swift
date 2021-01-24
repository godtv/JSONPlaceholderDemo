//
//  NetworkManager.swift
//  JSONPlaceholderDemo
//
//  Created by ko on 2021/1/23.
//

import Foundation
import Moya
 
enum NetworkManager {
    case searcPhoto(keywrod:String)
}
 
extension NetworkManager:TargetType {
  
    var baseURL: URL {
        return URL(string: APPURL.Jsonplaceholder)!
    }
 
    var path: String {
        switch self {
        case .searcPhoto( _):
            return ""
        }
    }
    var method: Moya.Method {
        return .get
    }
  
 
    var sampleData: Data {
        switch self {
        case .searcPhoto( _):
            return "".data(using: String.Encoding.utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .searcPhoto(_):
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        switch self {
        case .searcPhoto(_):
            return [:]
        }
    }
    
}

 
