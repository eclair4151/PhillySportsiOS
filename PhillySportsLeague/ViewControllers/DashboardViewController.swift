//
//  DashboardViewController.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 4/23/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//

import UIKit
import Kingfisher

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var dashboard: Dashboard!
    var pastDashboard: Dashboard!
    
    @IBOutlet weak var currentIndicator: UIView!
    @IBOutlet weak var currentButton: UIButton!
    @IBOutlet weak var pastButton: UIButton!
    @IBOutlet weak var pastIndicator: UIView!
    
    var isPast:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        self.tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        self.tableView.separatorStyle = .none
        self.tableView.refreshControl?.beginRefreshingManually()
        handleRefresh(refreshControl)
        // Do any additional setup after loading the view.
    }

    func updateScreen() {
        self.tableView.reloadData()
    }

    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        getDashboard(isPast) { (response, error) in
            refreshControl.endRefreshing()
            
            if (error == nil) {
                if (response!.success) {
                    self.dashboard = response
                    self.updateScreen()
                } else {
                    
                }
            } else {
                alertBox("Error", message: "An error occured: \(error.debugDescription)", controller: self)
            }
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardRow", for: indexPath) as! DashboardTableViewCell
        let dashRow = dashboard.dashboardRows[indexPath.row]
        let attributed = [
            kCTFontSizeAttribute : 18.0,
            kCTForegroundColorAttributeName : UIColor.black
            ] as [NSAttributedStringKey : Any]
        
        cell.leagueName.setAttributedTitle(NSAttributedString(string: dashRow.leagueName, attributes: attributed), for: .normal)
        cell.leagueName.titleLabel?.numberOfLines = 3
        cell.leagueName.tag = indexPath.row
        cell.teamName.setAttributedTitle(NSAttributedString(string: dashRow.teamName, attributes: attributed), for: .normal)
        cell.teamName.titleLabel?.numberOfLines = 3
        cell.teamName.tag = indexPath.row
        let url = URL(string: dashRow.logoUrl)!
        cell.leagueLogo.kf.setImage(with: url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.dashboard != nil {
            return self.dashboard.dashboardRows.count
        }
        return 0
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let row = (sender as! UIButton).tag
        if segue.identifier == "ShowLeague" {
            let dashboardRow = self.dashboard.dashboardRows[row]
            let destination = segue.destination as? LeagueViewController
            destination?.dashboardRow = dashboardRow
        } else if segue.identifier == "ShowTeam" {
            let dashboardRow = self.dashboard.dashboardRows[row]
            let destination = segue.destination as? TeamViewController
            destination?.teamUrl = dashboardRow.teamUrl
            destination?.teamName = dashboardRow.teamName
    
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "ShowTeam" {
            let row = (sender as! UIButton).tag
            let dashboardRow = self.dashboard.dashboardRows[row]
            return dashboardRow.teamUrl != ""
        }else {
            return true
        }
    }
    
    func handleTabClick() {
        if isPast {
            currentIndicator.isHidden = true
            pastIndicator.isHidden = false
            currentButton.backgroundColor = UIColor(rgb: 0xEEEDF0)
            pastButton.backgroundColor = UIColor(rgb: 0xFFFFFF)

            //grey EEEDF0
            //white FFFFFF
        } else {
            currentIndicator.isHidden = false
            pastIndicator.isHidden = true
            pastButton.backgroundColor = UIColor(rgb: 0xEEEDF0)
            currentButton.backgroundColor = UIColor(rgb: 0xFFFFFF)
        }
    }
    
    @IBAction func pastClicked(_ sender: Any) {
        if !isPast {
            isPast = true
            handleTabClick()
        }
    }
    @IBAction func currentClicked(_ sender: Any) {
        if isPast {
            isPast = false
            handleTabClick()
        }
    }
    
}
