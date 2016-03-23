//
//  Conditions.swift
//  WeatherUndergroundTest
//
//  This Model Object maps to the "Conditions" data set on the Weather Underground site.
//  Note that not all data items from the "Conditions" data set are mapped into this
//  object, only those that we will used by the appliation. If a data item is missing from
//  the JSON Data a suitable warning text is inserted.
//
//  The configureFromJSONData function does the mapping here so that the mapping is closely
//  bound to the model object.
//
//  Created by Andrew Duff on 3/22/16.
//  Copyright © 2016 Andrew Duff. All rights reserved.
//

import UIKit

class Conditions: NSObject
{
    var observationTimeText: String?
    var weatherText: String?
    var temperatureText: String?
    var relativeHumidityText: String?
    var windText: String?
    var visibilityMilesText: String?
    var precipitationTodayText: String?
    
    func configureFromJSONData( JSONData: NSData ) -> Bool
    {
        var json: Payload!
        do
        {
            json = try NSJSONSerialization.JSONObjectWithData(JSONData, options: NSJSONReadingOptions()) as? Payload
            
            let current_observation = json["current_observation"] as? Payload
            
            if( current_observation != nil )
            {
                if let observation_time = current_observation!["observation_time"] as? String
                {
                    observationTimeText = observation_time
                }
                else { observationTimeText = "Last Updated ??" }
                
                if let weather = current_observation!["weather"] as? String
                {
                    weatherText = weather
                }
                else { weatherText = "Conditions ??" }
                
                if let temperature_string = current_observation!["temperature_string"] as? String
                {
                    temperatureText = temperature_string
                }
                else { temperatureText = "Last Updated ??" }
                
                if let relative_humidity = current_observation!["relative_humidity"] as? String
                {
                    relativeHumidityText = relative_humidity
                }
                else { relativeHumidityText = "??" }
                
                if let wind_string = current_observation!["wind_string"] as? String
                {
                    windText = "Wind \(wind_string)"
                }
                else { windText = "Wind ??" }
                
                if let visibility_mi = current_observation!["visibility_mi"] as? String
                {
                    visibilityMilesText = visibility_mi
                }
                else { visibilityMilesText = "??" }
                
                if let precip_today_string = current_observation!["precip_today_string"] as? String
                {
                    precipitationTodayText = precip_today_string
                }
                else { precipitationTodayText = "??" }
            }
        }
        catch
        {
            return false
        }
        
        
        return true
    }
}
