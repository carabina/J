//
//  TestNestedKeyPathModel.swift
//  Gloss
//
//  Created by Maciej Kołek on 10/18/16.
//  Copyright © 2016 Harlan Kellaway. All rights reserved.
//

import Foundation
import J

struct TestNestedKeyPathModel: JsonModel {
    
    let keyPathModel: TestKeyPathModel?
    let flag: Bool
    
    init(json: JSON) throws {
        self.keyPathModel = try "keyPath" <~~ json
        self.flag = try "keyPath.args.flag" <~~ json ?? false
    }
    
    func toJSON() -> JSON {
        return jsonify([
            "keyPath" ~~> self.keyPathModel,
            "keyPath.args.flag" ~~> self.flag
            ])
    }
    
}
