//
//  ApiInvestmentPlansDetailsIncomming.swift
//  FarmFundr
//
//  Created by Anupriya on 22/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import Foundation
struct ApiInvestmentPlanDetailsIncomming {
    var planDetail : PlanDetail?
    struct PlanDetail {
        var id : Int?
        var title : String?
        var description : String?
        init(dictionary : NSDictionary) {
            id = dictionary["id"] as? Int
            title = dictionary["title"] as? String
            description = dictionary["description"] as? String
        }
    }
    init(response : NSDictionary) {
        if let someResponse = response["payload"] as? NSDictionary{
           planDetail = PlanDetail(dictionary: someResponse)
        }
    }
}
