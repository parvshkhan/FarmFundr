//
//  FarmLandVC.swift
//  FarmFundr
//
//  Created by Shaik Baji on 11/09/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit


struct  fieldStruct
{
    var image:UIImage!
    var image2:UIImage!
    var one:String!
    var two:String!
    var three:String!
    var four:String!
    var five:String!
    var six:String!
}


class FarmCells:UITableViewCell
{
    @IBOutlet weak var oneImage: UIImageView!
    @IBOutlet weak var twoImage: UIImageView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    @IBOutlet weak var fifthLabel: UILabel!
    @IBOutlet weak var sixthLabel: UILabel!
}


class FarmLandVC: UIViewController,UITableViewDelegate,UITableViewDataSource
{
   @IBOutlet weak var tableObject: UITableView!
    var fieldArray = [fieldStruct]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableObject.delegate = self
        tableObject.dataSource = self
        
        fieldArray = [fieldStruct(image:#imageLiteral(resourceName: "image1"), image2:#imageLiteral(resourceName: "img_39"), one:"By 2050 the world population will grow to over 10 billion people.", two:"In addition to 3 billion more people, the middle class will grow at an unprecedented rate. An additional 3 billion people will enter the middle class causing food demand to sky rocket.", three:"Farmers will have to produce 70% more food by 2050.", four:"This will all have to be accomplished on less farmland. The U.S. alone loses almost 500,000 acres of farmland a year. That’s a loss of nearly 15,000,000 acres of farmland by 2050.", five:"The average U.S. farmers age is 58. As more and more farmers reach the retirement age a large portion of land will change hands supplying the market with a great opportunity to invest in farmland.", six:"Reasons To Invest In Farmland"),fieldStruct(image:#imageLiteral(resourceName: "image1"), image2:#imageLiteral(resourceName: "img_39"), one:"Farm returns have averaged more than 12% since the great depression.", two:"Farmland historically has been a great inflation hedge.", three:"Investors must realize that farmland is a long term investment. Return on an investment can vary from 12 months to 7 years before seeing your first return on investments.", four:"Farming is expensive. Historically this kept many investors out of the industry or limited to REITS that disconnect the investor from their investment.", five:"Many times, REITS offer low returns due to their buy and lease investment model. FarmFundr has changed this by offering for the first time direct investments into farmland at a fraction of the cost.", six:"Investing in Farmland"),fieldStruct(image:#imageLiteral(resourceName: "image1"), image2:#imageLiteral(resourceName: "img_39"), one:"", two:"FarmFundr invites our investors to stay at one of our farm houses. We want investors to see the many different aspects of a real working farm. But most importantly, see the hard work that goes into feeding the world.", three:"FarmFundr offers investors a never before seen opportunity to invest in a real working farm at a fraction of a cost to buy one.", four:"FarmFundr offers diversity. Traditionally, it would take millions of dollars to invest in a variety of farms and crops. This can now be accomplished for as little as $10,000 per investment.", five:"", six:"Reasons to Invest With FarmFundr")]

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableObject.dequeueReusableCell(withIdentifier:"FarmCells", for:indexPath) as! FarmCells
        
        cell.oneImage.image = fieldArray[indexPath.row].image
        cell.twoImage.image = fieldArray[indexPath.row].image2
        cell.firstLabel.text = fieldArray[indexPath.row].six
        cell.secondLabel.text = fieldArray[indexPath.row].one
        cell.thirdLabel.text = fieldArray[indexPath.row].two
        cell.fourthLabel.text = fieldArray[indexPath.row].three
        cell.fifthLabel.text = fieldArray[indexPath.row].four
        cell.sixthLabel.text = fieldArray[indexPath.row].five
        
        return cell
    }
    @IBAction func menuBtnTapped(_ sender: UIButton)
    {
        showSideMenuView()
    }
    
   
}
