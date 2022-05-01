//
//  FavouriteListViewController.swift
//  Random Activity Suggester
//
//  Created by mani
//

import UIKit
import DropDown

class FavouriteListViewController : UIViewController,TabBarSetup,UITableViewDataSource,UITableViewDelegate{
    
    
    var titleString : String
    
    private var selectedFilter : String = ""
    private var activities : [ActivityModel] = []
    
    private let dropDown = DropDown()
    
    private var filterCategories : [String] = [
        "Name",
        "Type",
        "Participants",
        "Accessibility",
        "Cost"
    ]
    
    private var tableView : UITableView = UITableView()
    
    init(titleString: String){
        self.titleString = titleString
        super.init(nibName: nil, bundle: nil)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setTableView()
        setFilterButton()
        setDropDown()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.activities = PersistentData.favouriteActivties
        loadTableForFilter(filter: selectedFilter)
    }
    
    func initialSetup(){
        self.title = titleString
        self.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = .systemBackground
        self.tabBarItem.badgeColor = .white
    }
    
    private func setFilterButton(){
        let barButtonItem = UIBarButtonItem(image: UIImage(named: "filter")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(filterButtonTapped(_:)))
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    
    private func setTableView(){
        tableView.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "favouriteCell")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        let constraints = [
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    @objc private func filterButtonTapped(_ sender : UIBarButtonItem){
        dropDown.show()
    }
    
    private func setDropDown(){
        dropDown.anchorView = self.view
        dropDown.anchorView = self.navigationItem.rightBarButtonItem
        dropDown.dataSource = self.filterCategories
        dropDown.backgroundColor = .systemBackground
        dropDown.textFont = UIFont.systemFont(ofSize: 16)
        dropDown.direction = .bottom
        dropDown.selectionAction = {(index,title) in
            self.loadTableForFilter(filter: title)
        }
    }
    
    private func loadTableForFilter(filter : String){
        switch filter{
        case "Name":
            self.activities = ActivityModel.sortByName(activites: self.activities)
            
        case "Type":
            self.activities = ActivityModel.sortByType(activites: self.activities)
            
        case "Participants":
            self.activities = ActivityModel.sortByParticipants(activites: self.activities)
            
        case "Accessibility":
            self.activities = ActivityModel.sortByAccessibility(activites: self.activities)
            
        case "Cost":
            self.activities = ActivityModel.sortByPrice(activites: self.activities)
            
        default:
            break
        }
        
        self.tableView.reloadData()
        self.selectedFilter = filter
    }
    
    //MARK:- TableView Delegates
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteCell", for: indexPath)
        cell.textLabel?.text = activities[indexPath.row].activity
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let vc = ActivityDisplayViewController(activity: activities[indexPath.row])
        vc.isFromSearchVC = false
        self.navigationController?.pushViewController(vc, animated:true)
    }
}
