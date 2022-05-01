//
//  MainTabBarController.swift
//  Random Activity Suggester
//
//  Created by mani
//

import UIKit

class MainTabBarController : UITabBarController{
    let searchVC = UINavigationController(rootViewController: ActivitySearchViewController())
    let favouritesVC = UINavigationController(rootViewController: FavouriteListViewController(titleString: "Favourites"))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        
        self.viewControllers = [searchVC,favouritesVC]
        self.tabBar.backgroundColor = .systemBackground
    }

}
