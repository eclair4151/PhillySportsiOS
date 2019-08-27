//
//  TeamViewController.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 5/4/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//

import UIKit

class TeamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
        
        self.title = self.teamName
        
        let ids = self.teamUrl.split(separator: "/")
        
        getTeamSchedule(String(ids[3]), leagueID: String(ids[1])) { (response, error) in
            self.tableView.refreshControl?.endRefreshing()
            if (error == nil) {
                self.teamSchedule = response
                self.tableView.reloadData()
            } else {
                alertBox("Error", message: "An error occured: \(error.debugDescription)", controller: self)
            }
            
        }
        
        self.tableView.estimatedRowHeight = 132
        
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameRow", for: indexPath) as! LeagueGameTableViewCell
        let game = teamSchedule.games[indexPath.row]
        cell.dateLabel.text = game.date + " @ " + game.time
        cell.team1Button.setTitle(self.teamName, for: .normal)
        cell.team2Button.setTitle(game.team2Name, for: .normal)
        cell.team2Button.tag = indexPath.row
        cell.team2Button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)

        cell.team1Score.text = game.team1Score
        cell.team2Score.text = game.team2Score
        
        cell.locationLabel.text = "Location: " + game.location.name
        
        if game.tag.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            cell.tagLabel.text = "  " + game.tag + "  "
        } else {
            cell.tagLabel.text = ""
        }
        
        if game.team1Score.trimmingCharacters(in: .whitespacesAndNewlines) != "" && game.team2Score.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            if game.didTeam1Win() {
                cell.sideColor.backgroundColor = hexStringToUIColor("#306ABC")
            } else {
                cell.sideColor.backgroundColor = hexStringToUIColor("#EDEDED")
            }
        } else {
            cell.sideColor.backgroundColor = hexStringToUIColor("#0EB491")
        }
        return cell
    }
    
    @objc func buttonClicked(_ sender : UIButton) {
        let team = self.teamSchedule.games[sender.tag]

        if !team.team2URL.isEmpty {
            let nextView = self.storyboard?.instantiateViewController(withIdentifier: "TeamViewController") as! TeamViewController
            nextView.teamUrl = team.team2URL
            nextView.teamName = team.team2Name
            self.navigationController?.pushViewController(nextView, animated: true)
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }

}
