//
//  LArrivalsTableViewController.swift
//  SwiftL
//
//  Created by Jake Robinson-Lieberman on 1/21/16.
//  Copyright © 2016 JakeRL. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SWXMLHash

class LArrivalsTableViewController: UITableViewController {
    var station: JSON?
    var arrivals: [Arrival] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = station!["STATION_NAME"].stringValue
        
        APIManager.sharedManager.getArrivalsForStation(station!){ arrivals, error in
            self.arrivals = arrivals
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table View Data Source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrivals.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier.ArrivalList.rawValue, forIndexPath: indexPath)
        
        let unformattedArrivalString = arrivals[indexPath.row].arrT
        let destinationString        = arrivals[indexPath.row].destNm
        
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "yyyyMMdd HH:mm:ss"
        let time = timeFormatter.dateFromString(unformattedArrivalString)
        timeFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
        let formattedArrivalString = timeFormatter.stringFromDate(time!)
        
        cell.textLabel!.text = "Towards \(destinationString): \(formattedArrivalString)"
        
        return cell
    }
}
