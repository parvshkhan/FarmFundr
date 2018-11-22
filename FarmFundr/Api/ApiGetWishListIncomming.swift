//
//  ApiGetWishListIncomming.swift
//  FarmFundr
//
//  Created by Anupriya on 17/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import Foundation
struct ApigetWishListIncomming {
    var wishListItems : [WishListItem] = []
    struct WishListItem {
        public var id : Int?
        public var wishlistId : Int?
        public var name : String?
        public var owner : String?
        public var total_fund : Double?
        public var target : String?
        public var roi : Double?
        public var ownerImg : String?
        public var galleryImg : String?
        public var total_share : Int?
//        var gallryImgURl : URL{
//            if galleryImg != nil{
//                let absoluteStr = galleryImg.tr
//                
//            }
//            
//        }
//        var imgUrl : URL{
//            return URL.init(string: galleryImg ?? "http://smartit.ventures/farm/Agricultural_project/public/PropertyThumbnail/1537528049$_59 (9).JPG")!
//             //return URL(string : galleryImg!)!
////            if galleryImg != "" {
////                return URL(string: galleryImg!)!
////            }
////          return URL(string: "http://smartit.ventures/farm/Agricultural_project/public/PropertyThumbnail/1537528049$_59 (9).JPG")!
//        }
        public var funded : Int?
        public var total : Int?
        public var address : String?
        public var diffDate : Int?
        init(dictionary : NSDictionary) {
            id = dictionary["id"] as? Int
            wishlistId = dictionary["wishlistId"] as? Int
            name = dictionary["name"] as? String
            owner = dictionary["owner"] as? String
            total_fund = dictionary["total_fund"] as? Double
            target = dictionary["target"] as? String
            roi = dictionary["roi"] as? Double
            ownerImg = dictionary["ownerImg"] as? String
            galleryImg = dictionary["galleryImg"] as? String
            funded = dictionary["funded"] as? Int
            total = dictionary["total"] as? Int
            address = dictionary["address"] as? String
            diffDate = dictionary["diffDate"] as? Int
            total_share = dictionary["total_share"] as? Int
        }
    }
  
    init(response : AnyObject) {
        if let objects = response["payLoad"] as? [Any]{
            for object in objects{
                let tempObject = WishListItem(dictionary: object as! NSDictionary)
             wishListItems.append(tempObject)
            }
        }
    }
}
