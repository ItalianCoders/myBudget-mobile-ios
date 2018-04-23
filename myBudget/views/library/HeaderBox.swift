//
//  HeaderBox.swift
//  myBudget
//
//  Created by Ruggiero Altini on 19/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import UIKit

@IBDesignable
class HeaderBox: UIView {
    @IBInspectable
    var color: UIColor = UIColor.black {
        didSet {
            coloredView?.backgroundColor = color
            bodyText?.textColor = color
        }
    }
    @IBInspectable
    var title: String = "" {
        didSet {
            headerTitle?.text = title
        }
    }
    @IBInspectable
    var text: String? = "" {
        didSet {
            bodyText?.text = text
        }
    }
    @IBInspectable
    var shadowOpacity: Float = 0.5 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    @IBInspectable
    var shadowOffsetHeight: CGFloat = 5.0 {
        didSet {
            layer.shadowOffset.height = shadowOffsetHeight
        }
    }
    
    private weak var coloredView: UIView?
    private weak var headerTitle: UILabel?
    private weak var bodyText: UILabel?
    
    private func create() {
        let coloredView = UIView()
        addSubview(coloredView)
        coloredView.anchor(top: self.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        coloredView.anchor(height: 20)
        coloredView.backgroundColor = color
    
        
        let headerTitle = UILabel()
        coloredView.addSubview(headerTitle)
        headerTitle.enableAutoLayout()
        headerTitle.centerSuperview()
        headerTitle.textColor = UIColor.white
        headerTitle.text = title
        headerTitle.font = UIFont.boldSystemFont(ofSize: 12)
        
        let bodyView = UIView()
        addSubview(bodyView)
        bodyView.anchor(top: coloredView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        let bodyText = UILabel()
        bodyView.addSubview(bodyText)
        bodyText.enableAutoLayout()
        bodyText.centerSuperview()
        bodyText.backgroundColor = UIColor.white
        bodyText.textColor = color
        bodyText.text = text
        headerTitle.font = UIFont.boldSystemFont(ofSize: 14)
        
        self.coloredView = coloredView
        self.headerTitle = headerTitle
        self.bodyText = bodyText
        
        let shadowPath = UIBezierPath(rect: bounds)
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        create()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        create()
    }
}
