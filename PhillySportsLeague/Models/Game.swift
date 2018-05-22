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
        team1Score = ""
        team2Score = ""
        tag = ""
        location = GameLocation()
    }
    var date: String
    var time: String
    var team1Name: String
    var team1URL: String
    var team1Score: String
    var team2Name: String
    var team2URL: String
    var team2Score: String
    var location: GameLocation
    var tag: String
    func didTeam1Win() -> Bool {
        if team1Score == "W" {
            return true
        } else if team2Score == "W" {
            return false
        }
        
        if Int(team1Score) != nil && Int(team2Score) != nil {
            return Int(team1Score)! > Int(team2Score)!
        }
        
        return false
    }
}

