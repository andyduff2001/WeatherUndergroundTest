//
//  CitySelectionTVC.swift
//  WeatherUndergroundTest
//
//  This TVC simply displays the list of cities for which weather information can
//  be queried from the Weather Underground Site.
//
//  When the user selects a city, the controller segues to the CityConditionsTVC
//  to perform the actual query and to display the data.
//
//  Created by Andrew Duff on 3/22/16.
//  Copyright © 2016 Andrew Duff. All rights reserved.
//

import UIKit

class CitySelectionTVC: UITableViewController
{
    let cities: [City] =
    [
        City(name:"Cincinnati", state: "OH"),
        City(name:"Columbus", state: "OH"),
        City(name:"Cleveland", state: "OH"),
    ]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.title = "Weather Underground"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return cities.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("CityNameCell", forIndexPath: indexPath)
        let city = cities[ indexPath.row ]
        
        cell.textLabel!.text = "\(city.name), \(city.state)"
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "SegueToCityConditionsTVC"
        {
            let tvc: CityConditionsTVC = segue.destinationViewController as! CityConditionsTVC
            let indexPath = self.tableView.indexPathForSelectedRow
            
            tvc.city = cities[ indexPath!.row ]
        }
    }

}
