//
//  ArrayToDictionary.swift
//  myBudget
//
//  Created by Ruggiero Altini on 25/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

extension Array {
    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element] {
        var dict: [Key:Element] = [:]
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}
