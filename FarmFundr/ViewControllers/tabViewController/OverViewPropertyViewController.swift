//
//  OverViewPropertyViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 03/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class OverViewPropertyViewController: UIViewController  , IndicatorInfoProvider{
    //MARK:- Outlets
    @IBOutlet weak var viewLineChart: LineChart!
    @IBOutlet weak var lblFunded : UILabel!
    @IBOutlet weak var lblROI : UILabel!
    @IBOutlet weak var lblDaysLeft : UILabel!
    @IBOutlet weak var lblChartData: UILabel!
    @IBOutlet weak var viewProgressBar : LinearProgressBar!
    // MARK:- Class Variables
    var name : String?
    var propertyDetails : ApiGetPropertyListByParticularIdIncomming?
    var yValue : [CGFloat] = []
    var staticXval : [String] = ["2001","2002","2003"]
    var staticYval : [CGFloat] = [10.0,20.0,100.0]
    var xLabels : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        if let parent = self.parent as? PropertyDetailsViewController{
            propertyDetails = parent.propertyDetails
        }
        viewProgressBar.progressValue = CGFloat((propertyDetails?.propertyDetails?.total_fund)!)
        lblROI.text = "\(propertyDetails!.propertyDetails!.roi!)" + "%"
        lblFunded.text = "\(propertyDetails!.propertyDetails!.funded!)" + "%"
        lblDaysLeft.text = "\(propertyDetails!.propertyDetails!.diffDate!)"
    _ = propertyDetails.map { pData in
        _ = pData.propertyDetails?.chartDatas.map({ chartData in
                yValue.append(chartData.yVal)
               xLabels.append(chartData.lblString)
        })
    }
        print("ARRAY Y ===" , yValue , xLabels)
        if yValue.count > 1 {
            drawLineChart(xValue: xLabels, yValue: yValue)
        }else{
            viewLineChart.isHidden = true
           // viewLineChart.drawingWidth = 0
            lblChartData.text = "Sorry No data Found"
            drawLineChart(xValue: staticXval, yValue: staticYval)
            
        }
       
        // Do any additional setup after loading the view.
    }
    
    /**
     * Redraw chart on device rotation.
     */
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
//        if let chart = ViewlineChartChild {
//
//            chart.setNeedsDisplay()
//        }
    }
    
    //MARK:- Action BuyNow Btn
    @IBAction func actionBuyNowBtn(_ sender : UIButton){
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "PurchaseShareViewController") as! PurchaseShareViewController
        vc.propertyInfo = self.propertyDetails
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
     self.present(vc, animated: true, completion: nil)
    }
    
    // MARK:- XLPagerTabStrip Protocol
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        print("This is Chide One Class")
        return IndicatorInfo(title: "OVERVIEW")
    }

    // MARK:- Draw LineChart Of Data
    func drawLineChart(xValue : [String] , yValue : [CGFloat]){
        viewLineChart.animation.enabled = true
        viewLineChart.area = true
        viewLineChart.x.labels.visible = true
        //        lineChart.x.grid.count = 8
        //        lineChart.y.grid.count = 8
        viewLineChart.x.labels.values = xValue
        viewLineChart.y.labels.visible = true
        //        lineChart.addLine(data)
        viewLineChart.addLine(yValue)
        viewLineChart.translatesAutoresizingMaskIntoConstraints = false
        viewLineChart.delegate = self
    }
    
    

}

extension OverViewPropertyViewController : LineChartDelegate{
    
    func didSelectDataPoint(_ x: CGFloat, yValues: [CGFloat]) {
         lblChartData.text = "x: \(x)  y: \(yValues)"
    }
    
    
}
