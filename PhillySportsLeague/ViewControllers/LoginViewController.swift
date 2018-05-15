//
//  LoginViewController.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 4/7/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var emailBox: UITextField!
    @IBOutlet weak var passwordBox: UITextField!
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var labelLoginMessage: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.adjustsFontSizeToFitWidth = true
    }

    override func viewDidLayoutSubviews() {
        passwordBox.underline()
        emailBox.underline()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func textFieldShouldReturn(_ textField: UITextField!) -> Bool {
        if(textField == emailBox)
        {
            passwordBox.becomeFirstResponder()
        }
        else
        {
            textField.resignFirstResponder()
            loginPressed(textField)
        }
        return true
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        if ((self.emailBox.text?.isEmpty)! || (self.passwordBox.text?.isEmpty)!) {
            alertBox("Error", message: "One or more fields are empty", controller: self)
        } else {
            self.loadingView.startAnimating()
            self.loginButton.setTitle("", for: .normal)
            clearCookies()
            login(emailBox.text!, password: passwordBox.text!) { (response, error) in
                if (error == nil) {
                    if (!response!.success) {
                        self.labelLoginMessage.text = response?.error
                        self.loginButton.setTitle("Log In", for: .normal)
                        self.loadingView.stopAnimating()
                    } else {
                        UserDefaults.standard.set(true, forKey: "LoggedIn")
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "home") as! UITabBarController
                        vc.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
                        self.present(vc, animated: true, completion: nil)
                    }
                } else {
                    self.loginButton.setTitle("Log In", for: .normal)
                    self.loadingView.stopAnimating()
                    //alert error
                    alertBox("Error", message: "An error occured: \(error.debugDescription)", controller: self)
                }
            }
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
    @IBAction func forgotPasswordClicked(_ sender: Any) {
        UIApplication.shared.open(URL(string : "https://phillyleagues.leagueapps.com/login")!, options: [:], completionHandler: { (status) in
        })
    }
    
    @IBAction func loginFBPressed(_ sender: Any) {
    }
    
}
