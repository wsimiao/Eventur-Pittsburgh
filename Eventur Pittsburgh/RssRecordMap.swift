//
//  RssRecordMap.swift
//  Eventur Pittsburgh
//
//  Created by Simiao Wang on 4/21/16.
//  Copyright © 2016 Yu. All rights reserved.
//

import Foundation

class RssRecordMap {
    
    var title: String
    var link: String
    var type: String
    var s_time: String
    var dateFromStr: String
    var dateToStr: String
    var venue: String
    var venue_addr: String
    var lon: Double
    var lat: Double
    var area: String
    var fflag: Bool
    var tflag: Bool
    var org: String
    var description: String
    var img_link: String
    var guid: String
    
    init(){
        self.title = ""
        self.link = ""
        self.type = ""
        self.s_time = ""
        self.dateFromStr = ""
        self.dateToStr = ""
        self.venue = ""
        self.venue_addr = ""
        self.lon = 0.0
        self.lat = 0.0
        self.area = ""
        self.fflag = false
        self.tflag = false
        self.org = ""
        self.description = ""
        self.img_link = ""
        self.guid = ""
    }
    
}