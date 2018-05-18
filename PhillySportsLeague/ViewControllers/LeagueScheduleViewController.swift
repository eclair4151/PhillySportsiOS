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
        self.tableView.register(UINib(nibName: "DateSectionHeader", bundle: nil), forCellReuseIdentifier: "DateSectionHeader")
        
        getLeagueSchedule(league.leagueID) { (response, error) in
            if (error == nil) {
                self.tableView.refreshControl?.endRefreshing()
                self.leagueSchedule = response
               self.tableView.reloadData()
            } else {
                alertBox("Error", message: "An error occured: \(error.debugDescription)", controller: self)
            }
        }
        
        self.tableView.estimatedRowHeight = 132
        self.tableView.estimatedSectionHeaderHeight = 41
        self.tableView.rowHeight = UITableViewAutomaticDimension

        
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameRow", for: indexPath) as! LeagueGameTableViewCell
        let date = leagueSchedule.sectionDates[indexPath.section]
        let game = leagueSchedule.dateGameMap[date]![indexPath.row]
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
            let date = self.leagueSchedule.sectionDates[section]
            return self.leagueSchedule.dateGameMap[date]!.count
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.leagueSchedule != nil {
            return self.leagueSchedule.sectionDates.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DateSectionHeader") as! DateHeaderTableViewCell
        let date = leagueSchedule.sectionDates[section]
        cell.dateTitle.text = date.title
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 41
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
