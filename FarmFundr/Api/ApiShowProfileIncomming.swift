//
//  ApiShowProfileIncomming.swift
//  FarmFundr
//
//  Created by Anupriya on 18/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import Foundation
struct ApiShowProfileIncomming {
    var profileDetail : ProfileDetail?
    struct ProfileDetail {
        var email : String?
        var first_name : String?
        var id : Int?
        var image : String?
        var imgUrl : URL{
                return URL(string: image!) ?? URL(string: "http://192.168.0.40/Agricultural_project/public/ownerThumbnail/1538051575expert-1.png")!
        }
        var last_name : String?
        var mobile : String?
        init(dictionary : NSDictionary) {
            email = dictionary["email"] as? String
            first_name = dictionary["first_name"] as? String
            id = dictionary["first_name"] as? Int
            image = dictionary["image"] as? String
            last_name = dictionary["last_name"] as? String
            mobile = dictionary["mobile"] as? String
        }
    }
    init(dictionary : NSDictionary) {
        if let user = dictionary["payLoad"] as? NSDictionary{
           profileDetail = ProfileDetail(dictionary: user)
        }
    }    
}
