//
//  RequestUtil.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 4/8/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//

import Foundation
import Alamofire



public func login(_ email: String, password: String, listener: @escaping ((Dashboard?, Error?) -> Void))
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
                    let res = parseDashboard(html: response.result.value!)
                    DispatchQueue.main.async {
                        listener(res,nil)
                    }
                    break
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        listener(nil,error)
                    }
                    break
                }

                
        }
    )
}


public func getDashboard(_ listener: @escaping ((Dashboard?, Error?) -> Void))
{
    let queue = DispatchQueue(label: "main_queue", qos: .utility, attributes: [.concurrent])
    
    Alamofire.request("https://phillyleagues.leagueapps.com/dashboard", method: .get, encoding: URLEncoding.default)
        .response(
            queue: queue,
            responseSerializer: DataRequest.stringResponseSerializer(),
            completionHandler: { response in
                switch response.result {
                case .success(let data):
                    let res = parseDashboard(html: response.result.value!)
                    DispatchQueue.main.async {
                        listener(res,nil)
                    }
                    break
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        listener(nil,error)
                    }
                    break
                }
                
                
        }
    )
}


public func getLeague(_ url: String, listener: @escaping ((League?, Error?) -> Void))
{
    let queue = DispatchQueue(label: "main_queue", qos: .utility, attributes: [.concurrent])
    
    Alamofire.request(url, method: .get, encoding: URLEncoding.default)
        .response(
            queue: queue,
            responseSerializer: DataRequest.stringResponseSerializer(),
            completionHandler: { response in
                switch response.result {
                case .success(let data):
                    let res = parseLeague(html: response.result.value!)
                    DispatchQueue.main.async {
                        listener(res,nil)
                    }
                    break
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        listener(nil,error)
                    }
                    break
                }
                
                
        }
    )
}

public func clearCookies() -> Void{
    let cookieStore = HTTPCookieStorage.shared
    for cookie in cookieStore.cookies ?? [] {
        cookieStore.deleteCookie(cookie)
    }
}
