//
//  ExtensionArray.swift
//  Gloss
//
// Copyright (c) 2016 Rahul Katariya
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

// MARK: - Decodable

public extension Array where Element: Decodable {
    
    // MARK: Public functions
    
    /**
     Returns array of new objects created from provided JSON array.
     If any decodings fail, nil is returned.
     
     - parameter jsonArray: Array of JSON representations of objects.
     
     - returns: Array of objects created from JSON.
     */
    static func from(jsonArray: [JSON]) throws -> [Element] {
        var models: [Element] = []
        
        for json in jsonArray {
            let model = try Element(json: json)
            models.append(model)
        }
        
        return models
    }
    
    /**
     Initializes array of model objects from provided data.
     
     - parameter data: Raw JSON array data.
     
     - returns: Array with model objects when decoding is successful, empty otherwise.
     */
    
    /**
     Returns array of new objects created from provided data.
     If creation of JSON or any decodings fail, nil is returned.
     
     - parameter data:       Raw JSON data.
     - parameter serializer: Serializer to use when creating JSON from data.
     - parameter ooptions:   Options for reading the JSON data.
     
     - returns: Object or nil.
     */
    static func from(data: Data, serializer: JSONSerializer = JJSONSerializer(), options: JSONSerialization.ReadingOptions = .mutableContainers) throws -> [Element] {
        let jsonValues = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        guard let jsonArray = jsonValues as? [JSON] else {
            throw JParseError.incorrectType("", jsonValues, [JSON].self)
        }
            
        let models = try [Element].from(jsonArray: jsonArray)
        
        return models
    }
    
}

// MARK: - Encodable

public extension Array where Element: Encodable {
    
    // MARK: Public functions
    
    /**
     Encodes array of objects as JSON array.
     If any encodings fail, nil is returned.
     
     - returns: Array of JSON created from objects.
     */
    func toJSONArray() -> [JSON] {
        var jsonArray: [JSON] = []
        
        for json in self {
            jsonArray.append(json.toJSON())
        }
        
        return jsonArray
    }
}

