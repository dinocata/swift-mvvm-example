//
//  MainVM.swift
//  MVVM Practice
//
//  Created by UHP Mac 3 on 28/11/2018.
//  Copyright © 2018 UHP. All rights reserved.
//

import RxSwift
import RxCocoa

class MainVM: ViewModelType {
    
    private let dataRepository: DataRepository
    
    struct Input {
        let searchText: Driver<String>
    }
    
    struct Output {
        let dataItems: Driver<[TableItem]>
        let dataLoading: Driver<Bool>
        let dataError: Driver<ErrorType?>
        let emptyList: Driver<Bool>
    }
    
    init(dataRepository: DataRepository) {
        self.dataRepository = dataRepository
    }
    
    private func findUsersByInput(_ input: String) -> Single<[User]> {
        return dataRepository.getData()
            // Simulates API call
            .delay(0.5, scheduler: ConcurrentDispatchQueueScheduler(qos: .background))
            .map { $0.filter { $0.matchesInput(input) || input.isEmpty } }
    }
    
    private func transformDataEventDriver(_ inputSource: Observable<String>) -> Driver<EventResult<[TableItem]>> {
        let data = inputSource
            .flatMapLatest(findUsersByInput)
            .map { $0.map { TableItem(user: $0) } }
            .map { EventResult.success($0) }
            .share()
        
        let delayedData = data
            // Delay the actual response to avoid flickering
            .delay(0.5, scheduler: ConcurrentDispatchQueueScheduler(qos: .background))
        
        let loading = inputSource
            .delay(0.05, scheduler: ConcurrentDispatchQueueScheduler(qos: .background))
            .map { _ in EventResult<[TableItem]>.loading }
        
        let loadingThenData = Observable.merge([loading, delayedData])
        
        return data
            .amb(loadingThenData)
            .asDriver(onErrorJustReturn: .failure(DefaultError()))
    }
    
    func transform(input: Input) -> Output {
        let inputSource = input.searchText
            .throttle(0.5)
            .asObservable()
            .distinctUntilChanged()
        
        let dataEventDriver = transformDataEventDriver(inputSource)
        
        let dataLoadingDriver = dataEventDriver
            .map { event -> Bool in
                switch event {
                case .loading: return true
                default: return false
                }
        }
        
        let dataErrorDriver = dataEventDriver
            .map { event -> ErrorType? in
                switch event {
                case .failure(let error): return error
                default: return nil
                }
            }
            .filter { $0 != nil }
        
        let dataItemDriver = dataEventDriver
            .map { event -> [TableItem]? in
                switch event {
                case let .success(data): return data
                default: return nil
                }
            }
            .filter { $0 != nil }
            .map { $0! }
        
        let emptyListDriver = dataEventDriver
            .map { event -> Bool in
                switch event {
                case let .success(data): return data.count == 0
                default: return false
                }
        }
        
        return Output(dataItems: dataItemDriver,
                      dataLoading: dataLoadingDriver,
                      dataError: dataErrorDriver,
                      emptyList: emptyListDriver)
    }
    
}
