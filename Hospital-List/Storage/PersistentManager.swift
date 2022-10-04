//
//  PersistentManager.swift
//  Hospital-List
//
//  Created by Eddy on 2022/10/04.
//

import CoreData
import Foundation

import RxRelay

final class PersistentManager: Storage {
    static let shared = PersistentManager()
    private let storageRelay = BehaviorRelay<[Hospital]>(value: [])

    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "HospitalList")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to load \(error)")
            }
        }

        return container
    }()

    private var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    init() {
        let request = HospitalEntity.fetchRequest()
        let sort = NSSortDescriptor(key: "saveTime", ascending: false)
        request.sortDescriptors = [sort]
        guard let hospitalData = try? mainContext.fetch(request) else { return }
        let hospitals =  hospitalData.map { hospitalEntity in
            Hospital(name: hospitalEntity.name, address: hospitalEntity.address, saveTime: hospitalEntity.saveTime)
        }
        storageRelay.accept(hospitals)
    }

    func fetch() -> BehaviorRelay<[Hospital]> {
        return storageRelay
    }

    private func saveContext() {
        guard mainContext.hasChanges else {
            return
        }

        do {
            try mainContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    func save(item: Item) {
        let hospital = Hospital(name: item.name, address: item.address, saveTime: Date())
        if let _ = storageRelay.value.first(where: {
            $0.name == hospital.name
        }) {
            return
        }

        storageRelay.accept(storageRelay.value + [hospital])
        let entity = HospitalEntity(context: mainContext)
        entity.name = item.name
        entity.address = item.address
        entity.saveTime = Date()
        saveContext()
    }
}
