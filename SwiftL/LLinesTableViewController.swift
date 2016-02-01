//
//  LLinesTableViewController.swift
//  SwiftL
//
//  Created by Jake Robinson-Lieberman on 1/21/16.
//  Copyright © 2016 JakeRL. All rights reserved.
//

import UIKit
import SwiftyJSON

class LLinesTableViewController: UITableViewController {
    var lines: [Line] = []
    var selectedLine: Line?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "L Lines"
        
        lines = Line.list()
    }

    // MARK: - Table View Data Source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lines.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier.LineList.rawValue, forIndexPath: indexPath)

        cell.textLabel!.text = lines[indexPath.row].title()
        
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedLine = lines[indexPath.row]
        self.performSegueWithIdentifier(SegueIdentifier.SegueToLStationsTableView.rawValue, sender: self)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let segueIdentifier =  SegueIdentifier(rawValue: segue.identifier!){
            
            switch segueIdentifier {
            case .SegueToLStationsTableView:
                if let vc: LStationsTableViewController = segue.destinationViewController as? LStationsTableViewController {
                    vc.line = selectedLine
                }
            default: break
            }
        }
    }
    
}
