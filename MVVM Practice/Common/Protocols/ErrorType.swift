//
//  ErrorType.swift
//  MVVM Practice
//
//  Created by UHP Mac 3 on 28/11/2018.
//  Copyright © 2018 UHP. All rights reserved.
//

import Foundation

protocol ErrorType {
    var errorMessage: String? { get }
}

class DefaultError: ErrorType {
    var errorMessage: String?
    
    init() {
        self.errorMessage = "An error occurred"
    }
}
