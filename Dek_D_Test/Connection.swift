//
//  Connection.swift
//  Dek_D_Test
//
//  Created by Phongsakorn Srikate on 29/10/2566 BE.
//

import Foundation
import Alamofire
import ProgressHUD

enum Environment {
    case DEV
    case UAT
    case PRODUCTION
}

// Environment
var environment: Environment = .UAT

// Protocal
var protocal: String {
    switch environment {
    case .DEV:
        return "https://"
    case .UAT:
        return "https://"
    case .PRODUCTION:
        return "https://"
    }
}

// Base URL
var baseURL: String {
    switch environment {
    case .DEV:
        return "dek-d.com/api/rest/"
    case .UAT:
        return "dek-d.com/api/rest/"
    case .PRODUCTION:
        return "dek-d.com/api/rest/"
    }
}

enum API {
    case getListNovel
    case getBanner

    var resource: String {
        switch self {
        case .getListNovel:
            return "open/quiz/novel/list"
        case .getBanner:
            return "campaign/list"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getListNovel:
            return .get
        case .getBanner:
            return .get
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getListNovel:
            return URLEncoding.queryString
        
        default:
            return JSONEncoding.default
        }
    }
    
    var url: String {
        switch self {
        default:
            return protocal + baseURL + resource
        }
    }
}

class Connection {
    class func request(api: API, parameters: Parameters? = nil, enableHUD: Bool = true, completion: @escaping(_ data: Any?, _ meta: Meta?) -> Void) {
        
        var headers: HTTPHeaders = HTTPHeaders()
        switch api {
        case .getListNovel:
            headers["SECRET"] = "DrVDKp2ancYmyW2b3wRVU6yssBcjiyJ4"
        default:
            headers[""] = nil
        }
        
        
        AF.request(api.url, method: api.method, parameters: parameters, encoding: api.encoding, headers: headers ).responseJSON { response in
            debugPrint(response)
            
            if enableHUD {
                ProgressHUD.dismiss()
            }
            
            switch response.result {
            case .success:
                if let dictionary = response.value as? [String : Any] {
                    var meta: Meta? = nil
                    var data: Any? = nil
                    
                    if let metaDict = dictionary["pageInfo"] as? [String : Any] {
                        meta = Meta(dictionary: metaDict)
                    }
                    
                    if let dataDict = dictionary["list"] as? [[String : Any]] {
                        data = dataDict
                    } else {
                        data = response.value
                    }
                    completion(data, meta)
                    
                    return
                }
                
            case .failure(_):
                ProgressHUD.dismiss()
                if let data = response.data {
                    print(String(data: data, encoding: String.Encoding.utf8) ?? "")
                }
            }
        }
    }
}
