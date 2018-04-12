//
//  LoginResponse.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 4/11/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//

import Foundation

public class LoginResponse {
    
    //MARK: Properties
    init(success: Bool) {
        self.success = success
        self.error = ""
    }
    
    var success: Bool
    var error: String = ""
    
}
