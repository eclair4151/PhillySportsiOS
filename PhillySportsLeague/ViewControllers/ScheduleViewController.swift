//
//  ScheduleViewController.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 5/21/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var gameSchedule :GameSchedule!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        self.tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        self.tableView.separatorStyle = .none
        self.tableView.refreshControl?.beginRefreshingManually()
        self.tableView.register(UINib(nibName: "LeagueGameRow", bundle: nil), forCellReuseIdentifier: "LeagueGameRow")
        
        self.tableView.estimatedRowHeight = 188
        
        getSchedule { (schedule, error) in
            self.tableView.refreshControl?.endRefreshing()
            if (error == nil) {
                self.gameSchedule = schedule
                self.tableView.reloadData()
            } else {
                alertBox("Error", message: "An error occured: \(error.debugDescription)", controller: self)
            }
        }
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueGameRow", for: indexPath) as! LeagueGameTableViewCell
        let game = gameSchedule.games[indexPath.row]
        cell.dateLabel.text = game.date + " @ " + game.time
        cell.team1Button.setTitle(game.team1Name, for: .normal)
        cell.team2Button.setTitle(game.team2Name, for: .normal)
        cell.team2Button.tag = indexPath.row
        cell.team2Button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)

//        cell.team1Score.text = game.team1Score
//        cell.team2Score.text = game.team2Score

        cell.locationLabel.text = "Location: " + game.location.name
        let url = URL(string: game.leagueImageUrl)!

        cell.leagueImage.kf.setImage(with: url)
        cell.leagueName.text = game.leagueName

       
        return cell
    }
    
    @objc func buttonClicked(_ sender : UIButton) {
        let nextView = self.storyboard?.instantiateViewController(withIdentifier: "TeamViewController") as! TeamViewController
        let game = gameSchedule.games[sender.tag]
        nextView.teamUrl = game.team2URL
        nextView.teamName = game.team2Name
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.gameSchedule == nil {
            return 0
        } else {
            return self.gameSchedule.games.count
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
