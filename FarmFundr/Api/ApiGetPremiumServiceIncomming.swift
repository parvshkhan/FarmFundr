//
//  ApiGetPremiumServiceIncomming.swift
//  FarmFundr
//
//  Created by Anupriya on 26/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import Foundation
struct ApiGetPremiumServiceIncomming {
    var premiumDetails : [PremiumDetail] = []
    struct PremiumDetail {
        public var id : Int?
        public var question : String?
        public var answer : String?
     init(dictionary: NSDictionary) {
            id = dictionary["id"] as? Int
            question = dictionary["question"] as? String
            answer = dictionary["answer"] as? String
        }
    }
   
    init(response : AnyObject) {
        if let someObject = response["payload"] as? [Any]{
            for object in someObject{
                let tempObject = PremiumDetail(dictionary: object as! NSDictionary)
                premiumDetails.append(tempObject)
            }
        }
    }
}
