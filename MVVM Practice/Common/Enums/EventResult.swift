//
//  EventResult.swift
//  MVVM Practice
//
//  Created by UHP Mac 3 on 28/11/2018.
//  Copyright © 2018 UHP. All rights reserved.
//

import Foundation

enum EventResult<Value> {
    case loading
    case success(Value)
    case failure(ErrorType)
}
