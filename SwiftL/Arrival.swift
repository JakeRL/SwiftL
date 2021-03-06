//
//  Arrival.swift
//  SwiftL
//
//  Created by Jake Robinson-Lieberman on 1/22/16.
//  Copyright © 2016 JakeRL. All rights reserved.
//

import UIKit
import SWXMLHash

class Arrival: NSObject {
    // Numeric GTFS parent station ID which this prediction is for (five digits in 4xxxx range) (matches “mapid” specified by requestor in query)
    let staId: Int
    
    // Numeric GTFS unique stop ID within station which this prediction is for (five digits in 3xxxx range)
    let stpId: Int
    
    // Textual proper name of parent station
    let staNm: String
    
    // Textual description of platform for which this prediction applies
    let stpDe: String
    
    // Run number of train being predicted for
    let rn: Int
    
    // Textual, abbreviated route name of train being predicted for (matches GTFS routes)
    let rt: String
    
    // GTFS unique stop ID where this train is expected to ultimately end its service run (experimental and supplemental only—see note below)
    let destSt: Int
    
    // Friendly destination description (see note below)
    let destNm: String
    
    // Numeric train route direction code (see appendices)
    let trDr: Int
    
    // Date-time format stamp for when the prediction was generated:
    // yyyyMMdd HH:mm:ss (24-hour format, time local to Chicago)
    let prdt: String
    
    // Date-time format stamp for when a train is expected to arrivvar depart:
    // yyyyMMdd HH:mm:ss (24-hour format, time local to Chicago)
    let arrT: String
    
    // Indicates that Train Tracker is now declaring “Approaching” or “Due” on site for this train
    var isApp: Int?
  
    // Boolean flag to indicate whether this is a live prediction or based on schedule in lieu of live data
    var isSch: String?

    // Boolean flag to indicate whether a potential fault has been detected (see note below)
    var isFlt: String?

    // Boolean flag to indicate whether a train is considered “delayed” in Train Tracker
    var isDly: String?
    
    // Latitude position of the train in decimal degrees
    var lat: Double?

    // Longitude position of the train in decimal degrees
    var lon: Double?
    
    // Heading, expressed in standard bearing degrees (0 = North, 90 = East, 180 = South, and 270 = West; range is 0 to 359, progressing clockwise)
    var heading: Int?
    
    init(arrival: XMLIndexer) {
        // String values
        staNm  = arrival["staNm"].element!.text!
        stpDe  = arrival["stpDe"].element!.text!
        rt     = arrival["rt"].element!.text!
        destNm = arrival["destNm"].element!.text!
        prdt   = arrival["prdt"].element!.text!
        arrT   = arrival["arrT"].element!.text!
        
        // Int values
        staId  = Int(arrival["staId"].element!.text!)!
        stpId  = Int(arrival["stpId"].element!.text!)!
        rn     = Int(arrival["rn"].element!.text!)!
        destSt = Int(arrival["destSt"].element!.text!)!
        trDr   = Int(arrival["trDr"].element!.text!)!
    }
}