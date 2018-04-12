//
//  LoginWebViewController.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 4/7/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//

import UIKit
import WebKit

class LoginWebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    var loginWebview: WKWebView!
    
    
    @IBOutlet weak var webviewHolder: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
      
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        if (self.loginWebview == nil)
        {
            let contentController = WKUserContentController()
           // let js: String = "$('.fwb').click();"
            let js: String = "setTimeout( function () { FB.login(handleFBLogin, {scope: 'email,public_profile', return_scopes: true}); }, 3000);"
            
            let userScript = WKUserScript(source: js, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: false)
            contentController.addUserScript(userScript)
            let config = WKWebViewConfiguration()
            //config.userContentController = contentController
            
            self.loginWebview = WKWebView(
                frame: self.webviewHolder.bounds,
                configuration: config
            )
            
            loginWebview.navigationDelegate = self
            loginWebview.uiDelegate = self
            
            let dataStore = WKWebsiteDataStore.default()
            dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { (records) in
                for record in records {
                    if record.displayName.contains("facebook") {
                        dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), for: [record], completionHandler: {
                            print("Deleted: " + record.displayName);
                        })
                    }
                }
            }
            self.webviewHolder.addSubview(self.loginWebview)
            
            let myURL = URL(string: "https://phillyleagues.leagueapps.com/login")
            let myRequest = URLRequest(url: myURL!)
            self.loginWebview.load(myRequest)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        // A nil targetFrame means a new window (from Apple's doc)
        if (navigationAction.targetFrame == nil) {
            // Let's create a new webview on the fly with the provided configuration,
            // set us as the UI delegate and return the handle to the parent webview
            let popup = WKWebView(frame: self.loginWebview.bounds, configuration: configuration)
            popup.navigationDelegate = self
            popup.uiDelegate = self
            self.webviewHolder.addSubview(popup)
            return popup
        }
        return nil;
    }
    
    func webViewDidClose(_ webView: WKWebView) {
        // Popup window is closed, we remove it
        webView.removeFromSuperview()
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        if webView.url?.absoluteString.range(of:"phillyleagues.leagueapps.com/dashboard") != nil {
            cancelClicked(webView)
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
