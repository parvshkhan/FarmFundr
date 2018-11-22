//
//  ApiGetUserInfoIncomming.swift
//  FarmFundr
//
//  Created by Anupriya on 02/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//
/*payLoad =     {
    email = "anuiOS@gmail.com";
    "first_name" = Anupriya;
    id = 11;
    image = "http://192.168.0.40/Agricultural_project/public/profile/";
    "last_name" = "<null>";
    mobile = 0;
} */
import Foundation
struct ApiGetUserInfoIncomming {
    var userDetails : UserDetails?
    struct UserDetails {
        var email : String?
        var firstName : String? // first_name
        var id : Int?
        var image : String?
        var imgUrl : URL{
                return URL(string: image!) ?? URL(string: "http://smartit.ventures/farm/Agricultural_project/public/ownerThumbnail/15399382391537528688expert-4.png")!
        }
        var lastName : String?
        var mobile : String?
        init(dictionary : NSDictionary) {
            email = dictionary["email"] as? String
            firstName = dictionary["first_name"] as? String
            id = dictionary["id"] as? Int
            lastName = dictionary["last_name"] as? String
            mobile = dictionary["mobile"] as? String
            image = dictionary["image"] as? String
        }
    }
        init(response : [String : Any]) {
            if let someData = response["payLoad"] as? [String : Any]{
                userDetails = UserDetails(dictionary: someData as NSDictionary)
            }
        }
  
}
