//
//  ViewModelType.swift
//  MVVM Practice
//
//  Created by UHP Mac 3 on 28/11/2018.
//  Copyright © 2018 UHP. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
