//
//  RequestUtil.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 4/8/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//

import Foundation
import Alamofire



public func login(_ email: String, password: String, listener: @escaping ((LoginResponse) -> Void))
{
    let queue = DispatchQueue(label: "main_queue", qos: .utility, attributes: [.concurrent])
    
    let headers = [
        "Content-Type": "application/x-www-form-urlencoded"
    ]
    
    let parameters = [
        "username": email,
        "password" : String(password.prefix(15)),
        "targetUrl" : "/dashboard",
        "rememberMe" : "true",
        "__checkbox_rememberMe" : "true"
    ]
    
    Alamofire.request("https://phillyleagues.leagueapps.com/loginSubmit", method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        .response(
            queue: queue,
            responseSerializer: DataRequest.stringResponseSerializer(),
            completionHandler: { response in
                
                switch response.result {
                case .success(let data):
                    if response.result.value?.range(of: "Please fix the following errors:") != nil {
                        let res = LoginResponse(success: false)
                        
                        listener(res)
                    }
                    break
                    
                case .failure(let error):
                    break
                    //alertError(self, error: error,response:response, request: "deleteEntry")
                }
                // You are now running on the concurrent `queue` you created earlier.
                print("Parsing JSON on thread: \(Thread.current) is main thread: \(Thread.isMainThread)")
                
                // Validate your JSON response and convert into model objects if necessary
                //print(response.result.value)
                
                // To update anything on the main thread, just jump back on like so.
                DispatchQueue.main.async {
                    print("Am I back on the main thread: \(Thread.isMainThread)")
                }
        }
    )
}

