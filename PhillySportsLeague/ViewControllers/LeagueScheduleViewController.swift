//
//  LeagueScheduleViewController.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 4/30/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//

import UIKit

class LeagueScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var league: League!
    var schedule: LeagueSchedule!
    var leagueSchedule: LeagueSchedule!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        self.tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        self.tableView.separatorStyle = .none
        self.tableView.refreshControl?.beginRefreshingManually()
        self.tableView.register(UINib(nibName: "GameRow", bundle: nil), forCellReuseIdentifier: "GameRow")

        
        getLeagueSchedule(league.leagueID) { (response, error) in
            if (error == nil) {
                self.tableView.refreshControl?.endRefreshing()
                self.leagueSchedule = response
               self.tableView.reloadData()
            } else {
                alertBox("Error", message: "An error occured: \(error.debugDescription)", controller: self)
            }
        }
        
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameRow", for: indexPath) as! LeagueGameTableViewCell
        let game = leagueSchedule.games[indexPath.row]
        cell.dateLabel.text = game.date + " @ " + game.time
        cell.team1Button.setTitle(game.team1Name, for: .normal)
        cell.team2Button.setTitle(game.team2Name, for: .normal)
        cell.team1Score.text = game.team1Score
        cell.team2Score.text = game.team2Score
        cell.locationLabel.text = "Location: " + game.location.name
        return cell
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.leagueSchedule != nil {
            return self.leagueSchedule.games.count
        } else {
            return 0
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.tableView.refreshControl?.endRefreshing()
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