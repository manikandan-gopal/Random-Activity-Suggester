
//  APIClient.swift
//
//  Created by mani on 23/11/21.
//

import Foundation
 

class APIClient{
    
    private static var urlConfiguration  = URLSessionConfiguration.default
    private static var urlSession            = URLSession(configuration: urlConfiguration, delegate: NetworkSessionDelegate(), delegateQueue: nil)
    
    static func getResponse(urlRequest: URLRequest,completionHandler: @escaping(Data?,Error?) -> Void){

        let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                completionHandler(data,error)
            }
      
        }

        dataTask.resume()
    }
    
    //MARK: fetchEndPoint function
    private static func fetchEndPoint(baseURL: String,path : String) -> URLComponents {
        let urlString = String("\(baseURL)/\(path)")
        return URLComponents(string: urlString)!
    }
    
    //MARK: addQueryParameters function
    private static func addQueryParameters( urlComponent : inout URLComponents, queryParameters : [String:Any]?) -> URLRequest{
        guard let queryParameters = queryParameters else {
            return URLRequest(url: urlComponent.url!)
        }
        var queryItems                                                  = [URLQueryItem]()
        for (key,value) in queryParameters {
            queryItems.append(URLQueryItem(name: key, value: GlobalFunction.shared.anyToString(parameter: value)))
        }
        urlComponent.queryItems = queryItems
        let urlRequest = URLRequest(url: urlComponent.url!)
        return urlRequest
    }
    
    
    //MARK: addHeaders Function
    private static func addHeaders(urlRequest : inout URLRequest, headers : [String : String]?){
        urlRequest.allHTTPHeaderFields = headers
    }
    
    //MARK: setHttpMethod Function
    private static func setHttpMethod(urlRequest : inout URLRequest, httpMethod : String){
        urlRequest.httpMethod = httpMethod
    }
    
    //MARK: addBodyParameters
    static func addBodyParameters(urlRequest : inout URLRequest, bodyParameters : [String:Any]?)-> URLRequest{
        guard let bodyParameters = bodyParameters else {
            return urlRequest
        }
        let bodyParametersStr = bodyParameters.stringFromHttpParameters()
        
        let data = bodyParametersStr.data(using: String.Encoding.utf8)
        urlRequest.httpBody = data
        return urlRequest
    }
    
    //MARK: a method to complete the request step by step
    static func setupUrlRequest(path : String, headers: [String:String]?,queryParameters: [String:Any]?,bodyParameters : [String:Any]?, httpMethod : HttpMethod) -> URLRequest {
        var urlComponent    =    APIClient.fetchEndPoint(baseURL: GlobalConstant.shared.baseURL, path: path)
        var urlRequest      =   APIClient.addQueryParameters(urlComponent: &urlComponent, queryParameters: queryParameters)
        urlRequest = APIClient.addBodyParameters(urlRequest: &urlRequest, bodyParameters: bodyParameters)
        urlRequest.cachePolicy  =   .reloadIgnoringLocalCacheData
        APIClient.addHeaders(urlRequest: &urlRequest, headers: headers)
        APIClient.setHttpMethod(urlRequest: &urlRequest, httpMethod: httpMethod.rawValue )
        return urlRequest
    }
    
    
}
