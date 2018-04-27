//
//  DashboardRow.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 4/18/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//

import Foundation

public class DashboardRow {
    
    //MARK: Properties
    init(leagueName: String, leagueUrl: String, teamName: String, teamUrl: String, startDate:String) {
        self.leagueName = leagueName
        self.leagueUrl = leagueUrl
        self.teamName = teamName
        self.teamUrl = teamUrl
        self.startDate = startDate
        self.logoUrl = "https://svite-league-apps-img.s3.amazonaws.com/program-" + String(teamUrl.split(separator: "/")[3]) + "-s3.jpg"
    }
    
    var logoUrl: String
    var leagueName: String
    var leagueUrl: String
    var teamName: String
    var teamUrl: String
    var startDate: String
}

