//
//  PersistentData.swift
//  Random Activity Suggester
//
//  Created by mani
//

import Foundation


class PersistentData {
    
    static let favActivityUserDefaultsKey = "favActivity"
    static let favActivityFilterKey = "favFilter"
    
    static let selectedFilter : String = ""
        
    private init(){
        
    }
    
    static var favouriteActivties : [ActivityModel] = []
    
    static func saveToUserDefaults(){
        UserDefaults.standard.set(try? PropertyListEncoder().encode(PersistentData.favouriteActivties), forKey:favActivityUserDefaultsKey)
    }
    
    static func loadFromUserDefaults(){
        if let data = UserDefaults.standard.value(forKey:favActivityUserDefaultsKey) as? Data {
            if let activies = try? PropertyListDecoder().decode(Array<ActivityModel>.self, from: data){
                PersistentData.favouriteActivties = activies
            }
        }
        
    }
    
}
