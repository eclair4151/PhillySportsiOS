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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none

            getDashboard { (response, error) in
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
        // Do any additional setup after loading the view.
    }

    func updateScreen() {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        cell.teamName.setAttributedTitle(NSAttributedString(string: dashRow.teamName, attributes: attributed), for: .normal)
        cell.teamName.titleLabel?.numberOfLines = 3

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
