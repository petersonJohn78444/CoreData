//
//  User+CoreDataProperties.swift
//
//  Created  on 28/11/18.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var category: String?
    @NSManaged public var companyname: String?

}
