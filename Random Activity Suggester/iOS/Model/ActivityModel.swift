//
//  ActivityModel.swift
//  Random Activity Suggester
//
//  Created by mani
//

import Foundation


struct ActivityModel : Codable,Equatable,Hashable{
    var activity : String
    var accessibility : Double?
    var type : String
    var participants : Int?
    var price : Double?
    var key : String
    
    //MARK:- Equatable
    
    static func == (lhs: Self, rhs: Self) -> Bool{
        return lhs.key == rhs.key
    }
    
    //MARK:- Local Methods
    
    func getParticipantsText() -> String{
        if let participants = self.participants{
           return "\(participants)"
        }
        else{
           return "Not Mentioned"
        }
    }
    
    func getCostEffectiveText() -> String{
        if let price = self.price{
            if price<=0.4 {
                //cost effective
                return "Cheap"
            }
            else if price >= 0.7{
                //expensive
                return "Expensive"
            }
            else{
                //Moderate
                return "Moderate"
            }
        }
        else{
            return "Not mentioned"
        }
    }
    
    func getAccessibilityText() -> String{
        if let accessibility = self.accessibility{
            if accessibility<=0.4 {
                //Most accessible
                return "Most accessible"
            }
            else if accessibility >= 0.7{
                //least accessible
                return "Difficult to access"
            }
            else{
                //Moderate
                return "Moderate"
            }
        }
        else{
            return "Not mentioned"
        }
    }
    
    //MARK:- Static Sort Methods
    
    static func sortByType(activites : [ActivityModel]) -> [ActivityModel]{
        return activites.sorted(by: {
            return $0.type < $1.type
        })
    }
    
    static func sortByName(activites : [ActivityModel]) -> [ActivityModel]{
        return activites.sorted(by: {$0.activity < $1.activity})
    }
    
    static func sortByParticipants(activites : [ActivityModel]) -> [ActivityModel]{
        return activites.sorted(by: {
            return $0.participants ?? 0  < $1.participants ?? 0
        })
    }
    
    static func sortByPrice(activites : [ActivityModel]) -> [ActivityModel]{
        return activites.sorted(by: {
            return $0.price ?? 0  < $1.price ?? 0
        })
    }
    
    static func sortByAccessibility(activites : [ActivityModel]) -> [ActivityModel]{
        return activites.sorted(by: {
            return $0.accessibility ?? 0  < $1.accessibility ?? 0
        })
    }
    
    
}
