//
//  ActivityDisplayVC.swift
//  Random Activity Suggester
//
//  Created by mani
//

import UIKit
import Toast_Swift

class ActivityDisplayViewController : UIViewController{
    
    private var activity : ActivityModel
    
    private var activityLabel : CustomLabel = CustomLabel()
    
    private var participantsLabel : CustomLabel = CustomLabel()
    
    private var activityTypeLabel : CustomLabel = CustomLabel()
    
    private var accessibileLabel : CustomLabel = CustomLabel()
    
    private var costLabel : CustomLabel = CustomLabel()
    
    private var entityHeight : CGFloat = 80
    
    private var distanceBetweenEntities : CGFloat = 10
    
    private var addToFavouritesButton : UIButton = UIButton()
    
    var isFromSearchVC = true{
        didSet{
            addToFavouritesButton.isHidden = !isFromSearchVC
        }
    }
    
    init(activity:ActivityModel){
        self.activity = activity
        super.init(nibName: nil, bundle: nil)
        setData()
    }
    
    required init?(coder: NSCoder) {
        self.activity = ActivityModel(activity: "", accessibility: 0, type: "", key: "")
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setUI()
    }
    
    private func setData(){
        self.activityLabel.valueText = activity.activity
        self.activityTypeLabel.valueText = activity.type
        self.participantsLabel.valueText = activity.getParticipantsText()
        self.accessibileLabel.valueText = activity.getAccessibilityText()
        self.costLabel.valueText = activity.getCostEffectiveText()
    }
    
    private func setUI(){
        setActivityLabel()
        setParticipantsLabel()
        setActivityTypeLabel()
        setAccessibileLabel()
        setcostLabel()
        setAddToFavouritesButton()
    }
    
    private func setActivityLabel(){
        activityLabel.translatesAutoresizingMaskIntoConstraints = false
        activityLabel.hideArrow = true
        activityLabel.titleText = "Activity"
        self.view.addSubview(activityLabel)
        let constraints = [
            activityLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: distanceBetweenEntities),
            activityLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 0),
            activityLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: 0),
            activityLabel.heightAnchor.constraint(equalToConstant: entityHeight)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setParticipantsLabel(){
        participantsLabel.translatesAutoresizingMaskIntoConstraints = false
        participantsLabel.hideArrow = true
        participantsLabel.titleText = "Number Of Participants"
        self.view.addSubview(participantsLabel)
        let constraints = [
            participantsLabel.topAnchor.constraint(equalTo: self.activityLabel.bottomAnchor,constant: distanceBetweenEntities),
            participantsLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 0),
            participantsLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: 0),
            participantsLabel.heightAnchor.constraint(equalToConstant: entityHeight)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setActivityTypeLabel(){
        activityTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        activityTypeLabel.hideArrow = true
        activityTypeLabel.titleText = "Activity Type"
        self.view.addSubview(activityTypeLabel)
        let constraints = [
            activityTypeLabel.topAnchor.constraint(equalTo: self.participantsLabel.bottomAnchor,constant: distanceBetweenEntities),
            activityTypeLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 0),
            activityTypeLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: 0),
            activityTypeLabel.heightAnchor.constraint(equalToConstant: entityHeight)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setAccessibileLabel(){
        accessibileLabel.translatesAutoresizingMaskIntoConstraints = false
        accessibileLabel.hideArrow = true
        accessibileLabel.titleText = "Accessibility"
        self.view.addSubview(accessibileLabel)
        let constraints = [
            accessibileLabel.topAnchor.constraint(equalTo: self.activityTypeLabel.bottomAnchor,constant: distanceBetweenEntities),
            accessibileLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 0),
            accessibileLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: 0),
            accessibileLabel.heightAnchor.constraint(equalToConstant: entityHeight)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setcostLabel(){
        costLabel.translatesAutoresizingMaskIntoConstraints = false
        costLabel.hideArrow = true
        costLabel.titleText = "Cost Details"
        self.view.addSubview(costLabel)
        let constraints = [
            costLabel.topAnchor.constraint(equalTo: self.accessibileLabel.bottomAnchor,constant: distanceBetweenEntities),
            costLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 0),
            costLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: 0),
            costLabel.heightAnchor.constraint(equalToConstant: entityHeight)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setAddToFavouritesButton(){
        
        addToFavouritesButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(addToFavouritesButton)
        addToFavouritesButton.setImage(UIImage(named: "add-to-favorites"), for: .normal)
        addToFavouritesButton.addTarget(self, action: #selector(addToFavouritesTapped(_:)), for: .touchUpInside)
        addToFavouritesButton.backgroundColor = .systemBackground
        
        let constraints = [
            addToFavouritesButton.topAnchor.constraint(equalTo: self.costLabel.bottomAnchor,constant: distanceBetweenEntities),
            addToFavouritesButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            addToFavouritesButton.widthAnchor.constraint(equalToConstant: 50),
            addToFavouritesButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    
    @objc func addToFavouritesTapped(_ sender : UIButton){
        if !PersistentData.favouriteActivties.contains(activity){
            PersistentData.favouriteActivties.append(activity)
            self.view.makeToast("Activity added to favourities", duration: 3.0, position: .center)
            PersistentData.saveToUserDefaults()
        }
        else{
            self.view.makeToast("Activity already added to favourities", duration: 3.0, position: .center)
        }
        
    }
    
}
