//
//  Operatorsg.swift
//  g
//
//  Created by Zaid Daghestani on 1/20/17.
//  Copyright © 2017 Harlan Kellaway. All rights reserved.
//

import Foundation

precedencegroup DecodingPrecedence {
    associativity: left
    higherThan: CastingPrecedence
}

infix operator <~~ : DecodingPrecedence
infix operator ?~~ : DecodingPrecedence

public func <~~ <T>(key:String, json:JSON) throws -> T {
    return try Decoder.decode(key: key)(json)
}

public func ?~~ <T>(key:String, json:JSON) throws -> T? {
    return try Decoder.decodeOptional(key: key)(json)
}

public func <~~ <T:Decodable>(key:String, json:JSON) throws -> T {
    return try Decoder.decode(decodableForKey: key)(json)
}

public func ?~~ <T:Decodable>(key:String, json:JSON) throws -> T? {
    return try Decoder.decodeOptional(decodableForKey: key)(json)
}

public func <~~ <T:Decodable>(key:String, json:JSON) throws -> [T] {
    return try Decoder.decode(decodableArrayForKey:key)(json)
}

public func ?~~ <T:Decodable>(key:String, json:JSON) throws -> [T]? {
    return try Decoder.decodeOptional(decodableArrayForKey:key)(json)
}

public func <~~ <T: RawRepresentable>(key: String, json: JSON) throws -> T {
    return try Decoder.decode(enumForKey: key)(json)
}

public func ?~~ <T: RawRepresentable>(key: String, json: JSON) throws -> T? {
    return try Decoder.decodeOptional(enumForKey: key)(json)
}

public func <~~ <T: RawRepresentable>(key: String, json: JSON) throws -> [T] {
    return try Decoder.decode(enumArrayForKey: key)(json)
}

public func ?~~ <T: RawRepresentable>(key: String, json: JSON) throws -> [T]? {
    return try Decoder.decodeOptional(enumArrayForKey: key)(json)
}

public func <~~ (key: String, json: JSON) throws -> Int32 {
    return try Decoder.decode(int32ForKey: key)(json)
}

