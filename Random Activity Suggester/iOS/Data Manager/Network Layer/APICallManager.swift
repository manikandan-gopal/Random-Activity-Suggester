//
//  APICallManager.swift
//  SMI-Test-Round1
//
//  Created by mani on 23/11/21.
//

import Foundation

class APICallManager {
    
    static var shared : APICallManager{
        return APICallManager()
    }
    
    private init(){
        //singleton
    }
    
    func getActivity(with queryParams : [String:Any], completionHandler : @escaping (Data?,Error?) -> Void){
        
         let urlRequest = APIClient.setupUrlRequest(path: "api/activity", headers: nil, queryParameters: queryParams, bodyParameters: nil, httpMethod: HttpMethod.GET)
         APIClient.getResponse(urlRequest: urlRequest) { data, error in
                 completionHandler(data,error)
         }
    }
    
}


extension Dictionary{
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String)
            let percentEscapedValue = (String(describing: value))
            return "\(String(describing: percentEscapedKey))=\(String(describing: percentEscapedValue))"
        }
        
        return parameterArray.joined(separator: "&")
    }
}
