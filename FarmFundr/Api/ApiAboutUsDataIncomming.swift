//
//  ApiAboutUsDataIncomming.swift
//  FarmFundr
//
//  Created by Anupriya on 26/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import Foundation
struct ApiAboutUsDataIncomming{
    var aboutUs : AboutUSDetail?
    struct AboutUSDetail{
        var id : Int?
        var description : String?
        var image : String?
        var imgURL : URL{
            return URL(string: image!) ?? URL(string: "http://smartit.ventures/farm/Agricultural_project/public/About/1.6153029254329E+15about_img.png")!
        }
        
        init(dictionary : NSDictionary) {
            id = dictionary["id"] as? Int
            description = dictionary["description"] as? String
            image = dictionary["image"] as? String
        }
    }
    
    init(response : NSDictionary) {
        if let someData = response["payload"] as? NSDictionary{
            aboutUs = AboutUSDetail(dictionary: someData)
        }
    }
}
