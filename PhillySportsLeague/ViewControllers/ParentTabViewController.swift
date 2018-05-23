//
//  ParentTabViewController.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 5/23/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//

import UIKit

class ParentTabViewController: UIViewController {

    var navController: UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RootNavController" {
            self.navController = segue.destination as! UINavigationController
        }
    }
 

}
