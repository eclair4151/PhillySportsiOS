//
//  Schedule.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 4/29/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//

import Foundation

public class LeagueSchedule {
    
    //MARK: Properties
    init() {
        self.games = []
        self.sectionDates = []
        self.dateGameMap = [:]
    }
    
    var games:[Game]!
    var sectionDates: [HeaderRow]!
    var dateGameMap: [HeaderRow:[Game]]!
    
    func addGame(game: Game) {
        games.append(game)
        let header = HeaderRow(title: game.date)
        if dateGameMap[header] != nil {
            (dateGameMap[header]!).append(game)
        } else {
            self.sectionDates.append(header)
            dateGameMap[header] = [game]
        }
    }
    
}

