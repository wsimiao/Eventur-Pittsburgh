//
//  ListViewController.swift
//  Eventur Pittsburgh
//
//  Created by Simiao on 4/14/16.
//  Copyright © 2016 Yu. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate {
    
    
    @IBOutlet weak var listTable: UITableView!
    
    // xml parser
    var myParser: NSXMLParser = NSXMLParser()
    
    // rss records
    var rssRecordList : [RssRecord] = [RssRecord]()
    var rssRecord : RssRecord?
    var isTagFound = ["item": false, "title": false, "s_time": false, "link": false, "type": false, "venue": false, "venue_addr":false, "lon": false, "lat": false, "area": false, "org": false, "description": false, "img_link": false, "guid": false]
    
    var receivedChooseWhen = Set<String>()
    var receivedChooseWhere = Set<String>()
    var receivedChooseWhat = Set<String>()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "viewTableCell", bundle: nil)
        listTable.registerNib(nib, forCellReuseIdentifier: "rssCell")
        
        //print("receivedChooseWhen")
        //print(receivedChooseWhen)
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        
        // load Rss data and parse
        if self.rssRecordList.isEmpty {
            self.loadRSSData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: - Table view dataSource and Delegate
    
    // return number of section within a table
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // return row height
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    // return how may records in a table
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rssRecordList.count
    }
    
    // return cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // collect reusable cell
        let cell: TableCell = tableView.dequeueReusableCellWithIdentifier("rssCell", forIndexPath: indexPath) as! TableCell
        
        // find record for current cell
        let thisRecord : RssRecord  = self.rssRecordList[indexPath.row]
        
        // set value for main title and detail tect
        //cell.detailTextLabel?.text = thisRecord.s_time
        cell.subtitleCustomCell.text = "\(thisRecord.s_time)  \(thisRecord.area)"
        cell.titleCustomCell.text = thisRecord.title
        cell.titleCustomCell.font = UIFont.systemFontOfSize(14.0)
        cell.titleCustomCell.numberOfLines = 3
        
        // add full border
        cell.layer.masksToBounds = true
        cell.layer.borderColor = UIColor(red:139/255, green:123/255, blue:139/255, alpha: 1.0).CGColor
        cell.layer.borderWidth = 1.0
        
        //print(thisRecord.img_link)
        //let projectURL = thisRecord.img_link
        //let imgURL: NSURL? = NSURL(string: projectURL + "/cover_image?style=200x200#")
        
        if let imgURL = NSURL(string: thisRecord.img_link){
        cell.imageCustomCell.contentMode = UIViewContentMode.ScaleAspectFit
        //cell.imageCustomCell.setImageWithURL(imgURL, placeholderImage: UIImage(named: "logo.png"))
        cell.imageCustomCell.setImageWithURL(imgURL, placeholderImage: UIImage(named: "logo.png"))
        }
        
        // return cell
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("segueShowDetails", sender: self)
    }
 
    
    
    
    // MARK: - NSXML Parse delegate function
    
    // start parsing document
    func parserDidStartDocument(parser: NSXMLParser) {
        // start parsing
    }
    
    // element start detected
    // scaning line by line like python
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        if elementName == "item" {
            self.isTagFound["item"] = true
            self.rssRecord = RssRecord()
        }else if elementName == "title" {
            self.isTagFound["title"] = true
        }else if elementName == "link" {
            self.isTagFound["link"] = true
        }else if elementName == "ens1:s_time" {
            self.isTagFound["s_time"] = true
        }else if elementName == "ens1:type" {
            self.isTagFound["type"] = true
        }else if elementName == "ens1:venue" {
            self.isTagFound["venue"] = true
        }else if elementName == "ens1:venue_addr" {
            self.isTagFound["venue_addr"] = true
        }else if elementName == "lon" {
            self.isTagFound["lon"] = true
        }else if elementName == "lat" {
            self.isTagFound["lat"] = true
        }else if elementName == "area" {
            self.isTagFound["area"] = true
        }else if elementName == "ens1:org" {
            self.isTagFound["org"] = true
        }else if elementName == "description" {
            self.isTagFound["description"] = true
        }else if elementName == "ens1:img_link" {
            self.isTagFound["img_link"] = true
        }else if elementName == "guid" {
            self.isTagFound["guid"] = true
        }
        
    }
    
    var fitWhen = false
    var fitWhere = false
    var fitWhat = false
    
    // characters received for some element
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        if isTagFound["title"] == true {
            self.rssRecord?.title += string
        }else if isTagFound["link"] == true {
            self.rssRecord?.link += string
        }else if isTagFound["s_time"] == true {
            
            if string.containsString("-"){
                self.rssRecord?.s_time += string
                
                if string.containsString("M") {
                    self.rssRecord?.dateFromStr = string.componentsSeparatedByString(" ")[0]
                    self.rssRecord?.dateToStr = string.componentsSeparatedByString(" ")[0]
                    
                } else {
                    self.rssRecord?.dateFromStr = string.componentsSeparatedByString(" ")[0]
                    self.rssRecord?.dateToStr = string.componentsSeparatedByString(" ")[2]
                    //print(dateArray)
                }
                print(self.rssRecord?.dateFromStr)
                print(self.rssRecord?.dateToStr)
                
                let dateNow = NSDate()
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "MM-dd-yyyy"
                let dateFrom = dateFormatter.dateFromString((rssRecord?.dateFromStr)!)
                let dateTo = dateFormatter.dateFromString((rssRecord?.dateToStr)!)
                
                
                
                if receivedChooseWhen.contains("all") {
                    fitWhen = true
                } else if receivedChooseWhen.contains("Month"){
                    let dateOneMonth = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Month, value: 1, toDate: dateNow, options: NSCalendarOptions.init(rawValue: 0))
                    if dateFrom!.isEqualToDate(dateTo!) {
                        if dateNow.earlierDate(dateFrom!) == dateNow && dateFrom!.earlierDate(dateOneMonth!) == dateFrom {
                            fitWhen = true
                        } else {
                            fitWhen = false
                        }
                    } else {
                        if dateTo!.earlierDate(dateNow) == dateTo || dateOneMonth!.earlierDate(dateFrom!) == dateOneMonth {
                            fitWhen = false
                        } else {
                            fitWhen = true
                        }
                    }
                    
                } else if receivedChooseWhen.contains("Week") {
                    let dateWeek = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Day, value: 7, toDate: dateNow, options: NSCalendarOptions.init(rawValue: 0))
                    if dateFrom!.isEqualToDate(dateTo!) {
                        if dateNow.earlierDate(dateFrom!) == dateNow && dateFrom!.earlierDate(dateWeek!) == dateFrom {
                            fitWhen = true
                        } else {
                            fitWhen = false
                        }
                    } else {
                        if dateTo!.earlierDate(dateNow) == dateTo || dateWeek!.earlierDate(dateFrom!) == dateWeek {
                            fitWhen = false
                        } else {
                            fitWhen = true
                        }
                    }
                    
                } else if receivedChooseWhen.contains("Tomorrow") {
                    let dateTom = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Day, value: 1, toDate: dateNow, options: NSCalendarOptions.init(rawValue: 0))
                    var inTomorrow = false
                    var inToday = false
                    func isDateInTomorrow(data: NSDate) -> Bool {
                        inTomorrow = isDateInTomorrow(dateFrom!)
                        return inTomorrow
                    }
                    func isDateInToday(data: NSDate) -> Bool {
                        inToday = isDateInToday(dateFrom!)
                        return inToday
                    }
                    
                    if dateFrom!.isEqualToDate(dateTo!) {
                        
                        fitWhen = inTomorrow && inToday
                    } else {
                        if dateFrom!.earlierDate(dateNow) == dateFrom && dateTom!.earlierDate(dateTo!) == dateTom {
                            fitWhen = true
                        } else {
                            fitWhen = false
                        }
                    }
                    
                    
                } else if receivedChooseWhen.contains("Today"){
                    var inToday = false
                    func isDateInToday(date : NSDate)  -> Bool {
                        inToday = isDateInToday(dateFrom!)
                        return inToday
                    }
                    
                    if dateFrom!.isEqualToDate(dateTo!) {
                        
                        fitWhen = inToday
                        
                    } else {
                        if dateFrom!.earlierDate(dateNow) == dateFrom && dateNow.earlierDate(dateTo!) == dateNow {
                            fitWhen = true
                        } else {
                            fitWhen = false
                        }
                    }
                }
            }
        }else if isTagFound["type"] == true {
            self.rssRecord?.type += string
            
            if receivedChooseWhat.contains("all"){
                fitWhat = true
            } else if receivedChooseWhat.contains(string){
                fitWhat = true
            } else {
                fitWhat = false
            }
            
        }else if isTagFound["venue"] == true {
            self.rssRecord?.venue += string
        }else if isTagFound["venue_addr"] == true {
            self.rssRecord?.venue_addr += string
        }else if isTagFound["lon"] == true {
            self.rssRecord?.lon += Double(string)!
        }else if isTagFound["lat"] == true {
            self.rssRecord?.lat += Double(string)!
        }else if isTagFound["area"] == true {
            self.rssRecord?.area += string
            
            if receivedChooseWhere.contains("all"){
                fitWhere = true
            } else if receivedChooseWhere.contains(string){
                fitWhere = true
            } else {
                fitWhere = false
            }

        }else if isTagFound["org"] == true {
            self.rssRecord?.org += string
        }else if isTagFound["description"] == true {
            self.rssRecord?.description += string
        }else if isTagFound["img_link"] == true {
            
            let tes:String = string
            var subtes = String()
            var safeSubtes = String()
            if tes.containsString("http://eventur.sis.pitt.edu/images/http"){
                let index1 = tes.startIndex.advancedBy(35)
                subtes = tes.substringFromIndex(index1)
                safeSubtes = subtes.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            } else {
                subtes = string
                safeSubtes = subtes.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            }
            self.rssRecord?.img_link += safeSubtes
            
        }else if isTagFound["guid"] == true {
            self.rssRecord?.guid += string
        }
        
        // check if a record satisfies the filtering conditions
        if fitWhat && fitWhere && fitWhen{
            isTagFound["item"] = true
        } else {
            isTagFound["item"] = false
        }
        
    }
    
    // element end detected
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item" && isTagFound["item"] == true {
            self.isTagFound["item"] = false
            self.rssRecordList.append(self.rssRecord!)
        }else if elementName == "title" {
            self.isTagFound["title"] = false
        }else if elementName == "link" {
            self.isTagFound["link"] = false
        }else if elementName == "ens1:s_time" {
            self.isTagFound["s_time"] = false
        }else if elementName == "ens1:type" {
            self.isTagFound["type"] = false
        }else if elementName == "ens1:venue" {
            self.isTagFound["venue"] = false
        }else if elementName == "ens1:venue_addr" {
            self.isTagFound["venue_addr"] = false
        }else if elementName == "lon" {
            self.isTagFound["lon"] = false
        }else if elementName == "lat" {
            self.isTagFound["lat"] = false
        }else if elementName == "area" {
            self.isTagFound["area"] = false
        }else if elementName == "ens1:org" {
            self.isTagFound["org"] = false
        }else if elementName == "description" {
            self.isTagFound["description"] = false
        }else if elementName == "ens1:img_link" {
            self.isTagFound["img_link"] = false
        }else if elementName == "guid" {
            self.isTagFound["guid"] = false
        }
    }
    
    // end parsing document
    func parserDidEndDocument(parser: NSXMLParser) {
        
        //reload table view
        self.listTable.reloadData()
        
    }
    
    // if any error detected while parsing.
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        
        // show error message
        self.showAlertMessage(alertTitle: "Error", alertMessage: "Error while parsing xml.")
    }
    
    
    
    
    // MARK: - Utility functions
    
    // load rss and parse it
    private func loadRSSData(){
        
        if let rssURL = NSURL(string: RSS_FEED_URL) {
            
            // fetch rss content from url
            self.myParser = NSXMLParser(contentsOfURL: rssURL)!
            
            // set parser delegate
            self.myParser.delegate = self
            self.myParser.shouldResolveExternalEntities = false
            
            // start parsing
            self.myParser.parse()
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
    
    

    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "segueShowDetails" {
            
            // find index path for selected row
            let selectedIndexPath : [NSIndexPath] = self.listTable.indexPathsForSelectedRows!
            
            // deselect the selected row
            self.listTable.deselectRowAtIndexPath(selectedIndexPath[0], animated: true)
            
            // create destination view controller
            let destVc = segue.destinationViewController as! DetailsViewController
            
            // set title for next screen
            destVc.navigationItem.title = self.rssRecordList[selectedIndexPath[0].row].title
            
            // set link value for destination view controller
            destVc.link = self.rssRecordList[selectedIndexPath[0].row].link
            
        }
        
    }



}
