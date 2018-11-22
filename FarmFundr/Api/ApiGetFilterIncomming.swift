//
//  ApiGetFilterIncomming.swift
//  FarmFundr
//
//  Created by Anupriya on 16/11/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import Foundation
struct ApiGetFilterDataIncomming {
    var filterData : FilterData?
    struct FilterData {
        var contries : [CountryData] = []
         var addresses : [AddressData] = []
        struct CountryData {
            var id : Int?
            var name : String?
            init(dictionary : NSDictionary) {
                id = dictionary["id"] as? Int
                name = dictionary["name"] as? String
            }
        }
        struct AddressData {
            var id : Int?
            var address : String?
            init(dictionary : NSDictionary) {
                id = dictionary["id"] as? Int
                address = dictionary["address"] as? String
            }
        }
        init(response : AnyObject) {
            if let someContry = response["country"] as? [Any]{
                for contry in someContry{
                    let tempContry = CountryData(dictionary: contry as! NSDictionary)
                    contries.append(tempContry)
                }
           }
            if let someAddress = response["address"] as? [Any]{
                for address in someAddress{
                    let tempAdd = AddressData(dictionary: address as! NSDictionary)
                    addresses.append(tempAdd)
                }
            }
        }
    }
    init(response : NSDictionary) {
        if let someObject = response["payLoad"] as? NSDictionary{
            filterData = FilterData(response: someObject)
        }
    }
}

