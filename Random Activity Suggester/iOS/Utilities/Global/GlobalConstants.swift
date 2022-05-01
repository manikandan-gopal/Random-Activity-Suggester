//
//  GlobalConstants.swift
//  Random Activity Suggester
//
//  Created by mani

import Foundation


class GlobalConstant{
    static var shared : GlobalConstant{
        return GlobalConstant()
    }
    
    private init(){
        
    }
    
    let baseURL = "http://www.boredapi.com"
    
}
