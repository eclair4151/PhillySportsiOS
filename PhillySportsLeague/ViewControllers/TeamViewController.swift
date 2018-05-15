//
//  TeamViewController.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 5/4/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//

import UIKit

class TeamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messagesButton: UIButton!
    @IBOutlet weak var rosterButton: UIButton!
    @IBOutlet weak var tableviewBottomSpace: NSLayoutConstraint!
    
    var teamSchedule: LeagueSchedule!
    var teamUrl: String!
    var teamName: String!

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
        
        self.teamNameLabel.text = self.teamName
        
        let ids = self.teamUrl.split(separator: "/")
        
        getTeamSchedule(String(ids[3]), leagueID: String(ids[1])) { (response, error) in
            if (error == nil) {
                self.tableView.refreshControl?.endRefreshing()
                self.teamSchedule = response
                self.tableView.reloadData()
            } else {
                alertBox("Error", message: "An error occured: \(error.debugDescription)", controller: self)
            }
            
        }
        
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameRow", for: indexPath) as! LeagueGameTableViewCell
        let game = teamSchedule.games[indexPath.row]
        cell.dateLabel.text = game.date + " @ " + game.time
        cell.team1Button.setTitle(self.teamName, for: .normal)
        cell.team2Button.setTitle(game.team2Name, for: .normal)
        cell.team1Score.text = game.team1Score
        cell.team2Score.text = game.team2Score
        
        cell.locationLabel.text = "Location: " + game.location.name
        
        if game.team1Score != "" && game.team2Score != "" {
            if game.didTeam1Win() {
                cell.sideColor.backgroundColor = hexStringToUIColor("#306ABC")
            } else {
                cell.sideColor.backgroundColor = hexStringToUIColor("#EDEDED")
            }
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.teamSchedule == nil {
            return 0
        } else {
            return self.teamSchedule.games.count
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.tableView.refreshControl?.endRefreshing()
    }
    
    @IBAction func rosterClicked(_ sender: Any) {
    }
    
    @IBAction func messagesClicked(_ sender: Any) {
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
