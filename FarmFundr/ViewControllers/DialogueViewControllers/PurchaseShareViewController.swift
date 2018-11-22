//
//  PurchaseShareViewController.swift
//  FarmFundr
//
//  Created by Anupriya on 21/11/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit

class PurchaseShareViewController: UIViewController {
    
    // MARK:- Outlet
    @IBOutlet weak var lblFarmTitle : UILabel!
    @IBOutlet weak var lblTotalShare : UILabel!
    @IBOutlet weak var lblSharePrice : UILabel!
    @IBOutlet weak var txtTotalShare : UITextField!
    
    // MARK:- Class Variables
    var propertyInfo : ApiGetPropertyListByParticularIdIncomming?
   // var items:NSMutableArray = NSMutableArray()
    var price : Int = 0
    var environment:String = PayPalEnvironmentSandbox {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
   
    var payPalConfig = PayPalConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      print("PropertyInfo", propertyInfo)
        lblFarmTitle.text = propertyInfo?.propertyDetails?.address
        lblTotalShare.text = "Total share \((propertyInfo?.propertyDetails?.total_share!)!)"
        payPalConfig.acceptCreditCards = false
        payPalConfig.merchantName = "Adrian 0"
          payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionCloseBtn(_ sender : UIButton){
       self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func actionPayWithPayPalBtn(_ sender : UIButton){
        let item1 = PayPalItem(name: (propertyInfo?.propertyDetails?.address)!, withQuantity: UInt(txtTotalShare!.text!)!, withPrice: NSDecimalNumber(string: "8"), withCurrency: "USD", withSku: "")
         let items = [item1]
        let subtotal =  PayPalItem.totalPrice(forItems: items)
        let shipping = NSDecimalNumber(string: "0")
        let tax = NSDecimalNumber(string: "0")
        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
         let total = subtotal.adding(shipping).adding(tax)
         let payment = PayPalPayment(amount: total, currencyCode: "USD", shortDescription: (propertyInfo?.propertyDetails?.address)!, intent: .sale)
        payment.items = items
        payment.paymentDetails = paymentDetails
        if (payment.processable) {
           
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
            present(paymentViewController!, animated: true, completion: nil)
        }
        else {
            // This particular payment will always be processable. If, for
            // example, the amount was negative or the shortDescription was
            // empty, this payment wouldn't be processable, and you'd want
            // to handle that here.
            print("Payment not processalbe: \(payment)")
        }
    }
    
}



extension PurchaseShareViewController : PayPalPaymentDelegate{
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        print("PayPal Payment Cancelled")
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        print("PayPal Payment Success !")
        paymentViewController.dismiss(animated: true, completion: { () -> Void in
            // send completed confirmaion to your server
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
            // Hit Api For PayMent -
            let paymentResultDic = completedPayment.confirmation as NSDictionary
            
            let dicResponse: AnyObject? = paymentResultDic.object(forKey: "response") as AnyObject?
            let paycreatetime:String = dicResponse!["create_time"] as! String
            let payauid:String = dicResponse!["id"] as! String
            let paystate:String = dicResponse!["state"] as! String
            let payintent:String = dicResponse!["intent"] as! String
            print("id is  --->%@",payauid)
            print("created  time ---%@",paycreatetime)
            print("paystate is ----->%@",paystate)
            print("payintent is ----->%@",payintent
             self.dismiss(animated: true, completion: nil)
            
        })
    }
    
}

//MARK:- TextFieldDelegate
extension PurchaseShareViewController : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        lblSharePrice.isHidden = false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if self.txtTotalShare.text != ""{
            //self.lblSharePrice.isHidden = false
            self.price = Int(txtTotalShare.text!)! * 8
            self.lblSharePrice.text = "your total share price $\(price)"
        }
        
        return true
    }
    
    
}


