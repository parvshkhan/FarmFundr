//
//  ApiSellToUsIncomming.swift
//  FarmFundr
//
//  Created by Anupriya on 26/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import Foundation
struct ApiSellToUsIncomming {
    var sellDetails : [SellDetail] = []
    struct SellDetail {
        public var id : Int?
        public var title : String?
        public var description : String?
        init(dictionary: NSDictionary) {
            id = dictionary["id"] as? Int
            title = dictionary["title"] as? String
            description = dictionary["description"] as? String
        }
    }
    
    init(response : AnyObject) {
        if let someObject = response["payLoad"] as? [Any]{
            for object in someObject{
                let tempObject = SellDetail(dictionary: object as! NSDictionary)
                sellDetails.append(tempObject)
            }
        }
    }
}
