//
//  Dashboard.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 4/18/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//

import Foundation

public class Dashboard: JsonResponse {
    
    //MARK: Properties
    override init() {
        self.imageUrl = ""
        self.name = ""
        self.dashboardRows = []
        self.success = false
        super.init()
    }
    
    var imageUrl: String
    var success: Bool
    var name: String
    var dashboardRows :[DashboardRow]
}
