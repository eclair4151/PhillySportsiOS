//
//  HeaderRow.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 5/18/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//

import Foundation
public class HeaderRow: Hashable {
    
    //MARK: Properties
    init(title: String) {
        self.title = title
        expanded = false
    }
    
    public var hashValue: Int {
        return self.title.hash
    }
    
    static public func ==(lhs: HeaderRow, rhs: HeaderRow) -> Bool {
        return lhs.title == rhs.title
    }
    
    var title: String
    var expanded: Bool
    
}
