//
//  TestKeyPathModel.swift
//  GlossExample
//
//  Created by Maciej Kołek on 10/18/16.
//  Copyright © 2016 Harlan Kellaway. All rights reserved.
//

import Foundation
import J

struct TestKeyPathModel: JsonModel {
    
    let id: Int
    let name: String
    let url: URL
    
    init(json: JSON) throws {
        self.id = try "id" <~~ json
        self.name = try "args.name" <~~ json
        self.url = try "args.url" <~~ json
    }
    
    func toJSON() -> JSON {
        return jsonify([
            self.id  ~~> "id",
            self.name ~~> "args.name",
            self.url ~~> "args.url"
            ])
    }
    
}

