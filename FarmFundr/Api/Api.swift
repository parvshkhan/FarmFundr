//
//  Api.swift
//  FarmFundr
//
//  Created by Anupriya on 29/09/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import Foundation
let myNotificationKey = "updateProfileNotification"
enum Api{
    case signUp
    case signIn
    case getAllPropertyList
    case forgetPassword
    case getProfile
    case updateProfile
    case matchOtp
    case resetPassword
    case getPropertyListIndividualId
    case getBlogsList
    case getBlogByparticularId
    case getEventList
    case getEventDetailByParticularId
    case addOrRemoveWishList
    case getWishList
    case getInvestmentPlans
    case getContents
    case getContact
    case logOut
    case investmentPlansByParticularId
    case getAboutUs
    case getPremiumServices
    case getselltoUs
    case getHowItWorks
    case getChat
    case postChat
    case getFilter
    case applyFilter
    // live = baseroot = http://smartit.ventures/farm/Agricultural_project/public/api/
   
    var url : URL{
        switch self {
        case .signUp:
            return URL(string:"http://smartit.ventures/farm/Agricultural_project/public/api/signup")!
        case .signIn:
            return URL(string: "http://smartit.ventures/farm/Agricultural_project/public/api/signin")!
        case .getAllPropertyList:
            return URL(string: "http://smartit.ventures/farm/Agricultural_project/public/api/getAllPropertyList")!
        case .forgetPassword:
            return URL(string: "http://smartit.ventures/farm/Agricultural_project/public/api/forgot-password")!
        case .getProfile:
            return URL(string: "http://smartit.ventures/farm/Agricultural_project/public/api/showProfile")!
        case .updateProfile:
            return URL(string: "http://smartit.ventures/farm/Agricultural_project/public/api/updateProfile")!
        case .matchOtp:
            return URL(string: "http://smartit.ventures/farm/Agricultural_project/public/api/matchOTP")!
        case .resetPassword:
           return URL(string: "http://smartit.ventures/farm/Agricultural_project/public/api/reset-password")!
        case .getPropertyListIndividualId:
            //192.168.0.40/Agricultural_project/public/api/
            return URL(string: "http://smartit.ventures/farm/Agricultural_project/public/api/getPropertyByParticularId")!
        case .getBlogsList:
            return URL(string: "http://smartit.ventures/farm/Agricultural_project/public/api/getAllBlogList")!
        case .getBlogByparticularId:
             return URL(string: "http://smartit.ventures/farm/Agricultural_project/public/api/getBlogByParticularId")!
        case.getEventList:
            return URL(string: "http://smartit.ventures/farm/Agricultural_project/public/api/getAllEventList")!
        case .getEventDetailByParticularId:
            return URL(string: "http://smartit.ventures/farm/Agricultural_project/public/api/getEventByParticularId")!
        case .addOrRemoveWishList:
            return URL(string: "http://smartit.ventures/farm/Agricultural_project/public/api/storeWishlist")!
        case .getWishList:
            return URL(string: "http://smartit.ventures/farm/Agricultural_project/public/api/getWishlist")!
        case .getInvestmentPlans:
             return URL(string: "http://smartit.ventures/farm/Agricultural_project/public/api/getAllInvestmentPlan")!
        case .getContents:
            return URL(string: "http://smartit.ventures/farm/Agricultural_project/public/api/getContentByParticularId")!
        case .getContact:
             return URL(string: "http://smartit.ventures/farm/Agricultural_project/public/api/getContact")!
        case .logOut:
            return URL(string: "http://smartit.ventures/farm/Agricultural_project/public/api/logout")!
        case .investmentPlansByParticularId:
             return URL(string: "http://smartit.ventures/farm/Agricultural_project/public/api/getInvestmentPlanByParticularId")!
        case .getAboutUs:
            return URL(string: "http://smartit.ventures/farm/Agricultural_project/public/api/getAbout")!
        case .getPremiumServices:
            return URL(string: "http://smartit.ventures/farm/Agricultural_project/public/api/getAllPremiumService")!
        case .getselltoUs:
            return URL(string: "http://smartit.ventures/farm/Agricultural_project/public/api/getSellToUsData")!
        case.getHowItWorks:
            return URL(string: "http://smartit.ventures/farm/Agricultural_project/public/api/getHowItWorksData")!
       case .getChat:
           return URL(string: "http://smartit.ventures/farm/Agricultural_project/public/api/getChat")!
        case .postChat:
             return URL(string: "http://smartit.ventures/farm/Agricultural_project/public/api/postChat")!
        case .getFilter:
             return URL(string: "http://192.168.0.40/Agricultural_project/public/api/getFilter")!
        case .applyFilter:
            return URL(string: "http://192.168.0.40/Agricultural_project/public/api/applyFilter")!
            
        default:
            print("Not Given")
        }
    }
}

func isApiSussess(response: AnyObject) -> Bool {
    if let isSuccess = response["isSuccess"] as? Bool? {
        return isSuccess!
    }
    return false
}

func isApiError(response: AnyObject) -> Bool {
    if let isError = response["isError"] as? Bool? {
        return isError!
    }
    return false
}

func getMessage(response: AnyObject) -> String{
    if let message = response["message"] as? String{
        return message
    }
   return ""
}
