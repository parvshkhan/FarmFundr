//
//  FarmDetailsViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 03/10/18.
//  Copyright © 2018   smartitventures.com. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class FarmDetailsViewController: UIViewController , IndicatorInfoProvider{
    //MARK :- Outlets
    @IBOutlet weak var lblFarmDetails :UILabel!
    //MARK:- Class Variables
    var propertyInfo : ApiGetPropertyListByParticularIdIncomming?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         propertyInfo = PropertyDetailsViewController.propertyInfo
         lblFarmDetails.text = propertyInfo?.propertyDetails?.farm_detail?.htmlToString

    }
    
 //MARK:- XLPagerTab Protocol
 
 func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
     print("This is Chide three Class")
    
 return IndicatorInfo(title: "FARM DETAIL")
 }

}
