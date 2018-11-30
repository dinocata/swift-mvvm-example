//
//  StringExtensions.swift
//  MVVM Practice
//
//  Created by UHP Mac 3 on 28/11/2018.
//  Copyright © 2018 UHP. All rights reserved.
//

import Foundation

extension String {
    
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    
}
