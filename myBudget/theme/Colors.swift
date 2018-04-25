//
//  Colors.swift
//  myBudget
//
//  Created by Ruggiero Altini on 19/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import UIKit

struct Colors {
    let lightBlue = UIColor(displayP3Red: 255.0/255.0, green: 0.0, blue: 0x99/255.0, alpha: 0xcc/255.0)
    
    static let greenIncoming: UIColor = .rgb(0x00701A)
    static let redExpense: UIColor = .rgb(0xE35D53)
    
    struct Chart {
        
        
        static let liberty: [UIColor] = [.intRgb(207, 248, 246), .intRgb(148, 212, 212), .intRgb(136, 180, 187), .intRgb(118, 174, 175), .intRgb(42, 109, 130)]
        static let joyful: [UIColor] = [.intRgb(217, 80, 138), .intRgb(254, 149, 7), UIColor.intRgb(254, 247, 120), .intRgb(106, 167, 134), .intRgb(53, 194, 209)]
        static let pastel: [UIColor] = [.intRgb(64, 89, 128), .intRgb(149, 165, 124), .intRgb(217, 184, 162), .intRgb(191, 134, 134), .intRgb(179, 48, 80)]
        static let colorful: [UIColor] = [.intRgb(193, 37, 82), .intRgb(255, 102, 0), .intRgb(245, 199, 0), .intRgb(106, 150, 31), .intRgb(179, 100, 53)]
        static let vordiplom: [UIColor] = [.intRgb(192, 255, 140), .intRgb(255, 247, 140), .intRgb(255, 208, 140), .intRgb(140, 234, 255), .intRgb(255, 140, 157)]
        static let material: [UIColor] = [.rgb(0x2ecc71), .rgb(0xf1c40f), .rgb(0xe74c3c), .rgb(0x3498db), .rgb(0xff9800)]
    }
}
