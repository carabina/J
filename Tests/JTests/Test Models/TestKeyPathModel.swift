//
//  TestKeyPathModel.swift
//  GlossExample
//
//  Created by Maciej Kołek on 10/18/16.
//  Copyright © 2016 Harlan Kellaway. All rights reserved.
//

import Foundation
import J

struct TestKeyPathModel: JModel {
    
    let id: Int
    let name: String
    let url: URL
    
    init(json: JSON) throws {
        self.id = "id" <~~ json
        self.name = "args.name" <~~ json
        self.url = "args.url" <~~ json
    }
    
    func toJSON() -> JSON {
        return jsonify([
            "id" ~~> self.id,
            "args.name" ~~> self.name,
            "args.url" ~~> self.url
            ])
    }
    
}

