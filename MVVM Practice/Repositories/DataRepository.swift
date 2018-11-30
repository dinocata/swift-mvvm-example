//
//  DataRepository.swift
//  MVVM Practice
//
//  Created by UHP Mac 3 on 28/11/2018.
//  Copyright © 2018 UHP. All rights reserved.
//

import RxSwift

protocol DataRepository {
    func getData() -> Single<[User]>
}

class DataRepositoryImpl: DataRepository {
    
    func getData() -> Single<[User]> {
        let users = [User(name: "John Doe", comment: "some comment"),
                     User(name: "Marko Maric", comment: "Dos dobar komsija"),
                     User(name: "Ivica Todoric", comment: "Gazda")]
        
        return Single.just(users)
    }
    
}

