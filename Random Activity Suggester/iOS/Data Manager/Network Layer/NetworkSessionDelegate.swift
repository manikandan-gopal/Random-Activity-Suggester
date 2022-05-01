//
//  NetworkSessionDelegate.swift
//  Created by mani
//

import Foundation

class NetworkSessionDelegate : NSObject, URLSessionDelegate {
    
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        //protection space provides additional information about the authentication request
        let protectionSpace = challenge.protectionSpace
        
        //if authenticationMethod is ServerTrust then call completion handler with credentials else perform default handling
        guard protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust else {
            completionHandler(.performDefaultHandling, nil)
            return
        }
        
        //if authenticationMethod is ServerTrust then call completion handler with credentials
        if let serverTrust = protectionSpace.serverTrust{
            let credential = URLCredential(trust: serverTrust)
            completionHandler(URLSession.AuthChallengeDisposition.useCredential,credential)
        }
        // for anyother case perform default handling
        else{
            completionHandler(.performDefaultHandling, nil)
        }
        
    }
    
    public func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        print(error as Any)
    }
}
