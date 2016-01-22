//
//  Constant.swift
//  SwiftL
//
//  Created by Jake Robinson-Lieberman on 1/11/16.
//  Copyright © 2016 JakeRL. All rights reserved.
//

import Foundation

enum CellIdentifier: String {
    case LineList    = "LLineListCell"
    case StationList = "LStationListCell"
    case ArrivalList = "LArrivalListCell"
}

enum SegueIdentifier: String {
    case SegueToLStationsTableView = "SegueToLStationsTableView"
    case SegueToLArrivalsTableView = "SegueToLArrivalsTableView"
}

//enum id <T1, T2> {
//
//}

struct ArrivalsAPI {
    let endpoint = "ttarrivals.aspx"
    let stationId:  Int
    let stopId:     Int
    let maxResults: Int?
    let routeId:    String?
    
    var stationIdParameter = "mapid"
    var stopIdParameter = "stpid"
    var maxResultsParameter = "max"
}

// Arrivals API
let arrivalsAPIEndPoint               = "ttarrivals.aspx"
let numericStationIdentifierParameter = "mapid" // required if stpid not provided
let numericStopIdentifierParameter    = "stpid" // required if mapid not provided
let maximumResultsParameter           = "max"   // optional
let routeCodeParameter                = "rt"    // optional

let followAPIEndPoint       = "ttfollow.aspx"
let trainRunNumberParameter = "runnumber"       // required

let locationsAPIEndPoint = "ttpositions.aspx"
let trainRoutesParameter = "rt"                 // required

enum Line {
    case Red, Blue, Brown, Green, Orange, Purple, PurpleExpress, Pink, Yellow
    
    static func list () -> [Line] {
        return [Line.Blue, Line.Brown, Line.Green, Line.Orange, Line.Red, Line.Pink, Line.Purple, Line.Yellow]
    }
    
    func title () -> String {
        switch self {
        case .Red:           return "Red"
        case .Blue:          return "Blue"
        case .Brown:         return "Brown"
        case .Green:         return "Green"
        case .Orange:        return "Orange"
        case .Purple:        return "Purple"
        case .PurpleExpress: return "Purple Express"
        case .Pink:          return "Pink"
        case .Yellow:        return "Yellow"
        }
    }
    
    func routeId () -> String {
        switch self {
        case .Red:           return "Red"
        case .Blue:          return "Blue"
        case .Brown:         return "Brn"
        case .Green:         return "G"
        case .Orange:        return "O"
        case .Purple:        return "P"
        case .PurpleExpress: return "Pexp"
        case .Pink:          return "Pnk"
        case .Yellow:        return "Y"
        }
    }
    
    func bounds (boundId: Int) -> String {
        if boundId != 5 && boundId != 1 { return "" }
        switch self {
        case .Red:           return boundId == 1 ? "Howard" : "95th/Dan-Ryan"
        case .Blue:          return boundId == 1 ? "O’Hare" : "Forest Park"
        case .Brown:         return boundId == 1 ? "Kimball" : "Loop"
        case .Green:         return boundId == 1 ? "Harlem/Lake" : "Ashland/63rd or Cottage Grove"
        case .Orange:        return boundId == 1 ? "Loop" : "Midway"
        case .Purple:        return boundId == 1 ? "Linden" : "Howard or Loop"
        case .PurpleExpress: return boundId == 1 ? "Linden" : "Howard or Loop"
        case .Pink:          return boundId == 1 ? "Loop" : "54th/Cermak"
        case .Yellow:        return boundId == 1 ? "Skokie" : "Howard"
        }
    }
}