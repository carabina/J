//
//  Error.swift
//  g
//
//  Created by Zaid Daghestani on 1/20/17.
//  Copyright © 2017 Harlan Kellaway. All rights reserved.
//

import Foundation

enum ParseError:Error {
    case missingField(String, JSON)
    case incorrectType(String, Any, Any.Type)
    case badValue(String, Any)
}
