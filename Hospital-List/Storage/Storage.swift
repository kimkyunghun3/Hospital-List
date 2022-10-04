//
//  Storage.swift
//  Hospital-List
//
//  Created by Eddy on 2022/10/04.
//

import Foundation

import RxRelay

protocol Storage {
    func fetch() -> BehaviorRelay<[Hospital]>
    func save(item: Item)
}

final class MemoryStorage: Storage {
    private let storageRelay = BehaviorRelay<[Hospital]>(value: [])
    static let shared = MemoryStorage()

    private init() {}

    func fetch() -> BehaviorRelay<[Hospital]> {
        return storageRelay
    }

    func save(item: Item) {
        let hospital = Hospital(name: item.name, address: item.address, saveTime: Date())
        storageRelay.accept(storageRelay.value + [hospital])
    }
}
