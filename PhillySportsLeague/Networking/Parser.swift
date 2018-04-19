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
            dash.success = true
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
        }
        return dash
    } catch Exception.Error(let type, let message) {
        print(message)
    } catch {
        print("error")
    }
    
    
    return dash
}
