//
//  HospitalListViewModel.swift
//  Hospital-List
//
//  Created by Eddy on 2022/10/04.
//

import Foundation

import RxRelay

protocol HospitalViewModelOutput {
    var hospitals: BehaviorRelay<[Hospital]> { get }
}

final class HospitalViewModel: HospitalViewModelOutput {
    let storage: Storage
    var hospitals: BehaviorRelay<[Hospital]> {
        return storage.fetch()
    }

    init(storage: Storage) {
        self.storage = storage
    }
}
