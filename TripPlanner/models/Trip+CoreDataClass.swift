//
//  Trip+CoreDataClass.swift
//  TripPlanner
//
//  Created by Jonathan Kopp on 5/9/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//
//

import Foundation
import CoreData
import MapKit
@objc(Trip)
public class Trip: NSManagedObject {
    func addWP(mapItem: MKMapItem)
    {
        waypoints?.append(mapItem)
    }
}
