//
//  ScheduleGame.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 5/22/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//

import Foundation

public class ScheduleGame : Game {
    
    //MARK: Properties
    override init() {
        self.leagueID = ""
        self.leagueName = ""
        self.leagueImageUrl = ""
        self.gameDate = Date()
        super.init()
    }

    var leagueName: String
    var leagueID: String
    var leagueImageUrl:String
    var gameDate: Date
}
