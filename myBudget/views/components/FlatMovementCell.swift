//
//  FlatMovementCell.swift
//  myBudget
//
//  Created by Ruggiero Altini on 24/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import UIKit

public class DateHeader: UITableViewHeaderFooterView {
    private static let dateFormatter = DateFormatter()
    
    public var date: Date? {
        didSet {
            guard let date = date else {
                print("nil date")
                return
            }
            dateLabel?.text = DateHeader.dateFormatter.string(from: date)
            print(dateLabel?.text ?? "nil text")
        }
    }
    
    private var dateLabel: UILabel?
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        DateHeader.dateFormatter.dateFormat = "dd LLLL yyyy"
        
        let dateLabel = UILabel()
        contentView.addSubview(dateLabel)
        dateLabel.font = UIFont.boldSystemFont(ofSize: 16)
        dateLabel.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: nil, padding: .init(top: 4, left: 16, bottom: 4, right: 0), size: .zero)
        
        self.dateLabel = dateLabel
        contentView.backgroundColor = UIColor.white
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        DateHeader.dateFormatter.dateFormat = "dd LLLL yyyy"
    }
}

public class FlatMovementCell: UITableViewCell {
    private static let dateFormatter = DateFormatter()
    
    public var date: Date? {
        didSet {
            
            FlatMovementCell.dateFormatter.dateFormat = "dd LLLL yyyy"
            // let calendar = Calendar.current
            
            if let date = date {
                // let year = calendar.component(.year, from: date)
                // let month = calendar.component(.month, from: date)
                // let day = calendar.component(.day, from: date)
                dateLabel?.text = FlatMovementCell.dateFormatter.string(from: date)
                print(dateLabel?.text ?? "nil text")
            }
        }
    }
    public var title: String = "" {
        didSet {
            titleLabel?.text = title
        }
    }
    public var icon: UIImage? {
        didSet {
            iconImageView?.image = icon
        }
    }
    public var author: String? {
        didSet {
            authorLabel!.text = author
        }
    }
    public var amount: Double = 0 {
        didSet {
            amountLabel?.text = amount.formattedCurrencyMovement()
            refreshAmountColor()
        }
    }
    
    // Settable Attributes
    public var tintPositive: UIColor = UIColor.green {
        didSet {
            refreshAmountColor()
        }
    }
    public var tintNegative: UIColor = UIColor.red {
        didSet {
            refreshAmountColor()
        }
    }
    
    // Fields
    
    private var dateLabel: UILabel?
    private var titleLabel: UILabel?
    private var amountLabel: UILabel?
    private var iconImageView: UIImageView?
    
    // Detail
    private var calendarImageView: UIImageView?
    private var authorImageView: UIImageView?
    private var authorLabel: UILabel?
    
    @inline(__always) func refreshAmountColor() {
        amountLabel?.textColor = amount < 0 ? tintNegative : tintPositive
    }
    
    @inline(__always)
    func commonInit() {
        
        let iconImageView = UIImageView()
        contentView.addSubview(iconImageView)
        iconImageView.image = UIImage(named: "category_animal")
        iconImageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 20, bottom: 0, right: 0), size: .init(width: 24, height: 24))
        
        self.iconImageView = iconImageView
        
        let titleLabel = UILabel()
        contentView.addSubview(titleLabel)
        titleLabel.anchor(top: contentView.topAnchor, leading: iconImageView.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0), size: .zero)
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        
        self.titleLabel = titleLabel
        
        let authorLabel = UILabel()
        contentView.addSubview(authorLabel)
        authorLabel.anchor(top: titleLabel.bottomAnchor, leading: iconImageView.trailingAnchor, bottom: contentView.bottomAnchor, trailing: nil, padding: .init(top: 2, left: 12, bottom: 12, right: 0), size: .zero)
        authorLabel.font = UIFont.systemFont(ofSize: 21)
        authorLabel.textColor = UIColor.gray
        
        self.authorLabel = authorLabel
        
        let amountLabel = UILabel()
        amountLabel.font = titleLabel.font
        contentView.addSubview(amountLabel)
        amountLabel.anchor(top: contentView.topAnchor, leading: nil, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 12), size: .zero)
        
        self.amountLabel = amountLabel
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        /*
         let dateLabel = UILabel()
         contentView.addSubview(dateLabel)
         dateLabel.font = UIFont.boldSystemFont(ofSize: 16)
         dateLabel.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 16, bottom: 0, right: 0), size: .zero)
         
         self.dateLabel = dateLabel
         */
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
}
