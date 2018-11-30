//
//  TableItem.swift
//  MVVM Practice
//
//  Created by UHP Mac 3 on 28/11/2018.
//  Copyright © 2018 UHP. All rights reserved.
//

import Foundation

struct TableItem {
    let title: String
    let subtitle: String
    
    init(user: User) {
        self.title = user.name
        self.subtitle = user.comment
    }
}
