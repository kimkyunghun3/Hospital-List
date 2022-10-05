//
//  HospitalEntity+CoreDataProperties.swift
//  Hospital-List
//
//  Created by Eddy on 2022/10/05.
//
//

import Foundation
import CoreData

extension HospitalEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<HospitalEntity> {
        return NSFetchRequest<HospitalEntity>(entityName: "HospitalEntity")
    }

    @NSManaged public var name: String
    @NSManaged public var address: String
    @NSManaged public var saveTime: Date
}

extension HospitalEntity : Identifiable {

}
