//
//  MovementsViewController.swift
//  myBudget
//
//  Created by Ruggiero Altini on 25/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import UIKit

class MovementsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var movements: [Movement] = [] {
        didSet {
            // Array-Set notation to remove duplicates
            var simpleDates = Array(Set(movements.map { return SimpleDate(bySeconds: $0.executedAt ?? 0)}))
            
            simpleDates.sort { lhs, rhs in
                if lhs.year > rhs.year { return true }
                else if lhs.year < rhs.year { return false }
                if lhs.month > rhs.month { return true }
                else if lhs.month < rhs.month { return false }
                if lhs.day > rhs.day { return true }
                else { return false }
            }
            self.dates = simpleDates
            for date in simpleDates {
                movementsPairs[date] = movements.filter { return SimpleDate(bySeconds: $0.executedAt ?? 0) == date }
            }
            
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }
    private var dates: [SimpleDate] = []
    private var movementsPairs: [SimpleDate: [Movement]] = [:]
    
    weak var tokenProvider: TokenProvider? {
        didSet {
            guard let tokenProvider = tokenProvider,
                let accessToken = tokenProvider.authResponse?.accessToken else {
                
                    print("NIL TOKEN")
                return
            }
            
            ApplicationController.handle(request: GetAccountDetailsRequest(id: tokenProvider.authResponse!.accounts[0].id), authToken: accessToken) { [weak self]
                result in
                
                switch result {
                case .success(let accountDetails):
                    //print("ACCOUNT DETAILS: ")
                    //print(accountDetails)
                    self?.movements = accountDetails.lastMovements ?? []
                case .failure(let error):
                    print("MOV ERROR: ")
                    print(error)
                }
            }
            /*
            let simpleDate = SimpleDate(by: Date())
            let (year, month) = (simpleDate.year, simpleDate.month-1)
            ApplicationController.handle(request: SearchMovementRequest(accountId: tokenProvider.authResponse!.accounts[0].id, year: year, month: month, day: day, page: 1), authToken: accessToken) { [weak self]
                result in
                
                switch result {
                case .success(let movementPage):
                    self?.movements = movementPage.content ?? []
                    print("MOV SUCCESS")
                    //print(movementPage)
                case .failure(let error):
                    print("error in MovementsViewController")
                    print(error)
                }
            }*/
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FlatMovementCell.self, forCellReuseIdentifier: "movement")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
    }
}

extension MovementsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = DateHeader(reuseIdentifier: "header")
        let movement: Movement? = movementsPairs[dates[section]]?[0]
        header.date = Date(timeIntervalSince1970: Double(movement?.executedAt ?? 0))
        
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        let separatorView = UIView(frame: CGRect(x: tableView.separatorInset.left, y: footerView.frame.height, width: tableView.frame.width - tableView.separatorInset.right, height: 1))
        separatorView.backgroundColor = _separatorColor
        footerView.addSubview(separatorView)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
}

extension MovementsViewController: UITableViewDataSource {

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return movementsPairs.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movementsPairs[dates[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movement", for: indexPath) as? FlatMovementCell
        let (row, section) = (indexPath.row, indexPath.section)
        if let cell = cell, let movement = movementsPairs[dates[section]]?[row] {
            cell.date = Date(timeIntervalSince1970: Double(movement.executedAt! / 1000))
            cell.author = movement.executedBy?.username
            let multiplier: Double
            if movement.type == .expense {
                multiplier = -1
            } else {
                multiplier = 1
            }
            cell.amount = (movement.amount ?? 0) * multiplier
            cell.icon = UIImage(named: categoryIcons[movement.category!.iconId!])
            cell.title = movement.category!.value!
            cell.tintPositive = Colors.greenIncoming
            cell.tintNegative = Colors.redExpense
            return cell
        } else {
            return FlatMovementCell()
        }
    }
}

extension UIColor {
    static var separatorColor: UIColor {
        return UIColor(red: 244, green: 244, blue: 244)
    }
}

fileprivate let _separatorColor = UIColor.separatorColor
