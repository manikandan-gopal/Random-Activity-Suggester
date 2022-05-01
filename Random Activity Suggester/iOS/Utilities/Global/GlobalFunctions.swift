//
//  GlobalFunctions.swift
//  Random Activity Suggester
//
//  Created by mani
//

import Foundation

class GlobalFunction {
    static var shared : GlobalFunction{
        return GlobalFunction()
    }
    
    private init(){
        
    }
    
    func anyToString(parameter : Any) -> String{
        
        if let str = parameter as? String{
            return str
        }
        
        if let data = try? JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted){
            if let stringFromParameter = String(data: data, encoding: .utf8){
                return stringFromParameter
            }
        }
        return ""
    }


    func mergeDictionaries<Type1,Type2>(dictionary1: [Type1:Type2]?, dictionary2: [Type1:Type2]?) -> [Type1:Type2]?{
        if dictionary1 == nil && dictionary2 == nil{
            return nil
        }
        else if dictionary1 == nil{
            return dictionary2
        }
        else if dictionary2 == nil{
            return dictionary1
        }
        else{
            return dictionary1!.merging(dictionary2!) { (current,_) in
                current
            }
        }
    }
}

