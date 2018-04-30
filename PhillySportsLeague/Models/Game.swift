//
//  Game.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 4/29/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//
import Foundation

public class Game {
    
    //MARK: Properties
    init() {
        date = ""
        time = ""
        team1URL = ""
        team2URL = ""
        team1Name = ""
        team2Name = ""
        team1Score = 0
        team2Score = 0
        location = GameLocation()
    }
    var date: String
    var time: String
    var team1Name: String
    var team1URL: String
    var team1Score: Int
    var team2Name: String
    var team2URL: String
    var team2Score: Int
    var location: GameLocation

}

