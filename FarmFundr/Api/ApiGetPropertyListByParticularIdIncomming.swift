//
//  ApiGetPropertyListByParticularIdIncomming.swift
//  FarmFundr
//
//  Created by Anupriya on 03/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import Foundation
import UIKit
struct ApiGetPropertyListByParticularIdIncomming {
    var propertyDetails : PropertyDetail?
    struct PropertyDetail {
        public var id : Int?
        public var name : String?
        public var owner : String?
        public var total_fund : Int?
        public var target : String?
        public var roi : Double?
        public var investment_care : String?
        public var farm_detail : String?
        public var address : String?
        public var ownerImg : String?
        public var galleryImg :[String]?
        public var document_file : [String]?
        public var document_file_name : [String]?
        public var total : Int?
        public var funded : Int?
        public var diffDate : Int?
        public var wishlistId : Int?
        public var total_share : Int?
        public var chartDatas : [ChartData] = []
        //MARK:- ChartModel
        struct ChartData {
            public var label : Int?
            var lblString : String{
                if label != nil{
                    return String(label!)
                }
              return "NG"
            }
            public var y : Double?
            var yVal : CGFloat{
                if y != nil{
                    return CGFloat(y!)
                }
                return 0.0
            }
            init(dictionary : NSDictionary) {
                label = dictionary["label"] as? Int
                y = dictionary["y"] as? Double
            }
        }
        init(dictionary : NSDictionary) {
            id = dictionary["id"] as? Int
            name = dictionary["name"] as? String
            owner = dictionary["owner"] as? String
            total_fund = dictionary["total_fund"] as? Int
            wishlistId = dictionary["wishlistId"] as? Int
            target = dictionary["target"] as? String
            roi = dictionary["roi"] as? Double
            investment_care = dictionary["investment_care"] as? String
            farm_detail = dictionary["farm_detail"] as? String
            address = dictionary["address"] as? String
            ownerImg = dictionary["ownerImg"] as? String
            if dictionary["galleryImg"] != nil{
                galleryImg = dictionary["galleryImg"] as? [String]
            }
            if dictionary["document_file"] != nil {
                document_file = dictionary["document_file"] as? [String]
            }
            if dictionary["document_file_name"] != nil{
                document_file_name = dictionary["document_file_name"] as? [String]
            }
            total = dictionary["total"] as? Int
            funded = dictionary["funded"] as? Int
            diffDate = dictionary["diffDate"] as? Int
            total_share = dictionary["total_share"] as? Int
            if let someChartData = dictionary["chart"] as? [Any]{
                for chartData in someChartData{
                    let tempchartData = ChartData(dictionary: chartData as! NSDictionary)
                    chartDatas.append(tempchartData)
                }
            }
        }
    }
    init(response : [String : Any]) {
        if let someResponse = response["payLoad"] as? [String : Any]{
            propertyDetails = PropertyDetail(dictionary: someResponse as NSDictionary)
        }
    }
    
}
