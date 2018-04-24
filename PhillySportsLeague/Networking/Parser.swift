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
                let leagueUrl  = try! columns.get(0).select("a").first()?.attr("href")
                let leagueName = try! columns.get(0).select("a").first()?.text()
                let startDate = try! columns.get(0).select("small").first()?.text()
                let teamUrl = try! columns.get(1).select("a").first()?.attr("href")
                let teamName = try! columns.get(1).select("a").first()?.text()
                let dashboardRow = DashboardRow(leagueName: leagueName!, leagueUrl: leagueUrl!, teamName: teamName!, teamUrl: teamUrl!, startDate: startDate!)
                dash.dashboardRows.append(dashboardRow)
            }
            
            dash.name = (try! doc.select("img#profile-photo").first()?.attr("src"))!
            dash.imageUrl = (try! doc.select("em.context").first()?.text().replacingOccurrences(of: "Welcome back, ", with: ""))!
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
        league.locationName = (try! doc.select("dd.program-list-location a").first()?.text())!
        league.locationUrl = (try! doc.select("dd.program-list-location a").first()?.attr("href"))!
        
        //may not be there
        let prices = try! doc.select("span.individual-price")
        if prices.size() == 2 {
            league.individualPrice = try! prices.get(0).text()
            league.freeAgentPrice = try! prices.get(1).text()
        }
        
        league.dayOfWeek = (try! doc.select("span.base-gamedays strong").first()?.text())!
        league.timeOfWeek = (try! doc.select("div.base-schedule em").first()?.text())!
        
        //got to do some weird stuff
        league.scheduleUrl = (try! doc.select("li[data-id=Schedule] a").first()?.attr("href"))!
        league.standingsUrl = (try! doc.select("li[data-id=Standings] a").first()?.attr("href"))!

        return league
    } catch Exception.Error(let type, let message) {
        print(message)
    } catch {
        print("error")
    }
    return league
}
