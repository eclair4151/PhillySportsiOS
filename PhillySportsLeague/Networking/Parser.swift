//
//  Parser.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 4/18/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//

import Foundation
import SwiftSoup

public func parseDashboard(html: String) -> Dashboard {
    let dash = Dashboard()

    do {
        let doc: Document = try SwiftSoup.parse(html)

        if html.range(of: "The following errors have occurred:") != nil {
            dash.success = false
            let errors = try! doc.select("p.sys-error")
            if errors.size() > 0 {
                dash.error = try! errors.get(0).text()
            }
        } else {
            let rows: [Element] = try! doc.select("table#ga-members-table tr").array()
            //drop first because its the header
            for row in rows.dropFirst() {
                let columns = try! row.select("td")
                let leagueUrl  = Constants.baseUrl + (try! columns.get(0).select("a").first()?.attr("href"))!
                let leagueName = try! columns.get(0).select("a").first()?.text()
                let startDate = try! columns.get(0).select("small").first()?.text()
                let teamUrl = Constants.baseUrl +  (try! columns.get(1).select("a").first()?.attr("href"))!
                let teamName = try! columns.get(1).select("a").first()?.text()
                let dashboardRow = DashboardRow(leagueName: leagueName!, leagueUrl: leagueUrl, teamName: teamName!, teamUrl: teamUrl, startDate: startDate!)
                dash.dashboardRows.append(dashboardRow)
            }
            
            dash.imageUrl = (try! doc.select("img#profile-photo").first()?.attr("src"))!
            dash.name = (try! doc.select("em.context").first()?.text().replacingOccurrences(of: "Welcome back, ", with: ""))!
            dash.success = true

        }
        return dash
    } catch Exception.Error(let type, let message) {
        print(message)
    } catch {
        print("error")
    }
    return dash
}




public func parseLeague(html: String) -> League {
    let league = League()
    
    do {
        let doc: Document = try SwiftSoup.parse(html)
        league.soldOut = try! doc.select("a#programRegButton").size() == 0
        league.season = (try! doc.select("dd.program-list-season").first()?.text())!
        league.starts = (try! doc.select("dd.program-list-starts").first()?.text())!
        league.registrationDates = (try! doc.select("dd.program-list-registration-dates").first()?.text())!
        let location = GameLocation()
        location.name = (try! doc.select("dd.program-list-location a").first()?.text())!
        location.url = (try! doc.select("dd.program-list-location a").first()?.attr("href"))!
        league.location = location
        //may not be there
        let prices = try! doc.select("span.individual-price")
        if prices.size() == 2 {
            league.teamPrice = try! prices.get(0).text()
            league.freeAgentPrice = try! prices.get(1).text()
        }
        
        if prices.size() == 1 {
            league.freeAgentPrice = try! prices.get(0).text()
        }
        
        league.dayOfWeek = (try! doc.select("span.base-gamedays strong").first()?.text())!
        league.timeOfWeek = (try! doc.select("div.base-schedule em").first()?.text())!
        
        //got to do some weird stuff
        league.scheduleUrl = (try! doc.select("li[data-id=Schedule] a").first()?.attr("href"))!
        league.standingsUrl = (try! doc.select("li[data-id=Standings] a").first()?.attr("href"))!

        league.leagueID = String(league.scheduleUrl.split(separator: "/")[1])
        return league
    } catch Exception.Error(let type, let message) {
        print(message)
    } catch {
        print("error")
    }
    return league
}


public func parseLeagueSchedule(html :String) -> LeagueSchedule {
    let schedule = LeagueSchedule()
    do {
        let doc: Document = try SwiftSoup.parseBodyFragment(html)
        let gameRows = try! doc.select("li.schedule-game").array()
        for row in gameRows {
            let game = Game()
            game.date = try! row.select("span.date").first()!.text()
            game.time = try! row.select("span.time").first()!.text()
            
            let location = GameLocation()
            location.name = try! row.select("p.event-details a").first()!.text()
            location.url = try! row.select("p.event-details a").first()!.attr("href")
            game.location = location
            
            game.team1Name = try! row.select("span.team-score a").first()!.text()
            game.team1URL = try! row.select("span.team-score a").first()!.attr("href")
            var score = try! row.select("span.team-score strong.score").first()!.text()
            if score != "" {
                game.team1Score = Int(score)!
            }
            
            if try! row.select("span.team-score a").size() > 1 {
                game.team2Name = try! row.select("span.team-score a").get(1).text()
                game.team2URL = try! row.select("span.team-score a").get(1).attr("href")
                score = try! row.select("span.team-score strong.score").get(1).text()
                if score != "" {
                    game.team1Score = Int(score)!
                }
            }
            schedule.games.append(game)
        }
        return schedule
    } catch Exception.Error(let type, let message) {
        print(message)
    } catch {
        print("error")
    }
    return schedule
}



public func parseTeamSchedule(html :String) -> LeagueSchedule {
    let schedule = LeagueSchedule()
    do {
        let doc: Document = try SwiftSoup.parseBodyFragment(html)
        let gameRows = try! doc.select("li.schedule-game").array()
        for row in gameRows {
            let game = Game()
            game.date = try! row.select("span.date").first()!.text()
            game.time = try! row.select("span.time").first()!.text()
            
            let location = GameLocation()
            location.name = try! row.select("p.event-details a").first()!.text()
            location.url = try! row.select("p.event-details a").first()!.attr("href")
            game.location = location
            
            //game.team1Name = try! row.select("span.team-score a").first()!.text()
            //game.team1URL = try! row.select("span.team-score a").first()!.attr("href")
            var score = try! row.select("span.team-score strong.score").first()!.text()
            if score != "" {
                game.team1Score = Int(score)!
            }
            
            if try! row.select("h3.event-team a").size() > 0 {
                game.team2Name = try! row.select("h3.event-team a").first()!.text()
                game.team2URL = try! row.select("h3.event-team a").first()!.attr("href")
            }
            schedule.games.append(game)
        }
        return schedule
    } catch Exception.Error(let type, let message) {
        print(message)
    } catch {
        print("error")
    }
    return schedule
}
