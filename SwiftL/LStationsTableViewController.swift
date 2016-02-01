//
//  LineDetailViewController.swift
//  SwiftL
//
//  Created by Jake Robinson-Lieberman on 1/21/16.
//  Copyright © 2016 JakeRL. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SWXMLHash

class LStationsTableViewController: UITableViewController {
    var line: Line?
    var lineStops: [JSON] = []
    var selectedStop: JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "\(line!.title()) Line Stations"
        
        // cut down the back button in the next view controller to the name of the line for less overflow in the navigation bar
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: line!.title(), style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        APIManager.sharedManager.getStationsForLine(line!) { stations, error in
            self.lineStops = stations
            self.tableView.reloadData()
        }
    }

    // MARK: - Table View Data Source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lineStops.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier.StationList.rawValue, forIndexPath: indexPath)
        
        cell.textLabel!.text = lineStops[indexPath.row]["STATION_NAME"].stringValue
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedStop = lineStops[indexPath.row]
        performSegueWithIdentifier(SegueIdentifier.SegueToLArrivalsTableView.rawValue, sender: self)
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let segueIdentifier =  SegueIdentifier(rawValue: segue.identifier!){
            
            switch segueIdentifier {
            case .SegueToLArrivalsTableView:
                if let vc: LArrivalsTableViewController = segue.destinationViewController as? LArrivalsTableViewController {
                    vc.station = selectedStop
                }
            default: break
            }
        }
    }
}
