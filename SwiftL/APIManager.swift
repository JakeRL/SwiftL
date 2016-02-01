//
//  APIManager.swift
//  SwiftL
//
//  Created by Jake Robinson-Lieberman on 1/22/16.
//  Copyright © 2016 JakeRL. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SWXMLHash

let kAPIKeyName = "CTA"
let kAPIBaseURL = NSURL(string: "http://lapi.transitchicago.com/api/1.0/")!

// Arrivals API
let arrivalsAPIEndPoint               = "ttarrivals.aspx"
let numericStationIdentifierParameter = "mapid" // required if stpid not provided
let numericStopIdentifierParameter    = "stpid" // required if mapid not provided
let maximumResultsParameter           = "max"   // optional
let routeCodeParameter                = "rt"    // optional

// Follow Train API
let followAPIEndPoint       = "ttfollow.aspx"
let trainRunNumberParameter = "runnumber"       // required

// Locations API
let locationsAPIEndPoint = "ttpositions.aspx"
let trainRoutesParameter = "rt"                 // required

class APIManager: NSObject {
    static let sharedManager = APIManager()

    func getStationsForLine (line: Line, completion: (stations: [JSON], error: NSError?) -> Void) {
        if let path = NSBundle.mainBundle().pathForResource("cta_L_stops", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
                let stopList = JSON(data: jsonData)
                if stopList != JSON.null {
                    
                    var lineList: [JSON] = []
                    for (_, stop):(String, JSON) in stopList {
                        if stop[line.routeId()] {
                            lineList.append(stop)
                        }
                    }
                    
                    completion(stations: lineList, error: .None)
                }
                
            } catch let error as NSError {
                print(error.localizedDescription)
                completion(stations: [], error: error)
            }
        }
    }
    
    func getArrivalsForStation (station: JSON, completion: (arrivals: [Arrival], error: NSError?) -> Void) {
        
        let endPoint: String = "\(kAPIBaseURL)\(arrivalsAPIEndPoint)?key=\(apiKey())&mapid=\(station["MAP_ID"])"
    
        Alamofire.request(.GET, endPoint)
                 .response { request, response, data, error in
                    
                    let xmlResponse = SWXMLHash.parse(data!)
                    print(xmlResponse)
                    
                    var arrivalsList: [Arrival] = []
                    
                    for eta in xmlResponse["ctatt"]["eta"] {
                        arrivalsList.append(Arrival(arrival: eta))
                    }
                    
                    completion(arrivals: arrivalsList, error: error)
        }
    }
    
    func apiKey() -> String {
        if let filePath = NSBundle.mainBundle().pathForResource("APIKeys", ofType:"plist") {
            let plist = NSDictionary(contentsOfFile:filePath)
            if let value: String = plist?.objectForKey(kAPIKeyName) as? String {
                return value
            }
        }
        return ""
    }
}
