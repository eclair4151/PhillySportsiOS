//
//  League.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 4/24/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//

import Foundation

public class League: JsonResponse {
    
    //MARK: Properties
    override init() {
        soldOut = false
        season = ""
        starts = ""
        registrationDates = ""
        location = GameLocation()
        teamPrice = ""
        freeAgentPrice = ""
        dayOfWeek = ""
        timeOfWeek = ""
        scheduleUrl = ""
        standingsUrl = ""
        leagueID = ""
        super.init()
    }
    
    var soldOut: Bool
    var season: String
    var starts: String
    var registrationDates: String
    var location: GameLocation
    var teamPrice: String
    var freeAgentPrice: String
    var dayOfWeek: String
    var timeOfWeek: String
    var scheduleUrl: String
    var standingsUrl: String
    var leagueID: String
}
