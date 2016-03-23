//
//  CityConditionsTVC.swift
//  WeatherUndergroundTest
//
//  This TVC uses NSURLSession to go to the Weather Underground site with the
//  request for the current conditions for the City passed to it as its data source.
//
//  Created by Andrew Duff on 3/22/16.
//  Copyright © 2016 Andrew Duff. All rights reserved.
//

import UIKit

class CityConditionsTVC: UITableViewController
{
    // Data Source
    //
    var city: City?
    
    // Local Variables
    //
    var conditions = Conditions()
    var sessionTask: NSURLSessionTask?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.title = city?.name
        // self.tableView.rowHeight = UITableViewAutomaticDimension
        
        // First hard code URL string together for the city request
        //
        let apiKey = "07fb3087f4cbb210"
        let urlString = "http://api.wunderground.com/api/\(apiKey)/conditions/q/\(city!.state)/\(city!.name).json"
        let url = NSURL(string: urlString)
        let request = NSURLRequest( URL: url!)
        let session = NSURLSession.sharedSession()
        
        sessionTask = session.dataTaskWithRequest( request, completionHandler:
            {
                (inputData, response, error) -> Void in
                
                if error != nil
                {
                    print("Error: \(error?.localizedDescription): \(error!.userInfo)")
                }
                else if inputData != nil
                {
                    self.conditions.configureFromJSONData( inputData! )
                    
                    dispatch_async(dispatch_get_main_queue())
                    {
                        self.tableView.reloadData()
                    }
                }
                else
                {
                    print("Error: Input data is nil.")
                }
            })
        
        sessionTask!.resume()

    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear( animated )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch section
        {
            case 1, 2: return 3
            default: return 1
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell: UITableViewCell?
        
        if indexPath.section == 0
        {
            cell = tableView.dequeueReusableCellWithIdentifier("TextCell", forIndexPath: indexPath)
            if let textView: UITextView = cell?.viewWithTag( 77 ) as? UITextView
            {
                textView.text = conditions.observationTimeText
            }
        }
        else if indexPath.section == 1
        {
            cell = tableView.dequeueReusableCellWithIdentifier("TextCell", forIndexPath: indexPath)
            if let textView: UITextView = cell?.viewWithTag( 77 ) as? UITextView
            {
                if indexPath.row == 0 { textView.text = conditions.weatherText }
                else if indexPath.row == 1 { textView.text = conditions.temperatureText }
                else { textView.text = conditions.windText }
            }
        }
        else   // section == 2
        {
            cell = tableView.dequeueReusableCellWithIdentifier("LabelCell", forIndexPath: indexPath)
            
            if indexPath.row == 0
            {
                cell!.textLabel!.text = "Relative Humidity"
                cell!.detailTextLabel!.text = conditions.relativeHumidityText
            }
            else if indexPath.row == 1
            {
                cell!.textLabel!.text = "Visibility"
                cell!.detailTextLabel!.text = conditions.visibilityMilesText
            }
            else
            {
                cell!.textLabel!.text = "Precip Today"
                cell!.detailTextLabel!.text = conditions.precipitationTodayText
            }
        }
    
        cell?.userInteractionEnabled = false
        cell?.accessoryType = .None
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if indexPath.section == 2 { return 36.0 }
        else { return 66.0 }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if section == 1
        {
            return "CURRENT CONDITIONS"
        }
        else
        {
            return nil
        }
    }

}