public func ?~~ (key: String, json: JSON) throws -> Int32? {
    return try Decoder.decodeOptional(int32ForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to Int32 array.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ (key: String, json: JSON) throws -> [Int32] {
    return try Decoder.decode(int32ArrayForKey: key)(json)
}

public func ?~~ (key: String, json: JSON) throws -> [Int32]? {
    return try Decoder.decodeOptional(int32ArrayForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to UInt32.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ (key: String, json: JSON) throws -> UInt32 {
    return try Decoder.decode(uint32ForKey: key)(json)
}

public func ?~~ (key: String, json: JSON) throws -> UInt32? {
    return try Decoder.decodeOptional(uint32ForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to UInt32 array.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ (key: String, json: JSON) throws -> [UInt32] {
    return try Decoder.decode(uint32ArrayForKey: key)(json)
}
public func ?~~ (key: String, json: JSON) throws -> [UInt32]? {
    return try Decoder.decodeOptional(uint32ArrayForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to Int64.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ (key: String, json: JSON) throws -> Int64 {
    return try Decoder.decode(int64ForKey: key)(json)
}

public func ?~~ (key: String, json: JSON) throws -> Int64? {
    return try Decoder.decodeOptional(int64ForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to Int64 array.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ (key: String, json: JSON) throws -> [Int64] {
    return try Decoder.decode(int64ArrayForKey: key)(json)
}
public func ?~~ (key: String, json: JSON) throws -> [Int64]? {
    return try Decoder.decodeOptional(int64ArrayForKey: key)(json)
}


/**
 Convenience operator for decoding JSON to UInt64.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ (key: String, json: JSON) throws -> UInt64 {
    return try Decoder.decode(uint64ForKey: key)(json)
}
public func ?~~ (key: String, json: JSON) throws -> UInt64? {
    return try Decoder.decodeOptional(uint64ForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to UInt64 array.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ (key: String, json: JSON) throws -> [UInt64] {
    return try Decoder.decode(uint64ArrayForKey: key)(json)
}
public func ?~~ (key: String, json: JSON) throws -> [UInt64]? {
    return try Decoder.decodeOptional(uint64ArrayForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to URL.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ (key: String, json: JSON) throws -> URL {
    return try Decoder.decode(urlForKey: key)(json)
}

public func ?~~ (key: String, json: JSON) throws -> URL? {
    return try Decoder.decodeOptional(urlForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to array of URLs.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ (key: String, json: JSON) throws -> [URL] {
    return try Decoder.decode(urlArrayForKey: key)(json)
}
public func ?~~ (key: String, json: JSON) throws -> [URL]? {
    return try Decoder.decodeOptional(urlArrayForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to UUID.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ (key: String, json: JSON) throws -> UUID {
    return try Decoder.decode(uuidForKey: key)(json)
}
public func ?~~ (key: String, json: JSON) throws -> UUID? {
    return try Decoder.decodeOptional(uuidForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to array of UUIDs.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ (key: String, json: JSON) throws -> [UUID] {
    return try Decoder.decode(uuidArrayForKey: key)(json)
}
public func ?~~ (key: String, json: JSON) throws -> [UUID]? {
    return try Decoder.decodeOptional(uuidArrayForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to Decimal.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ (key: String, json: JSON) throws -> Decimal {
    return try Decoder.decode(decimalForKey: key)(json)
}
public func ?~~ (key: String, json: JSON) throws -> Decimal? {
    return try Decoder.decodeOptional(decimalForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to Decimal array.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ (key: String, json: JSON) throws -> [Decimal] {
    return try Decoder.decode(decimalArrayForKey: key)(json)
}
public func ?~~ (key: String, json: JSON) throws -> [Decimal]? {
    return try Decoder.decodeOptional(decimalArrayForKey: key)(json)
}

// MARK: - Operator ~~> (Encode)

precedencegroup EncodingPrecedence {
    associativity: left
    higherThan: CastingPrecedence
}

/**
 Encode custom operator.
 */
infix operator ~~> : EncodingPrecedence
infix operator ~~? : EncodingPrecedence

/**
 Convenience operator for encoding generic value to JSON
 */

/**
 Convenience operator for encoding a generic value to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> <T>(key: String, property: T) -> JSON {
    return Encoder.encode(key: key)(property)
}

public func ~~? <T>(key: String, property: T?) -> JSON? {
    return Encoder.encodeOptional(key: key)(property)
}

/**
 Convenience operator for encoding an array of generic values to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> <T>(key: String, property: [T]) -> JSON {
    return Encoder.encode(arrayForKey: key)(property)
}
public func ~~? <T>(key: String, property: [T]?) -> JSON? {
    return Encoder.encodeOptional(arrayForKey: key)(property)
}

/**
 Convenience operator for encoding an Encodable object to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> <T: Encodable>(key: String, property: T) -> JSON {
    return Encoder.encode(encodableForKey: key)(property)
}
public func ~~? <T: Encodable>(key: String, property: T?) -> JSON? {
    return Encoder.encodeOptional(encodableForKey: key)(property)
}

/**
 Convenience operator for encoding an array of Encodable objects to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> <T: Encodable>(key: String, property: [T]) -> JSON {
    return Encoder.encode(encodableArrayForKey: key)(property)
}
public func ~~? <T: Encodable>(key: String, property: [T]?) -> JSON? {
    return Encoder.encodeOptional(encodableArrayForKey: key)(property)
}

/**
 Convenience operator for encoding a dictionary of String to Encodable to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> <T: Encodable>(key: String, property: [String : T]) -> JSON {
    return Encoder.encode(encodableDictionaryForKey: key)(property)
}
public func ~~? <T: Encodable>(key: String, property: [String : T]?) -> JSON? {
    return Encoder.encodeOptional(encodableDictionaryForKey: key)(property)
}

/**
 Convenience operator for encoding a dictionary of String to Encodable array to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> <T: Encodable>(key: String, property: [String : [T]]) -> JSON {
    return Encoder.encode(encodableDictionaryForKey: key)(property)
}
public func ~~? <T: Encodable>(key: String, property: [String : [T]]?) -> JSON? {
    return Encoder.encodeOptional(encodableDictionaryForKey: key)(property)
}

/**
 Convenience operator for encoding an enum value to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> <T: RawRepresentable>(key: String, property: T) -> JSON {
    return Encoder.encode(enumForKey: key)(property)
}
public func ~~? <T: RawRepresentable>(key: String, property: T?) -> JSON? {
    return Encoder.encodeOptional(enumForKey: key)(property)
}

/**
 Convenience operator for encoding an array of enum values to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> <T: RawRepresentable>(key: String, property: [T]) -> JSON {
    return Encoder.encode(enumArrayForKey: key)(property)
}
public func ~~? <T: RawRepresentable>(key: String, property: [T]?) -> JSON? {
    return Encoder.encodeOptional(enumArrayForKey: key)(property)
}

/**
 Convenience operator for encoding an Int32 to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> (key: String, property: Int32) -> JSON {
    return Encoder.encode(int32ForKey: key)(property)
}
public func ~~? (key: String, property: Int32?) -> JSON? {
    return Encoder.encodeOptional(int32ForKey: key)(property)
}

/**
 Convenience operator for encoding an Int32 array to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> (key: String, property: [Int32]) -> JSON {
    return Encoder.encode(int32ArrayForKey: key)(property)
}
public func ~~? (key: String, property: [Int32]?) -> JSON? {
    return Encoder.encodeOptional(int32ArrayForKey: key)(property)
}

/**
 Convenience operator for encoding an UInt32 to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> (key: String, property: UInt32) -> JSON {
    return Encoder.encode(uint32ForKey: key)(property)
}
public func ~~? (key: String, property: UInt32?) -> JSON? {
    return Encoder.encodeOptional(uint32ForKey: key)(property)
}

/**
 Convenience operator for encoding an UInt32 array to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> (key: String, property: [UInt32]) -> JSON {
    return Encoder.encode(uint32ArrayForKey: key)(property)
}
public func ~~? (key: String, property: [UInt32]?) -> JSON? {
    return Encoder.encodeOptional(uint32ArrayForKey: key)(property)
}

/**
 Convenience operator for encoding an Int64 to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> (key: String, property: Int64) -> JSON {
    return Encoder.encode(int64ForKey: key)(property)
}
public func ~~? (key: String, property: Int64?) -> JSON? {
    return Encoder.encodeOptional(int64ForKey: key)(property)
}

/**
 Convenience operator for encoding an Int64 array to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> (key: String, property: [Int64]) -> JSON {
    return Encoder.encode(int64ArrayForKey: key)(property)
}
public func ~~? (key: String, property: [Int64]?) -> JSON? {
    return Encoder.encodeOptional(int64ArrayForKey: key)(property)
}

/**
 Convenience operator for encoding an UInt64 to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> (key: String, property: UInt64) -> JSON {
    return Encoder.encode(uint64ForKey: key)(property)
}
public func ~~? (key: String, property: UInt64?) -> JSON? {
    return Encoder.encodeOptional(uint64ForKey: key)(property)
}

/**
 Convenience operator for encoding an UInt64 array to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> (key: String, property: [UInt64]) -> JSON {
    return Encoder.encode(uint64ArrayForKey: key)(property)
}
public func ~~? (key: String, property: [UInt64]?) -> JSON? {
    return Encoder.encodeOptional(uint64ArrayForKey: key)(property)
}

/**
 Convenience operator for encoding a URL to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> (key: String, property: URL) -> JSON {
    return Encoder.encode(urlForKey: key)(property)
}
public func ~~? (key: String, property: URL?) -> JSON? {
    return Encoder.encodeOptional(urlForKey: key)(property)
}

/**
 Convenience operator for encoding a UUID to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> (key: String, property: UUID) -> JSON {
    return Encoder.encode(uuidForKey: key)(property)
}
public func ~~? (key: String, property: UUID?) -> JSON? {
    return Encoder.encodeOptional(uuidForKey: key)(property)
}

/**
 Convenience operator for encoding a Decimal to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> (key: String, property: Decimal) -> JSON {
    return Encoder.encode(decimalForKey: key)(property)
}
public func ~~? (key: String, property: Decimal?) -> JSON? {
    return Encoder.encodeOptional(decimalForKey: key)(property)
}

/**
 Convenience operator for encoding a Decimal array to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> (key: String, property: [Decimal]) -> JSON {
    return Encoder.encode(decimalArrayForKey: key)(property)
}
public func ~~? (key: String, property: [Decimal]?) -> JSON? {
    return Encoder.encodeOptional(decimalArrayForKey: key)(property)
}
