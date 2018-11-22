//
//  ApiGetPropertyListIncomming.swift
//  FarmFundr
//
//  Created by Anupriya on 29/09/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//
/*{
 "id": 4,
 "name": "Amazing recreational agricultural property",
 "owner": "Farah",
 "total_fund": 540000,
 "roi": 8,
 "address": "Ropar Tornto Ontario 123 Canada",
 "ownerImg": "http://192.168.0.40/Agricultural_project/public/ownerThumbnail/1537527975tm1.jpg",
 "galleryImg": "http://192.168.0.40/Agricultural_project/public/PropertyThumbnail/1537533068$_59 (5).JPG",
 "diffDate": 30,
 "funded": 0
 }*/
import Foundation
struct ApiGetPropertyListIncomming {
    var propertyDetails : [PropertyDetail] = []
    struct PropertyDetail {
        public var id : Int?
        public var name : String?
        public var owner : String?
        public var total_fund : Double?
        public var roi : Double?
        public var address : String?
        public var target : String?
        public var ownerImg : String?
        public var wishlistId : Int?
        public var total_share : Int?
        var ownerPicUrl : URL{
                return URL(string: ownerImg!) ?? URL(string: "http://192.168.0.40/Agricultural_project/public/ownerThumbnail/1538051575expert-1.png")!
        }
       public var galleryImg : String?
        var galleryPicUrl : URL{
            let absoluteUrl : String?
            if galleryImg != nil{
             
            absoluteUrl = galleryImg?.trimmingCharacters(in: .whitespacesAndNewlines)
                  return URL(string: absoluteUrl!) ?? URL(string: "http://192.168.0.40/Agricultural_project/public/PropertyThumbnail/1538051576Agricultural-Land.jpg")!
            }
          return URL(string: "http://192.168.0.40/Agricultural_project/public/PropertyThumbnail/1538051576Agricultural-Land.jpg")!
        }
        public var diffDate : Int?
        public var funded : Int?
        init(dictionary : NSDictionary) {
            id = dictionary["id"] as? Int
            name = dictionary["name"] as? String
            owner = dictionary["owner"] as? String
            total_fund = dictionary["total_fund"] as? Double
            roi = dictionary["roi"] as? Double
            address = dictionary["address"] as? String
            target = dictionary["target"] as? String
            ownerImg = dictionary["ownerImg"] as? String
            galleryImg = dictionary["galleryImg"] as? String
            diffDate = dictionary["diffDate"] as? Int
            funded = dictionary["funded"] as? Int
            wishlistId = dictionary["wishlistId"] as? Int
            total_share = dictionary["total_share"] as? Int
        }
    }
    
    init(response : AnyObject) {
        if let someObject = response["payLoad"] as? [Any]{
            for object in someObject{
                let tempPropertyList = PropertyDetail(dictionary: object as! NSDictionary)
                propertyDetails.append(tempPropertyList)
            }
        }
    }
}
