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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
            //loginPressed(textField)
        }
        return true
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        let cookieStore = HTTPCookieStorage.shared
        for cookie in cookieStore.cookies ?? [] {
            cookieStore.deleteCookie(cookie)
        }
        
        login(emailBox.text!, password: passwordBox.text!) { (response) in
            
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
    
    @IBAction func loginFBPressed(_ sender: Any) {
    }
    
}
