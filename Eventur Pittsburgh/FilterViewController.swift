//
//  FilterViewController.swift
//  Eventur Pittsburgh
//
//  Created by Simiao on 4/14/16.
//  Copyright © 2016 Yu. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    @IBOutlet weak var filterTable: UITableView!
    
    var whenList:[String] = ["Today", "Tomorrow", "Week", "Month"]
    var whereList:[String] = ["Downtown", "Oakland", "Squirrel Hill", "Other Areas"]
    var whatList:[String] = ["Dance", "Exhibition", "Festival", "Film/Video Art", "Music Concert", "Opera/Musical", "Play", "Tour", "Other"]
    
    var checked0 = [Bool](count: 4, repeatedValue: false)
    var checked1 = [Bool](count: 4, repeatedValue: false)
    var checked2 = [Bool](count: 9, repeatedValue: false) // Have an array equal to the number of cells in your table
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        var returnValue = 0
        
        switch(segmentedControl.selectedSegmentIndex){
        case 0:
            returnValue = whenList.count
            break
            
        case 1:
            returnValue = whereList.count
            break
            
        case 2:
            returnValue = whatList.count
            break
            
        default:
            break
            
        }
        
        return returnValue
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)  -> UITableViewCell {
        
        let filterCell = tableView.dequeueReusableCellWithIdentifier("filterCell", forIndexPath: indexPath)
        
        switch(segmentedControl.selectedSegmentIndex){
        case 0:
            filterCell.textLabel?.text = whenList[indexPath.row]
            if !checked0[indexPath.row] {
                filterCell.accessoryType = .None
            } else if checked0[indexPath.row] {
                filterCell.accessoryType = .Checkmark
            }
            break
        
        case 1:
            filterCell.textLabel?.text = whereList[indexPath.row]
            if !checked1[indexPath.row] {
                filterCell.accessoryType = .None
            } else if checked1[indexPath.row] {
                filterCell.accessoryType = .Checkmark
            }
            break
            
        case 2:
            filterCell.textLabel?.text = whatList[indexPath.row]
            if !checked2[indexPath.row] {
                filterCell.accessoryType = .None
            } else if checked2[indexPath.row] {
                filterCell.accessoryType = .Checkmark
            }
            break
            
        default:
            break
        }
        
        //configure you cell here.
        
        return filterCell
    }
    
    // pass the value of selected cell in table to console
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!
        
        currentCell.accessoryType = UITableViewCellAccessoryType.Checkmark
        
        let selectedRow = tableView.indexPathForSelectedRow?.row
        
        switch(segmentedControl.selectedSegmentIndex){
        case 0:
            if checked0[selectedRow!] == true {
                checked0[selectedRow!] = false
                currentCell.accessoryType = .None
            } else {
                checked0[selectedRow!] = true
                currentCell.accessoryType = .Checkmark
            }
            break
        case 1:
            if checked1[selectedRow!] == true {
                checked1[selectedRow!] = false
                currentCell.accessoryType = .None
            } else {
                checked1[selectedRow!] = true
                currentCell.accessoryType = .Checkmark
            }
            break
        case 2:
            if checked2[selectedRow!] == true {
                checked2[selectedRow!] = false
                currentCell.accessoryType = .None
            } else {
                checked2[selectedRow!] = true
                currentCell.accessoryType = .Checkmark
            }
        default:
            break
        }
        
        print("checked0:")
        print(checked0)
        print("checked1:")
        print(checked1)
        print("checked2:")
        print(checked2)
    }
    
    var chooseWhen = Set<String>()
    var chooseWhere = Set<String>()
    var chooseWhat = Set<String>()

    @IBAction func applyButtonTapped(sender: AnyObject) {
        for (index, value) in checked0.enumerate(){
            if value == true {
                switch (index) {
                case 0:
                    chooseWhen.insert("Today")
                    chooseWhen.remove("all")
                    break
                case 1:
                    chooseWhen.insert("Tomorrow")
                    chooseWhen.remove("all")
                    break
                case 2:
                    chooseWhen.insert("Week")
                    chooseWhen.remove("all")
                    break
                case 3:
                    chooseWhen.insert("Month")
                    chooseWhen.remove("all")
                    break
                default:
                    break
                }
            } else {
                switch (index) {
                case 0:
                    chooseWhen.remove("Today")
                    break
                case 1:
                    chooseWhen.remove("Tomorrow")
                    break
                case 2:
                    chooseWhen.remove("Week")
                    break
                case 3:
                    chooseWhen.remove("Month")
                    break
                default:
                    break
                }
                
            }
        } // end of for checked0
        
        if chooseWhen.isEmpty {
            chooseWhen.insert("all")
        } // end of chooseWhen empty
        
        for (index, value) in checked1.enumerate(){
            if value == true {
                switch (index) {
                case 0:
                    chooseWhere.insert("Downtown")
                    chooseWhere.remove("all")
                    break
                case 1:
                    chooseWhere.insert("Oakland")
                    chooseWhere.remove("all")
                    break
                case 2:
                    chooseWhere.insert("Squirrel Hill")
                    chooseWhere.remove("all")
                    break
                case 3:
                    chooseWhere.insert("Other Areas")
                    chooseWhere.remove("all")
                    break
                default:
                    break
                }
            } else {
                switch (index) {
                case 0:
                    chooseWhere.remove("Downtown")
                    break
                case 1:
                    chooseWhere.remove("Oakland")
                    break
                case 2:
                    chooseWhere.remove("Squirrel Hill")
                    break
                case 3:
                    chooseWhere.remove("Other Areas")
                    break
                default:
                    break
                }
                
            }
        } // end of for checked1
        
        if chooseWhere.isEmpty {
            chooseWhere.insert("all")
        } // end of chooseWhere empty
        
        for (index, value) in checked2.enumerate(){
            if value == true {
                switch (index) {
                case 0:
                    chooseWhat.insert("Dance")
                    chooseWhat.remove("all")
                    break
                case 1:
                    chooseWhat.insert("Exhibition")
                    chooseWhat.remove("all")
                    break
                case 2:
                    chooseWhat.insert("Festival")
                    chooseWhat.remove("all")
                    break
                case 3:
                    chooseWhat.insert("Film/Video Art")
                    chooseWhat.remove("all")
                    break
                case 4:
                    chooseWhat.insert("Music Concert")
                    chooseWhat.remove("all")
                    break
                case 5:
                    chooseWhat.insert("Opera/Musical")
                    chooseWhat.remove("all")
                    break
                case 6:
                    chooseWhat.insert("Play")
                    chooseWhat.remove("all")
                    break
                case 7:
                    chooseWhat.insert("Tour")
                    chooseWhat.remove("all")
                    break
                case 8:
                    chooseWhat.insert("Other")
                    chooseWhat.remove("all")
                    break
                default:
                    break
                } // end of switch in if
            } else {
                switch (index) {
                case 0:
                    chooseWhat.remove("Dance")
                    break
                case 1:
                    chooseWhat.remove("Exhibition")
                    break
                case 2:
                    chooseWhat.remove("Festival")
                    break
                case 3:
                    chooseWhat.remove("Film/Video Art")
                    break
                case 4:
                    chooseWhat.remove("Music Concert")
                    break
                case 5:
                    chooseWhat.remove("Opera/Musical")
                    break
                case 6:
                    chooseWhat.remove("Play")
                    break
                case 7:
                    chooseWhat.remove("Tour")
                    break
                case 8:
                    chooseWhat.remove("Other")
                    break
                default:
                    break
                } // end of switch in else
            }
        } // end of for checked2
        
        // if nothing is chosen, return all
        if chooseWhat.isEmpty {
            chooseWhat.insert("all")
        } // end of chooseWhat empty
        
        
        print(chooseWhen)
        print(chooseWhere)
        print(chooseWhat)
        
        // trigger goToFilteredListSegue
        // go to filted page
        self.performSegueWithIdentifier("goToFilteredListSegue", sender:self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let nextViewController = segue.destinationViewController as! ListViewController
        
        nextViewController.receivedChooseWhen = chooseWhen
        nextViewController.receivedChooseWhere = chooseWhere
        nextViewController.receivedChooseWhat = chooseWhat
    }
    
    
    

    
    @IBAction func segmentedControlAction(sender: AnyObject) {
        filterTable.reloadData()
    }
    
}
