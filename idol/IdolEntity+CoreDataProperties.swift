//
//  IdolEntity+CoreDataProperties.swift
//  idol
//
//  Created by 吴汪洋 on 15/12/15.
//  Copyright © 2015年 吴汪洋. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension IdolEntity {

    @NSManaged var button1: String?
    @NSManaged var button2: String?
    @NSManaged var button3: String?
    @NSManaged var host: String?
    @NSManaged var id: NSNumber?
    @NSManaged var portnum: NSNumber?

}
