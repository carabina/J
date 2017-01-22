//
//  Decoder.swift
//  Gloss
//
// Copyright (c) 2015 Harlan Kellaway
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import Foundation

/**
Decodes JSON to objects.
*/
public struct Decoder {
    
    /**
     Decodes JSON to a generic value.
    
    - parameter key: Key used in JSON for decoded value.
    
    - returns: Value decoded from JSON.
    */
    public static func decode<T>(key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> T {
        return {
            json in
            
            if let value:T = try decodeOptional(key: key, keyPathDelimiter: keyPathDelimiter)(json) {
                return value
            } else {
                throw JParseError.missingField(key, json)
            }
        }
    }
    
    public static func decodeOptional<T>(key:String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> T? {
        return {
            json in
            if let value = json.valueForKeyPath(keyPath: key, withDelimiter: keyPathDelimiter) {
                if let typedValue = value as? T {
                    return typedValue
                } else {
                    throw JParseError.incorrectType(key, json, T.self)
                }
            } else {
                return nil
            }
        }
    }
    
    /**
     Decodes JSON to a date.
     
     - parameter key:           Key used in JSON for decoded value.
     - parameter dateFormatter: Date formatter used to create date.
     
     - returns: Value decoded from JSON.
     */
    public static func decode(dateForKey key: String, dateFormatter: DateFormatter, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> Date {
        return {
            json in
            if let value = try decodeOptional(dateForKey: key, dateFormatter: dateFormatter, keyPathDelimiter: keyPathDelimiter)(json) {
                return value
            } else {
                throw JParseError.missingField(key, json)
            }
        }
    }
    
    public static func decodeOptional(dateForKey key: String, dateFormatter: DateFormatter, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> Date? {
        return {
            json in
            if let value = json.valueForKeyPath(keyPath: key, withDelimiter: keyPathDelimiter) {
                if let typedValue = value as? String {
                    if let date = dateFormatter.date(from: typedValue) {
                        return date
                    } else {
                        throw JParseError.badValue(key, json)
                    }
                } else {
                    throw JParseError.incorrectType(key, json, String.self)
                }
            } else {
                return nil
            }
        }
    }
    
    public static func decode(dateArrayForKey key: String, dateFormatter: DateFormatter, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> [Date] {
        return {
            json in
            if let value = try decodeOptional(dateArrayForKey: key, dateFormatter: dateFormatter, keyPathDelimiter: keyPathDelimiter)(json) {
                return value
            } else {
                throw JParseError.missingField(key, json)
            }
        }
    }
    
    public static func decodeOptional(dateArrayForKey key: String, dateFormatter: DateFormatter, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> [Date]? {
        return {
            json in
            if let value = json.valueForKeyPath(keyPath: key, withDelimiter: keyPathDelimiter) {
                if let typedValue = value as? [String] {
                    var dates = [Date]()
                    for string in typedValue {
                        guard let date = dateFormatter.date(from: string) else {
                            throw JParseError.badValue(key, json)
                        }
                        dates.append(date)
                    }
                    return dates
                } else {
                    throw JParseError.incorrectType(key, json, [String].self)
                }
            } else {
                return nil
            }
        }
    }
    
    /**
     Decodes JSON to an ISO8601 date.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: Value decoded from JSON.
     */
    public static func decode(dateISO8601ForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> Date {
        return Decoder.decode(dateForKey: key, dateFormatter: GlossDateFormatterISO8601, keyPathDelimiter: keyPathDelimiter)
    }
    
    public static func decodeOptional(dateISO8601ForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> Date? {
        return Decoder.decodeOptional(dateForKey: key, dateFormatter: GlossDateFormatterISO8601, keyPathDelimiter: keyPathDelimiter)
    }
    
    public static func decode(dateISO8601ArrayForKey key:String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> [Date] {
        return Decoder.decode(dateArrayForKey: key, dateFormatter: GlossDateFormatterISO8601, keyPathDelimiter: keyPathDelimiter)
    }
    
    public static func decodeOptional(dateISO8601ArrayForKey key:String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> [Date]? {
        return Decoder.decodeOptional(dateArrayForKey: key, dateFormatter: GlossDateFormatterISO8601, keyPathDelimiter: keyPathDelimiter)
    }
    
    /**
     Decodes JSON to a Decodable object.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: Value decoded from JSON.
     */
    public static func decode<T: Decodable>(decodableForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> T {
        return {
            json in
            
            if let value:T = try decodeOptional(decodableForKey: key, keyPathDelimiter: keyPathDelimiter)(json) {
                return value
            }
            
            throw JParseError.missingField(key, json)
            
        }
    }
    
    public static func decodeOptional<T: Decodable>(decodableForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> T? {
        return {
            json in
            if let value = json.valueForKeyPath(keyPath: key, withDelimiter: keyPathDelimiter) {
                if let subJSON = value as? JSON {
                    return try T(json: subJSON)
                } else {
                    throw JParseError.incorrectType(key, json, JSON.self)
                }
            } else {
                return nil
            }
            
        }
    }
    
    /**
     Decodes JSON to a Decodable object array.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: Value decoded from JSON.
     */
    public static func decode<T: Decodable>(decodableArrayForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> [T] {
        return {
            json in
            
            if let value:[T] = try decodeOptional(decodableArrayForKey: key, keyPathDelimiter: keyPathDelimiter)(json) {
                return value
            }
            throw JParseError.missingField(key, json)
        }
    }
    
    public static func decodeOptional<T: Decodable>(decodableArrayForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> [T]? {
        return {
            json in
            
            if let value = json.valueForKeyPath(keyPath: key, withDelimiter: keyPathDelimiter) {
                if let jsonArray = value as? [JSON] {
                    var models: [T] = []
                    for subJSON in jsonArray {
                        models.append(try T(json: subJSON))
                    }
                    return models
                } else {
                    throw JParseError.incorrectType(key, json, [JSON].self)
                }
            }
            throw JParseError.missingField(key, json)
        }
    }
    
    /**
     Decodes JSON to a dictionary of String to Decodable.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: Value decoded from JSON.
     */
    public static func decode<T:Decodable>(decodableDictionaryForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> [String : T] {
        return {
            json in
            if let val:[String:T] = try decodeOptional(decodableDictionaryForKey:key, keyPathDelimiter: keyPathDelimiter)(json) {
                return val
            }
            throw JParseError.missingField(key, json)
        }
    }
    
    public static func decodeOptional<T:Decodable>(decodableDictionaryForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> [String : T]? {
        return {
            json in
            guard let value = json.valueForKeyPath(keyPath: key, withDelimiter: keyPathDelimiter) else {
                return nil
            }
            guard let dictionary = value as? [String : JSON] else {
                throw JParseError.incorrectType(key, json, [String:JSON].self)
            }
            
            return try dictionary.flatMap {
                (key, value) in
                let decoded = try T(json: value)
                
                return (key, decoded)
            }
        }
    }
    
    /**
     Decodes JSON to a dictionary of String to Decodable array.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: Value decoded from JSON.
     */
    public static func decode<T:Decodable>(decodableDictionaryForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> [String : [T]] {
        return {
            json in
            
            if let value:[String:[T]] = try decodeOptional(decodableDictionaryForKey:key, keyPathDelimiter:keyPathDelimiter)(json) {
                return value
            }
            throw JParseError.missingField(key, json)
        }
    }
    
    public static func decodeOptional<T:Decodable>(decodableDictionaryForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> [String : [T]]? {
        return {
            json in
            guard let value = json.valueForKeyPath(keyPath: key, withDelimiter: keyPathDelimiter) else {
                return nil
            }
            guard let dictionary = value as? [String:[JSON]] else {
                throw JParseError.incorrectType(key, json, [String:[JSON]].self)
            }
            
            return try dictionary.flatMap {
                (key, value) in
                let decoded = try [T].from(jsonArray: value)
                
                return (key, decoded)
            }
        }
    }
    
    /**
     Decodes JSON to an enum value.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: Value decoded from JSON.
     */
    public static func decode<T: RawRepresentable>(enumForKey key:String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> T {
        return {
            json in
            if let value:T = try decodeOptional(enumForKey:key, keyPathDelimiter:keyPathDelimiter)(json) {
                return value
            }
            throw JParseError.missingField(key, json)
        }
    }
    
    
    public static func decodeOptional<T: RawRepresentable>(enumForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> T? {
        return {
            json in
            guard let value = json.valueForKeyPath(keyPath: key, withDelimiter: keyPathDelimiter) else {
                return nil
            }
            guard let rawValue = value as? T.RawValue else {
                throw JParseError.incorrectType(key, json, T.RawValue.self)
            }
            guard let enumValue = T(rawValue: rawValue) else {
                throw JParseError.badValue(key, json)
            }
            
            return enumValue
        }
    }
    
    /**
     Decodes JSON to an enum value array.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: Value decoded from JSON.
     */
    public static func decode<T: RawRepresentable>(enumArrayForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> [T] {
        return {
            json in
            
            if let enumValues:[T] = try decodeOptional(enumArrayForKey:key, keyPathDelimiter:keyPathDelimiter)(json) {
                return enumValues
            }
            throw JParseError.missingField(key, json)
        }
    }
    
    public static func decodeOptional<T: RawRepresentable>(enumArrayForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> [T]? {
        return {
            json in
            guard let values = json.valueForKeyPath(keyPath: key, withDelimiter: keyPathDelimiter) else {
                return nil
            }
            guard let rawValues = values as? [T.RawValue] else {
                throw JParseError.incorrectType(key, json, Array<T.RawValue>.self)
            }
            var enumValues:[T] = []
            for rawValue in rawValues {
                guard let enumValue = T(rawValue: rawValue) else {
                    throw JParseError.badValue(key, rawValue)
                }
                enumValues.append(enumValue)
            }
            return enumValues
        }
    }
    
    /**
     Decodes JSON to an Int32.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: Value decoded from JSON.
     */
    public static func decode(int32ForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> Int32 {
        return {
            json in
            
            if let number = try decodeOptional(int32ForKey: key, keyPathDelimiter: keyPathDelimiter)(json) {
                return number
            }
            
            throw JParseError.missingField(key, json)
        }
    }
    
    public static func decodeOptional(int32ForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> Int32? {
        return {
            json in
            guard let value = json.valueForKeyPath(keyPath: key, withDelimiter: keyPathDelimiter) else {
                return nil
            }
            guard let number = value as? NSNumber else {
                throw JParseError.incorrectType(key, json, NSNumber.self)
            }
            return number.int32Value
        }
    }
    
    /**
     Decodes JSON to an Int32 array.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: Value decoded from JSON.
     */
    public static func decode(int32ArrayForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> [Int32] {
        return {
            json in
            
            if let numbers = try decodeOptional(int32ArrayForKey: key, keyPathDelimiter: keyPathDelimiter)(json) {
                return numbers
            }
            
            throw JParseError.missingField(key, json)
        }
    }
    
    public static func decodeOptional(int32ArrayForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> [Int32]? {
        return {
            json in
            guard let value = json.valueForKeyPath(keyPath:key, withDelimiter: keyPathDelimiter) else {
                return nil
            }
            guard let numbers = value as? [NSNumber] else {
                throw JParseError.incorrectType(key, json, [NSNumber].self)
            }
            return numbers.map { $0.int32Value }
        }
    }

	/**
	Decodes JSON to an UInt32.

	- parameter key: Key used in JSON for decoded value.

	- returns: Value decoded from JSON.
	*/
	public static func decode(uint32ForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> UInt32 {
		return {
			json in

            if let number = try decodeOptional(uint32ForKey: key, keyPathDelimiter: keyPathDelimiter)(json) {
				return number
			}

			throw JParseError.missingField(key, json)
		}
	}
    
    public static func decodeOptional(uint32ForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> UInt32? {
        return {
            json in
            guard let value = json.valueForKeyPath(keyPath: key, withDelimiter: keyPathDelimiter) else {
                return nil
            }
            guard let number = value as? NSNumber else {
                throw JParseError.incorrectType(key, json, NSNumber.self)
            }
            return number.uint32Value
        }
    }

	/**
	Decodes JSON to an UInt32 array.

	- parameter key: Key used in JSON for decoded value.

	- returns: Value decoded from JSON.
	*/
	public static func decode(uint32ArrayForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> [UInt32] {
		return {
			json in

            if let numbers = try decodeOptional(uint32ArrayForKey:key, keyPathDelimiter: keyPathDelimiter)(json) {
				return numbers
			}

			throw JParseError.missingField(key, json)
		}
	}
    
    public static func decodeOptional(uint32ArrayForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> [UInt32]? {
        return {
            json in
            guard let value = json.valueForKeyPath(keyPath: key, withDelimiter: keyPathDelimiter) else {
                return nil
            }
            guard let numbers = value as? [NSNumber] else {
                throw JParseError.incorrectType(key, json, [NSNumber].self)
            }
            return numbers.map { $0.uint32Value }
        }
    }

    /**
     Decodes JSON to an Int64.

     - parameter key: Key used in JSON for decoded value.

     - returns: Value decoded from JSON.
     */
    public static func decode(int64ForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> Int64 {
        return {
            json in
            
            if let number = try decodeOptional(int64ForKey: key, keyPathDelimiter:keyPathDelimiter)(json) {
                return number
            }
            
            throw JParseError.missingField(key, json)
        }
    }
    
    public static func decodeOptional(int64ForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> Int64? {
        return {
            json in
            guard let value = json.valueForKeyPath(keyPath: key, withDelimiter: keyPathDelimiter) else {
                return nil
            }
            guard let number = value as? NSNumber else {
                throw JParseError.incorrectType(key, json, NSNumber.self)
            }
            return number.int64Value
        }
    }
    
    /**
     Decodes JSON to an Int64 array.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: Value decoded from JSON.
     */
    public static func decode(int64ArrayForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> [Int64] {
        return {
            json in
            
            if let numbers = try decodeOptional(int64ArrayForKey: key, keyPathDelimiter: keyPathDelimiter)(json) {
                return numbers
            }
            
            throw JParseError.missingField(key, json)
        }
    }
    
    public static func decodeOptional(int64ArrayForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> [Int64]? {
        return {
            json in
            guard let value = json.valueForKeyPath(keyPath: key, withDelimiter: keyPathDelimiter) else {
                return nil
            }
            guard let numbers = value as? [NSNumber] else {
                throw JParseError.incorrectType(key, json, [NSNumber].self)
            }
            return numbers.map { $0.int64Value }
        }
    }

	/**
	Decodes JSON to an UInt64.

	- parameter key: Key used in JSON for decoded value.

	- returns: Value decoded from JSON.
	*/
	public static func decode(uint64ForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> UInt64 {
		return {
			json in

            if let number = try decodeOptional(uint64ForKey: key, keyPathDelimiter:keyPathDelimiter)(json) {
				return number
			}

			throw JParseError.missingField(key, json)
		}
	}
    
    public static func decodeOptional(uint64ForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> UInt64? {
        return {
            json in
            guard let value = json.valueForKeyPath(keyPath: key, withDelimiter: keyPathDelimiter) else {
                return nil
            }
            guard let number = value as? NSNumber else {
                throw JParseError.incorrectType(key, json, NSNumber.self)
            }
            return number.uint64Value
        }
    }

	/**
	Decodes JSON to an UInt64 array.

	- parameter key: Key used in JSON for decoded value.

	- returns: Value decoded from JSON.
	*/
    public static func decode(uint64ArrayForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> [UInt64] {
        return {
            json in
            
            if let numbers = try decodeOptional(uint64ArrayForKey: key, keyPathDelimiter: keyPathDelimiter)(json) {
                return numbers
            }
            
            throw JParseError.missingField(key, json)
        }
    }
    public static func decodeOptional(uint64ArrayForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> [UInt64]? {
        return {
            json in
            guard let value = json.valueForKeyPath(keyPath: key, withDelimiter: keyPathDelimiter) else {
                return nil
            }
            guard let numbers = value as? [NSNumber] else {
                throw JParseError.incorrectType(key, json, [NSNumber].self)
            }
            return numbers.map { $0.uint64Value }
        }
    }

    /**
     Decodes JSON to a URL.

     - parameter key: Key used in JSON for decoded value.

     - returns: Value decoded from JSON.
     */
    public static func decode(urlForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> URL {
        return {
            json in
            
            if let url = try decodeOptional(urlForKey: key, keyPathDelimiter: keyPathDelimiter)(json) {
                return url
            }
            
            throw JParseError.missingField(key, json)
        }
    }
    
    public static func decodeOptional(urlForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> URL? {
        return {
            json in
            guard let value = json.valueForKeyPath(keyPath: key, withDelimiter: keyPathDelimiter) else {
                return nil
            }
            guard let string = value as? String else {
                throw JParseError.incorrectType(key, json, String.self)
            }
            guard let url = URL(string:string) else {
                throw JParseError.badValue(key, json)
            }
            return url
        }
    }
    
    /**
     Decodes JSON to a URL array.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: Value decoded from JSON.
     */
    public static func decode(urlArrayForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> [URL] {
        return {
            json in
            
            if let urls = try decodeOptional(urlArrayForKey: key, keyPathDelimiter: keyPathDelimiter)(json) {
                return urls
            }
            
            throw JParseError.missingField(key, json)
        }
    }
    
    public static func decodeOptional(urlArrayForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> [URL]? {
        return {
            json in
            guard let value = json.valueForKeyPath(keyPath: key, withDelimiter: keyPathDelimiter) else {
                return nil
            }
            guard let strings = value as? [String] else {
                throw JParseError.incorrectType(key, json, [String].self)
            }
            var urls: [URL] = []
            
            for urlString in strings {
                guard let url = URL(string: urlString) else {
                    throw JParseError.badValue(key, json)
                }
                
                urls.append(url)
            }
            
            return urls
        }
    }
    
    /**
     Decodes JSON to a UUID.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: Value decoded from JSON.
     */
    public static func decode(uuidForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> UUID {
        return {
            json in
            
            if let uuid = try decodeOptional(uuidForKey: key, keyPathDelimiter: keyPathDelimiter)(json) {
                return uuid
            }
            
            throw JParseError.missingField(key, json)
        }
    }
    
    public static func decodeOptional(uuidForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> UUID? {
        return {
            json in
            guard let value = json.valueForKeyPath(keyPath: key, withDelimiter: keyPathDelimiter) else {
                return nil
            }
            guard let string = value as? String else {
                throw JParseError.incorrectType(key, json, String.self)
            }
            guard let uuid = UUID(uuidString:string) else {
                throw JParseError.badValue(key, json)
            }
            return uuid
        }
    }
    
    /**
     Decodes JSON to a UUID array.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: Value decoded from JSON.
     */
    public static func decode(uuidArrayForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> [UUID] {
        return {
            json in
            
            if let urls = try decodeOptional(uuidArrayForKey: key, keyPathDelimiter: keyPathDelimiter)(json) {
                return urls
            }
            
            throw JParseError.missingField(key, json)
        }
    }
    public static func decodeOptional(uuidArrayForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> [UUID]? {
        return {
            json in
            guard let value = json.valueForKeyPath(keyPath: key, withDelimiter: keyPathDelimiter) else {
                return nil
            }
            guard let strings = value as? [String] else {
                throw JParseError.incorrectType(key, json, [String].self)
            }
            var urls: [UUID] = []
            
            for urlString in strings {
                guard let url = UUID(uuidString: urlString) else {
                    throw JParseError.badValue(key, json)
                }
                
                urls.append(url)
            }
            
            return urls
        }
    }
    
    /**
     Decodes JSON to a Decimal.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: Value decoded from JSON.
     */
    public static func decode(decimalForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> Decimal {
        return {
            json in
            
            if let number = try decodeOptional(decimalForKey: key, keyPathDelimiter:keyPathDelimiter)(json) {
                return number
            }
            
            throw JParseError.missingField(key, json)
        }
    }
    
    public static func decodeOptional(decimalForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> Decimal? {
        return {
            json in
            guard let value = json.valueForKeyPath(keyPath: key, withDelimiter: keyPathDelimiter) else {
                return nil
            }
            guard let number = value as? NSNumber else {
                throw JParseError.incorrectType(key, json, NSNumber.self)
            }
            return number.decimalValue
        }
    }
    
    /**
     Decodes JSON to a Decimal array.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: Value decoded from JSON.
     */
    public static func decode(decimalArrayForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> [Decimal] {
        return {
            json in
            
            if let numbers = try decodeOptional(decimalArrayForKey: key, keyPathDelimiter: keyPathDelimiter)(json) {
                return numbers
            }
            
            throw JParseError.missingField(key, json)
        }
    }
    public static func decodeOptional(decimalArrayForKey key: String, keyPathDelimiter: String = GlossKeyPathDelimiter) -> (JSON) throws -> [Decimal]? {
        return {
            json in
            guard let value = json.valueForKeyPath(keyPath: key, withDelimiter: keyPathDelimiter) else {
                return nil
            }
            guard let numbers = value as? [NSNumber] else {
                throw JParseError.incorrectType(key, json, [NSNumber].self)
            }
            return numbers.map { $0.decimalValue }
        }
    }
    
}

