//
//  LeagueScheduleViewController.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 4/30/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//

import UIKit

class LeagueScheduleViewController: UIViewController {

    var league: League!
    var schedule: LeagueSchedule!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLeagueSchedule(league.leagueID) { (response, error) in
            if (error == nil) {
               
            } else {
                alertBox("Error", message: "An error occured: \(error.debugDescription)", controller: self)
            }
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
