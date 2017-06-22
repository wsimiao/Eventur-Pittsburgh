//
//  ViewController.swift
//  Eventur Pittsburgh
//
//  Created by Simiao on 4/14/16.
//  Copyright © 2016 Yu. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, NSXMLParserDelegate {
    
    
    // xml parser
    var myParserMap: NSXMLParser = NSXMLParser()
    
    // rss records
    var rssRecordListMap : [RssRecordMap] = [RssRecordMap]()
    var rssRecordMap : RssRecordMap?
    var isTagFoundMap = ["item": false, "title": false, "s_time": false, "link": false, "type": false, "venue": false, "venue_addr":false, "lon": false, "lat": false, "area": false, "org": false, "description": false, "img_link": false, "guid": false]
    
    var latitudeArray: [CLLocationDegrees] = [40.444491, 40.444169]
    var longitudeArray: [CLLocationDegrees] = [-79.960500, -79.944686]
    
    
    @IBOutlet weak var map: MKMapView!
    
    @IBAction func goToFilterPageButton(sender: AnyObject) {
        self.performSegueWithIdentifier("goToFilterPageSegue", sender: self)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
                var latitude:CLLocationDegrees = 40.4405556
        
                var longitude: CLLocationDegrees = -79.9961111
        
                var latDelta:CLLocationDegrees = 0.1
        
                var logDelta:CLLocationDegrees = 0.1
        
                var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, logDelta)
        
                var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
                var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
                map.setRegion(region, animated: true)
        
                var annotation = MKPointAnnotation()
        
                annotation.coordinate = location
        
                annotation.title = "Pittsburgh"
        
                annotation.subtitle = "I'm living here"
        
                map.addAnnotation(annotation)
        
        
        for index in 0...1 {
            var newLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitudeArray[index], longitudeArray[index])
            
            var newRegion:MKCoordinateRegion = MKCoordinateRegionMake(newLocation, span)
            
            map.setRegion(newRegion, animated: true)
            
            var annotation1 = MKPointAnnotation()
            
            annotation1.coordinate = newLocation
            
            annotation1.title = "Pittsburgh"
            
            annotation1.subtitle = "I'm living here"
            
            map.addAnnotation(annotation1)
        }
        
    } // end of ViewDidLoad
    
    override func viewDidAppear(animated: Bool) {
        
        // load Rss data and parse
        if self.rssRecordListMap.isEmpty {
            self.loadRSSData()
        }
    } // end of viewDidAppear
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    } // end of didReceiveMemoryWarning
    
    //Start Parse
    func parserDidStartDocument(parser: NSXMLParser) {
        // start parsing
    }
    
    // element start detected
    //第一个代理方法： 开始处理xml数据，它会把整个xml遍历一遍， 识别元素节点名称
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        if elementName == "item" {
            self.isTagFoundMap["item"] = true
            self.rssRecordMap = RssRecordMap()
            //print("the first delegate, item \(isTagFound["item"])")
            
        }else if elementName == "title" {
            self.isTagFoundMap["title"] = true
            //print("the first delegate, title \(isTagFound["title"])")
            
        }else if elementName == "link" {
            self.isTagFoundMap["link"] = true
            //print("the first delegate, link \(isTagFound["link"])")
            
        }else if elementName == "ens1:type" {
            self.isTagFoundMap["type"] = true
            
        }else if elementName == "ens1:s_time" {
            self.isTagFoundMap["s_time"] = true
            
        }else if elementName == "ens1:venue" {
            self.isTagFoundMap["venue"] = true
            
        }else if elementName == "ens1:venue_addr" {
            self.isTagFoundMap["venue_addr"] = true
            
        }else if elementName == "lon" {
            self.isTagFoundMap["lon"] = true
            
        }else if elementName == "lat" {
            self.isTagFoundMap["lat"] = true
            
        }else if elementName == "area" {
            self.isTagFoundMap["area"] = true
            
        }else if elementName == "ens1:org" {
            self.isTagFoundMap["org"] = true
            
        }else if elementName == "ens1:img_link" {
            self.isTagFoundMap["img_link"] = true
            
        }else if elementName == "guid" {
            self.isTagFoundMap["guid"] = true
            
        }
        
    }
    
    
    // characters received for some element
    // 第二个代理方法： 得到文本节点里储存的信息数据
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        if isTagFoundMap["title"] == true {
            self.rssRecordMap?.title += string
            print("the second delegate, rssRecord.title\(rssRecordMap?.title)")
            
        }else if isTagFoundMap["link"] == true {
            self.rssRecordMap?.link += string
            
        }else if isTagFoundMap["type"] == true {
            self.rssRecordMap?.type += string
            
        }else if isTagFoundMap["s_time"] == true {
            
            if string.containsString("-") {
                self.rssRecordMap?.s_time += string
                print(string)
            }
            
        }else if isTagFoundMap["venue"] == true {
            self.rssRecordMap?.venue += string
            
        }else if isTagFoundMap["venue_addr"] == true {
            self.rssRecordMap?.venue_addr += string
            
        }else if isTagFoundMap["lon"] == true {
            self.rssRecordMap?.lon += Double(string)!
            
        }else if isTagFoundMap["lat"] == true {
            self.rssRecordMap?.lat += Double(string)!
            
        }else if isTagFoundMap["area"] == true {
            self.rssRecordMap?.area += string
            
        }else if isTagFoundMap["org"] == true {
            self.rssRecordMap?.org += string
            
        }else if isTagFoundMap["img_link"] == true {
            //self.rssRecord?.img_link += string
            let tes:String = string
            var subtes = String()
            var safeSubtes = String()
            if tes.containsString("http://eventur.sis.pitt.edu/images/http") {
                let index1 = tes.startIndex.advancedBy(35)
                subtes = tes.substringFromIndex(index1)
                safeSubtes = subtes.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            } else {
                subtes = string
                safeSubtes = subtes.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            }
            
            //print (subtes)
            self.rssRecordMap?.img_link += safeSubtes
            //print(self.rssRecord?.img_link)
            
        }else if isTagFoundMap["guid"] == true {
            self.rssRecordMap?.guid += string
        }
        
    }
    
    // element end detected
    // 第三个代理方法： 储存从第二个代理方法中获取的信息
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //my change on the filter
        if elementName == "item"{
            self.isTagFoundMap["item"] = false
            self.rssRecordListMap.append(self.rssRecordMap!)
            //print("the third delegate, rssRecordList \(rssRecordList)")
            
        }else if elementName == "title" {
            self.isTagFoundMap["title"] = false
            //print("the first delegate, title \(isTagFound["title"])")
            
        }else if elementName == "link" {
            self.isTagFoundMap["link"] = false
            //print("the first delegate, link \(isTagFound["link"])")
            
        }else if elementName == "ens1:type" {
            self.isTagFoundMap["type"] = false
            
        }else if elementName == "ens1:s_time" {
            self.isTagFoundMap["s_time"] = false
            
        }else if elementName == "ens1:venue" {
            self.isTagFoundMap["venue"] = false
            
        }else if elementName == "ens1:venue_addr" {
            self.isTagFoundMap["venue_addr"] = false
            
        }else if elementName == "lon" {
            self.isTagFoundMap["lon"] = false
            
        }else if elementName == "lat" {
            self.isTagFoundMap["lat"] = false
            
        }else if elementName == "area" {
            self.isTagFoundMap["area"] = false
            
        }else if elementName == "ens1:org" {
            self.isTagFoundMap["org"] = false
            
        }else if elementName == "ens1:img_link" {
            self.isTagFoundMap["img_link"] = false
            
        }else if elementName == "guid" {
            self.isTagFoundMap["guid"] = false
        }
        
    }
    
    // end parsing document
    func parserDidEndDocument(parser: NSXMLParser) {
        
        //reload table view
        //self.myListView.reloadData()
        
        // stop spinner
        //self.spinner.stopAnimating()
    }
    
    // if any error detected while parsing.
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        
        //  stop animation
        //self.spinner.stopAnimating()
        
        // show error message
        self.showAlertMessage(alertTitle: "Error", alertMessage: "Error while parsing xml.")
    }
    
    
    
    
    // MARK: - Utility functions
    
    // load rss and parse it
    private func loadRSSData(){
        
        if let rssURL1 = NSURL(string: RSS_FEED_URL) {
            
            // start spinner
            //self.spinner.startAnimating()
            
            // fetch rss content from url
            self.myParserMap = NSXMLParser(contentsOfURL: rssURL1)!
            
            // set parser delegate
            self.myParserMap.delegate = self
            self.myParserMap.shouldResolveExternalEntities = false
            
            // start parsing
            self.myParserMap.parse()
        }
        
    }
    
    // show alert with ok button
    private func showAlertMessage(alertTitle alertTitle: String, alertMessage: String ) -> Void {
        
        // create alert controller
        let alertCtrl = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert) as UIAlertController
        
        // create action
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:
            { (action: UIAlertAction) -> Void in
                // you can add code here if needed
        })
        
        // add ok action
        alertCtrl.addAction(okAction)
        
        // present alert
        self.presentViewController(alertCtrl, animated: true, completion: { (void) -> Void in
            // you can add code here if needed
        })
    }
    
    
}

