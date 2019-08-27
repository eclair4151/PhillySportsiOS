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
    var tagGameMap : [Int : Game] = [:]
    
    
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
        self.tableView.register(UINib(nibName: "DateSectionHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "DateSectionHeader")
        
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
        cell.team1Button.teamUrl = game.team1URL
        cell.team1Button.teamName = game.team1Name
        cell.team2Button.teamName = game.team2Name
        cell.team2Button.teamUrl = game.team2URL
        cell.team2Button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        cell.team1Button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)

        if game.tag.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            cell.tagLabel.text = "  " + game.tag + "  "
        } else {
            cell.tagLabel.text = ""
        }
        
        return cell
    }
    
    @objc func buttonClicked(_ sender : DataButton) {
        if let tUrl = sender.teamUrl, !tUrl.isEmpty {
            let nextView = self.storyboard?.instantiateViewController(withIdentifier: "TeamViewController") as! TeamViewController
            nextView.teamUrl = tUrl
            nextView.teamName = sender.teamName!
            self.navigationController?.pushViewController(nextView, animated: true)
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.leagueSchedule != nil  && self.leagueSchedule.sectionDates[section].expanded {
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
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DateSectionHeader") as! DateHeaderTableViewCell
        let date = leagueSchedule.sectionDates[section]
        cell.dateTitle.text = date.title
        cell.tag = section
        let tapgesture = UITapGestureRecognizer(target: self , action: #selector(self.sectionTapped(_:)))
        cell.addGestureRecognizer(tapgesture)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 41
    }
    
    @objc func sectionTapped(_ sender: UITapGestureRecognizer){
        let index = sender.view!.tag
        self.leagueSchedule.sectionDates[index].expanded = !self.leagueSchedule.sectionDates[index].expanded
        let cell = sender.view as! DateHeaderTableViewCell
        cell.expandedArrow.rotate(self.leagueSchedule.sectionDates[index].expanded ? .pi/2 : 0.0)
        self.tableView.reloadSections(IndexSet(integer: index), with: .automatic)
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
