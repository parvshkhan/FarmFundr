//
//  ApiGetHowItWorksIncomming.swift
//  FarmFundr
//
//  Created by Anupriya on 29/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import Foundation
struct ApiGetHowItWorksIncomming {
    var workDetails : [WorkDetail] = []
    struct WorkDetail {
        var id : Int?
        var title : String?
        var description : String?
        var image : String?
        var imgUrl : URL{
            return URL(string: image!) ?? URL(string: "http://smartit.ventures/farm/Agricultural_project/public/HowitWorks/1.6153020278347E+15$_59(k).JPG")!
        }
        init(dictionary : NSDictionary) {
        id = dictionary["id"] as? Int
        title = dictionary["title"] as? String
        description = dictionary["description"] as? String
        image = dictionary["image"] as? String
        }
    }
    init(response : AnyObject) {
        if let someWork = response["payLoad"] as? [Any]{
            for work in someWork{
                let tempWork = WorkDetail(dictionary: work as! NSDictionary)
               workDetails.append(tempWork)
            }
        }
    }
}
