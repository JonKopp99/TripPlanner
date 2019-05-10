//
//  mapItem.swift
//  TripPlanner
//
//  Created by Jonathan Kopp on 5/9/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation
import UIKit

public class mapItem: NSObject, NSCoding {
    
    var name: String
    var xLoc: String?
    var yLoc: String?
    
    // Protocol requires having Keys for our variables
    enum Keys: String {
        case name = "name"
        case xLoc = "xLoc"
        case yLoc = "yLoc"
        
    }
    
    init(name: String, xLoc: String?, yLoc: String?) {
        
        /** For Future Feature: Ability to access Contacts app:
         init(name: String, profileImage: UIImage, contactNumber: String?) {
         
         self.profileImage = profileImage
         **/
        
        self.name = name
        self.xLoc = xLoc
        self.yLoc = yLoc
    }
    
    // Protocol requires an encode method to encode our variables based on the Key
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(xLoc, forKey: "xLoc")
        aCoder.encode(yLoc, forKey: "yLoc")
    }
    
    // Protocol requires an init method which acts as a decoder for our variables based on the Key
    public required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        xLoc = aDecoder.decodeObject(forKey: "xLoc") as? String
        yLoc = aDecoder.decodeObject(forKey: "yLoc") as? String
        super.init()
    }
    
}
