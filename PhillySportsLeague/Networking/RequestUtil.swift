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


public func getDashboard(_ past:Bool, listener: @escaping ((Dashboard?, Error?) -> Void))
{
    let queue = DispatchQueue(label: "main_queue", qos: .utility, attributes: [.concurrent])
    
    Alamofire.request("https://phillyleagues.leagueapps.com/dashboard" + (past ? "?state=past" : ""), method: .get, encoding: URLEncoding.default)
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


public func getLeagueSchedule(_ leagueID: String, listener: @escaping ((LeagueSchedule?, Error?) -> Void))
{
    let queue = DispatchQueue(label: "main_queue", qos: .utility, attributes: [.concurrent])
    let url = "https://phillyleagues.leagueapps.com/ajax/loadSchedule?origin=site&scope=program&itemType=games_events&programId=" + leagueID
    Alamofire.request(url, method: .get, encoding: URLEncoding.default)
        .response(
            queue: queue,
            responseSerializer: DataRequest.stringResponseSerializer(),
            completionHandler: { response in
                switch response.result {
                case .success(let data):
                    let res = parseLeagueSchedule(html: response.result.value!)
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

public func getTeamSchedule(_ teamID: String, leagueID: String, listener: @escaping ((LeagueSchedule?, Error?) -> Void))
{
    let queue = DispatchQueue(label: "main_queue", qos: .utility, attributes: [.concurrent])
    let url = "https://phillyleagues.leagueapps.com/ajax/loadSchedule?origin=site&scope=team&itemType=games_events&teamId=" + teamID + "&programId=" + leagueID
    Alamofire.request(url, method: .get, encoding: URLEncoding.default)
        .response(
            queue: queue,
            responseSerializer: DataRequest.stringResponseSerializer(),
            completionHandler: { response in
                switch response.result {
                case .success(let data):
                    let res = parseTeamSchedule(html: response.result.value!)
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
