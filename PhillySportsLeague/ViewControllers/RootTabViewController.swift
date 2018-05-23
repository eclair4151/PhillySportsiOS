//
//  RootTabViewController.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 5/23/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//

import UIKit

class RootTabViewController: UITabBarController {

    var currentTab:UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if self.currentTab == item {
            (selectedViewController as! ParentTabViewController).navController?.popToRootViewController(animated: true)
        } else {
            self.currentTab = item
        }
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
