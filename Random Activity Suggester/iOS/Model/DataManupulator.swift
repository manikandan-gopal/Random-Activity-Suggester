//
//  DataManupulator.swift
//  Random Activity Suggester
//
//  Created by mani
//

import Foundation


class DataManupulator{
    
    static var shared : DataManupulator{
        return DataManupulator()
    }
    
    private init(){
        
    }
    
    func handleAPIResponse(data: Data?,error: Error?) -> Result<ActivityModel,Error>{
        
        guard let data = data else {
            return .failure(error!)
        }
        
        return handleData(data: data)
        
    }
    
    func handleData(data : Data) -> Result<ActivityModel,Error>{
        do{
            let activity : ActivityModel = try JSONDecoder().decode(ActivityModel.self, from: data)
            return .success(activity)
        }
        catch{
            return .failure(error)
        }
    }
    
}
