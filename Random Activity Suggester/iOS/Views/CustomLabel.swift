//
//  DropDownLabel.swift
//  Random Activity Suggester
//
//  Created by mani
//

import UIKit

class CustomLabel : UIView{
    
    var titleText : String = ""{
        didSet{
            textLabel.text = titleText
        }
    }
    var valueText : String = ""{
        didSet{
            valueLabel.text = valueText
        }
    }
    
    var tapDelegate : (() -> Void)? = nil
    
    var hideArrow : Bool = false{
        didSet{
            imageView.isHidden = hideArrow
        }
    }
    
    private var textLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
//        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    private var valueLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
//        label.textColor = .black
        label.numberOfLines = 0
        label.backgroundColor = .clear
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "next")?.withRenderingMode(.alwaysTemplate)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(){
        self.backgroundColor = .clear
        self.addSubview(textLabel)
        self.addSubview(valueLabel)
        self.addSubview(imageView)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        textLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        textLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        
        
        valueLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 5).isActive = true
        valueLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        valueLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        valueLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -5).isActive = true
        
        
        imageView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 5).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.valueLabel.heightAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        
        addTapGesture()
        
    }
    
    func addTapGesture(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        self.addGestureRecognizer(gesture)
    }
    
    @objc func didTap(_ sender : UIGestureRecognizer){
        tapDelegate?()
    }
    
    
}
