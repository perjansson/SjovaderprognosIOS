//
//  Area.swift
//  Sjovaderprognos
//
//  Created by Per Jansson on 2014-12-10.
//  Copyright (c) 2014 Per Jansson. All rights reserved.
//

import Foundation

class Area {
    
    var areaKey : String?
    var areaName : String?
    var link : String?
    var jsonLink : String?
    
    init(areaKey : String, areaName : String, link : String, jsonLink : String) {
        self.areaKey = areaKey
        self.areaName = areaName
        self.link = link
        self.jsonLink = jsonLink
    }
    
    class func createFromJson(areaObj: Dictionary<String, AnyObject>) -> Area! {
        if let areaKey = areaObj["areaKey"]? as? String {
            if let areaName = areaObj["areaName"]? as? String {
                if let link = areaObj["link"]? as? String {
                    if let jsonLink = areaObj["jsonLink"]? as? String {
                        return Area(areaKey: areaKey, areaName: areaName, link: link, jsonLink: jsonLink);
                    }
                }
            }
        }
        return nil
    }
    
}