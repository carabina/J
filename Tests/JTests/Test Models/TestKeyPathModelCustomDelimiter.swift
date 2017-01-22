//
//  TestKeyPathModelCustomDelimiter.swift
//  GlossExample
//
//  Created by Maciej Kołek on 10/18/16.
//  Copyright © 2016 Harlan Kellaway. All rights reserved.
//

import Foundation
import J

struct TestKeyPathModelCustomDelimiter: JsonModel {
    
    let id: Int?
    let url: URL?
    
    init(json:JSON) throws {
        self.id = try Decoder.decode(key: "nested*id", keyPathDelimiter: "*")(json)
        self.url = try Decoder.decode(urlForKey: "nested*url", keyPathDelimiter: "*")(json)
    }
    
    func toJSON() -> JSON {
        return jsonify([
            self.id ~~> "nested*id",
            self.url ~~> "nested*url"
            ], keyPathDelimiter: "*")
    }
    
}
