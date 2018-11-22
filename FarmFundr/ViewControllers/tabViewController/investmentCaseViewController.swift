//
//  investmentCaseViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 03/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class investmentCaseViewController: UIViewController , IndicatorInfoProvider {
    //MARK:- Outlets
    @IBOutlet weak var lblInvestmentCare : UILabel!
    //MARK:- Class Variables
    var propertyInfo : ApiGetPropertyListByParticularIdIncomming?
    override func viewDidLoad() {
        super.viewDidLoad()
            propertyInfo = PropertyDetailsViewController.propertyInfo
            print("MY DATA2==", propertyInfo)
         lblInvestmentCare.text = propertyInfo?.propertyDetails?.investment_care?.htmlToString
        // Do any additional setup after loading the view.
    }
    
    //MARK:- XLPagerTab Protocol
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        print("This is Chide three Class")
        return IndicatorInfo(title: "INVESTMENT CARE")
    }
   

}
