//
//  LeagueViewController.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 4/25/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//

import UIKit
import Kingfisher

class LeagueViewController: UIViewController {

    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var startsLabel: UILabel!
    @IBOutlet weak var registrationLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var scheduleButton: UIButton!
    @IBOutlet weak var standingsButton: UIButton!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var leagueDetailsContainer: UIView!
    
    var dashboardRow: DashboardRow!
    var league: League!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leagueDetailsContainer.isHidden = true
        activityIndicator.startAnimating()
        //let url = URL(string: dashboardRow.logoUrl)!

//        KingfisherManager.shared.retrieveImage(with: url, options: nil, progressBlock: nil) {
//            (image, error, cacheType, url) in
//            if let image = image {
//
//                let button = UIButton.init(type: .custom)
//                button.setImage(image, for: .normal)
//                button.frame = CGRect.init(x: 0, y: 0, width: 20, height: 20) //CGRectMake(0, 0, 30, 30)
//                button.widthAnchor.constraint(equalToConstant: 20.0)
//                button.heightAnchor.constraint(equalToConstant: 20.0)
//                button.imageView?.contentMode = .scaleAspectFit
//
//                let barButton = UIBarButtonItem.init(customView: button)
//                self.navigationItem.rightBarButtonItem = barButton
//            }
//        }
        self.leagueNameLabel.text = self.dashboardRow.leagueName
        getLeague(dashboardRow.leagueUrl) { (response, error) in
            self.activityIndicator.stopAnimating()
            if (error == nil) {
                self.league = response
                self.updatePage()
                self.leagueDetailsContainer.isHidden = false
            } else {
                alertBox("Error", message: "An error occured: \(error.debugDescription)", controller: self)
            }
        }
        // Do any additional setup after loading the view.
    }

    func updatePage() {
        self.seasonLabel.attributedText = BoldPartOfString("Season:", label: self.league.season)
        self.startsLabel.attributedText = BoldPartOfString("Starts:", label: self.league.starts)
        self.registrationLabel.attributedText = BoldPartOfString("Registration Dates:", label: self.league.registrationDates)
        self.locationLabel.attributedText = BoldPartOfString("Location:", label: self.league.location.name)
        self.weekDayLabel.attributedText = BoldPartOfString("Week Day:", label: self.league.dayOfWeek)
        self.timeLabel.attributedText = BoldPartOfString("Time:", label: self.league.timeOfWeek)
        
        if self.league.soldOut {
            self.registerButton.setTitle("(Sold Out)", for: .normal)
            self.registerButton.isEnabled = false
        }
        
        leagueDetailsContainer.isHidden = true

    }
    
    @IBAction func registerClicked(_ sender: Any) {
    }
    
    @IBAction func scheduleClicked(_ sender: Any) {
    }
    
    @IBAction func standingsClicked(_ sender: Any) {
    }
    
    @IBAction func detailsClicked(_ sender: Any) {
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LeagueSchedule" {
            let destination = segue.destination as? LeagueScheduleViewController
            destination?.league = self.league
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
