//
//  City.swift
//  WeatherUndergroundTest
//
//  In this application, a city has only two attributes, both immutable.
//  The city name and state are extracted from this object and used
//  to construct the API calls to the Weather Underground site.
//
//  Created by Andrew Duff on 3/22/16.
//  Copyright © 2016 Andrew Duff. All rights reserved.
//

import UIKit

class City: NSObject
{
    let name: String!
    let state: String!
    
    init( name: String, state: String )
    {
        self.name = name
        self.state = state
    }
}
