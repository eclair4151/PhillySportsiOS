//
//  Dashboard.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 4/18/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//

import Foundation

public class Dashboard {
    
    //MARK: Properties
    init() {
        self.imageUrl = ""
        self.name = ""
        self.error = ""
        self.dashboardRows = []
        self.success = false
    }
    
    var imageUrl: String
    var error: String
    var success: Bool
    var name: String
    var dashboardRows :[DashboardRow]
}
