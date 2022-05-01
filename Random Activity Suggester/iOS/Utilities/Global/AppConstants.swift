//
//  BoredAPIManager.swift
//  Random Activity Suggester
//
//  Created by mani
//

import Foundation

class AppConstants {
    static var shared : AppConstants{
        return AppConstants()
    }
    
    var types : [String] {
        return ["Select","Education", "Recreational", "Social", "DIY", "Charity", "Cooking", "Relaxation", "Music", "Busywork"]
    }
}
