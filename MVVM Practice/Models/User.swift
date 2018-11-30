//
//  User.swift
//  MVVM Practice
//
//  Created by UHP Mac 3 on 28/11/2018.
//  Copyright © 2018 UHP. All rights reserved.
//

import Foundation

struct User {
    let name: String
    let comment: String
    
    func matchesInput(_ input: String) -> Bool {
        let lowercased = input.lowercased()
        return name.lowercased().contains(find: lowercased) || comment.lowercased().contains(find: lowercased)
    }
}
