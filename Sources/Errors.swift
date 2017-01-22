//
//  Error.swift
//  g
//
//  Created by Zaid Daghestani on 1/20/17.
//  Copyright © 2017 Harlan Kellaway. All rights reserved.
//

import Foundation

public enum JParseError:Error, Equatable, CustomStringConvertible, CustomDebugStringConvertible {
    case missingField(String, JSON)
    case incorrectType(String, Any, Any.Type)
    case badValue(String, Any)
    
    public var description: String {
        switch self {
        case let .missingField(string, json):
            return "Field \(string) not found in json: \(json)"
        case let .incorrectType(string, any, json):
            return "Field \(string) has incorrect type. Expected \(any) for key \(string) in json: \(json)"
        case let .badValue(string, any):
            return "Field \(string) had an inconvertible value (couldnt parse Date, Enum, UUID... etc) from json: \(any)"
        }
    }
    
    public var debugDescription: String {
        return self.description
    }
}

public func == (e1:JParseError, e2:JParseError) -> Bool {
    switch e1 {
    case let .missingField(string, json):
        switch e2 {
        case let .missingField(string2, json2):
            return string2 == string && json.keys == json2.keys
        default:
            return false
        }
    case let .incorrectType(string, any, type):
        switch e2 {
        case let .incorrectType(string2, any2, type2):
            return string2 == string && type2 == type && any == any2
        default:
            return false
        }
    case let .badValue(string, any):
        switch e2 {
        case let .badValue(string2, any2):
            return string2 == string && any2 == any
        default:
            return false
        }
    }
}

private func == (l:LazyMapCollection<JSON, String>, r:LazyMapCollection<JSON, String>) -> Bool {
    var lk = [String]()
    var rk = [String]()
    for k in l {
        lk.append(k)
    }
    for k in r {
        rk.append(k)
    }
    return lk == rk
}

private func == (l:Any, r:Any) -> Bool {
    return String(describing: l) == String(describing:r)
}
