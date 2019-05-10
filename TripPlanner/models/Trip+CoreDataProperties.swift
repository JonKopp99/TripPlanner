//
//  Trip+CoreDataProperties.swift
//  TripPlanner
//
//  Created by Jonathan Kopp on 5/9/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//
//

import Foundation
import CoreData
import MapKit

extension Trip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trip> {
        return NSFetchRequest<Trip>(entityName: "Trip")
    }

    @NSManaged public var tripname: String
    @NSManaged public var waypoints: [MKMapItem]?

}
