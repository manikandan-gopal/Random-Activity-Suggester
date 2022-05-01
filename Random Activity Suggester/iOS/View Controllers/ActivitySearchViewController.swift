//
//  ActivitySearchViewController.swift
//  Random Activity Suggester
//
//  Created by mani
//

import UIKit
import DropDown
//import AlertToast
import Toast_Swift

class ActivitySearchViewController : UIViewController,TabBarSetup{
    
    private var activityLoader : UIActivityIndicatorView = UIActivityIndicatorView()
    
    private var categoryDropDownLabel : CustomLabel = CustomLabel()
    private let dropDown = DropDown()
    private var searchButton = UIButton()
    
    private var selectedKey : String? = nil
    private var selectedTitle : String = "Select"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        initialSetup()
        PersistentData.loadFromUserDefaults()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUI()
    }
    
    func initialSetup(){
        self.title = "Activity Search"
        self.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = .systemBackground
    }
    
    private func setUI(){
        activityLoader.center = self.view.center
        activityLoader.tintColor = .systemBlue
        setCategoryDropDownLabel()
        setDropDown()
        setSearchButton()
        
    }
    
    private func setCategoryDropDownLabel(){
       
        
        
        self.view.addSubview(categoryDropDownLabel)
        categoryDropDownLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            categoryDropDownLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 20),
            categoryDropDownLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            categoryDropDownLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            categoryDropDownLabel.heightAnchor.constraint(equalToConstant: 80)
        ]
        NSLayoutConstraint.activate(constraints)
        
        categoryDropDownLabel.titleText = "Select Category"
        categoryDropDownLabel.valueText = selectedTitle
        categoryDropDownLabel.backgroundColor = .systemBackground
        categoryDropDownLabel.tapDelegate = tapInvoked
        categoryDropDownLabel.layoutSubviews()
        categoryDropDownLabel.setNeedsLayout()
        
        self.view.layoutSubviews()
        
        
        
    }
    
    func setDropDown(){
        dropDown.anchorView = self.view
        dropDown.anchorView = categoryDropDownLabel
        dropDown.dataSource = AppConstants.shared.types
        dropDown.backgroundColor = .tertiarySystemBackground
        dropDown.textFont = UIFont.systemFont(ofSize: 16)
        dropDown.direction = .bottom
        dropDown.selectionAction = {(index,title) in
            self.categoryDropDownLabel.valueText = title
            self.selectedTitle = title
            if title != "Select"{
                self.selectedKey = title.lowercased()
            }
            else{
                self.selectedKey = nil
            }
        }
    }
    
    func tapInvoked(){
        dropDown.show()
    }
    
    func setSearchButton(){
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(searchButton)
        searchButton.setTitle("Search", for: .normal)
        searchButton.addTarget(self, action: #selector(searchButtonTapped(_:)), for: .touchUpInside)
        searchButton.backgroundColor = .systemBlue
        
        let constraints = [
            searchButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant : -10),
            searchButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant : -10),
            searchButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant : 10),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    @objc func searchButtonTapped(_ sender : UIButton){
        self.fetchActivity()
    }
    
    func fetchActivity(){
        var dict : [String:Any] = [:]
        if let key = selectedKey{
            dict["type"] = key
        }
        self.showLoader()
        APICallManager.shared.getActivity(with: dict) { data, error in
            self.dismissLoader()
            let result = DataManupulator.shared.handleAPIResponse(data: data, error: error)
            switch result{
            case .success(let activity):
                if PersistentData.favouriteActivties.contains(activity){
                    self.fetchActivity()
                }
                else{
                    let vc = ActivityDisplayViewController(activity: activity)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            case .failure(let error):
                self.view.makeToast(error.localizedDescription, duration: 5.0, position: .center)
            }
        }
    }
    
    private func showLoader(){
        self.view.addSubview(activityLoader)
        activityLoader.tintColor = .systemBlue
        activityLoader.color = .systemBlue
        activityLoader.startAnimating()
    }
    
    private func dismissLoader(){
        activityLoader.stopAnimating()
        activityLoader.removeFromSuperview()
    }
}
