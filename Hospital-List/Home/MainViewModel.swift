//
//  MainViewModel.swift
//  Hospital-List
//
//  Created by Eddy on 2022/10/01.
//

import Foundation

import RxRelay
import RxSwift

protocol HospitalListViewModelInput {
    func markerDidTap(item: Item)
    func saveButtonDidTap(item: Item)
    func requestHospitalList(xPos: Double, yPos: Double, ServiceKey: CommonRequest.ServiceKey, type: CommonRequest.type, radius: Double)
}

protocol HospitalListViewModelOutput {
    var isLoadingRelay: BehaviorRelay<Bool> { get }
    var errorRelay: PublishRelay<String> { get }
    var markerItemsRelay: PublishRelay<[Item]> { get }
    var infoRelay: PublishRelay<Item> { get }
}

final class MainViewModel: HospitalListViewModelInput, HospitalListViewModelOutput {
    private let hospitalService: HospitalListService
    private let storage: Storage
    private let disposeBag = DisposeBag()
    let isLoadingRelay = BehaviorRelay(value: true)
    let errorRelay = PublishRelay<String>()
    let markerItemsRelay = PublishRelay<[Item]>()
    let infoRelay = PublishRelay<Item>()

    init(network: Networking, storage: Storage) {
        self.hospitalService = HospitalListService(network: network)
        self.storage = storage
    }

    func markerDidTap(item: Item) {
        infoRelay.accept(item)
    }

    func saveButtonDidTap(item: Item) {
        storage.save(item: item)
    }

    func requestHospitalList(xPos: Double, yPos: Double, ServiceKey: CommonRequest.ServiceKey, type: CommonRequest.type, radius: Double) {
        isLoadingRelay.accept(true)
        hospitalService.hospitalList(.init(yPos: yPos, xPos: xPos, ServiceKey: ServiceKey, _type: type, radius: radius))
            .map { hospitalResponse in
                return hospitalResponse.response.body.items.item
            }
            .subscribe(onSuccess: { [weak self] items in
                self?.markerItemsRelay.accept(items)
                self?.isLoadingRelay.accept(false)
            }, onFailure: { [weak self] error in
                self?.errorRelay.accept(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}
