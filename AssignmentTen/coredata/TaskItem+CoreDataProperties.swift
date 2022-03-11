//
//  TaskItem+CoreDataProperties.swift
//  AssignmentTen
//
//  Created by karma on 3/11/22.
//
//

import Foundation
import CoreData


extension TaskItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskItem> {
        return NSFetchRequest<TaskItem>(entityName: "TaskItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var createdAt: Date?

}

extension TaskItem : Identifiable {

}
