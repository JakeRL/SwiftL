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

let kAPIKey     = NSURL(string: "b00b70fd51d44ec0ba0fc3a3885b4616")!
let kAPIBaseURL = NSURL(string: "http://lapi.transitchicago.com/api/1.0/")!

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
        
        let endPoint: String = "\(kAPIBaseURL)\(arrivalsAPIEndPoint)?key=\(kAPIKey)&mapid=\(station["MAP_ID"])"
    
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
}
