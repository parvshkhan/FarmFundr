//
//  FrequentlyAskedVC.swift
//  FarmFundr
//
//  Created by Shaik Baji on 10/09/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import UIKit


class FrequentlyCell:UITableViewCell
{
    
    @IBOutlet weak var answerLabel: UILabel!
    
}

class FrequentlyAskedVC: UIViewController,UITableViewDelegate,UITableViewDataSource
{
     let kHeaderSectionTag: Int = 6900
    var expandedSectionHeaderNumber: Int = -1
    var expandedSectionHeader: UITableViewHeaderFooterView!
    var sectionItems: Array<Any> = []
    var sectionNames: Array<Any> = [] //ForNames
    var sectionImages: Array<Any> = [] //ForImages
    @IBOutlet weak var tableObject: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableObject.delegate=self
        tableObject.dataSource=self
        sectionItems = [["To get started, register and create a password. Then you can start seeing and using all the benefits of the Site."],
                         ["No. Under the law as it stands today, we can only allow “accredited investors” to participate. That might change in the future – stay tuned."],
                         ["Invite"],["In general, a person is an “accredited investor” if they (i) earn at least $200,000 per year, or $300,000 per year with their spouse; or (ii) has a net worth of at least $1 million, excluding their principal residence. For the SEC’s full definition, please visit http://www.sec.gov/answers/accred.htm."],["You can still sign up and see projects, you just can’t invest yet."],["All kinds of projects involving agricultural real estate, from farmland to agricultural facilities."],["We select projects based on various factors, depending on market conditions."],["Allocating some portion of your portfolio to a direct investment in agricultural real estate may provide you with a reasonably predictable and stable level of current income from the investment; the opportunity for capital appreciation; and diversification of your portfolio; and may also provide you with the knowledge that you are contributing to sustainable agricultural and also keeping farmland from turning into shopping malls."],["That’s entirely up to you and your investment advisers. As a general matter, most people recommend a balanced portfolio that includes both low-risk and high-risk investments, with the right mix based on lots of factors including your age and your own tolerance for market fluctuations. As you consider how much to invest, you should definitely think of most of the projects on our site as high-risk investments."],["We will stipulate a minimum investment in each project, which will range from $2,500 to $100,000."],["You should view these as very risky investments, much riskier than an investment in a stock market index fund, for example. The same is true for any direct investment in real estate. You could lose some or all of your money in any of these investments."],["No, not at all. You are personally liable only to make your investment. We choose our legal structures to protect investors from personal liability."],["First, review our active projects. When you decide to invest, click “I’m Ready to Invest” and we will guide you through the process. We’ll have you review important information about the project, we’ll ask you to sign our Investment Agreement, and then – and only then – will we ask you to pay for your investment."]
        ];

        
    }
    @IBAction func menuBtnTapped(_ sender: UIButton)
    {
        
        showSideMenuView()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        hideSideMenuView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        
        return 12
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (self.expandedSectionHeaderNumber == section)
        {
            let arrayOfItems = self.sectionItems[section] as! NSArray
            return arrayOfItems.count;
        }
        else
        {
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if (self.sectionNames.count != 0)
        {
            return self.sectionNames[section] as? String
        }
        return ""
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        
        let header:UIView =  UIView()
        header.frame = CGRect(x: 10, y: 5, width:self.tableObject.frame.size.width, height: 30)
        
        if let viewWithTag = self.view.viewWithTag(kHeaderSectionTag + section)
        {
            viewWithTag.removeFromSuperview()
        }
        if(section==0)
        {
            let headerFrame = self.view.frame.size
            let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 32, y:13, width: 18, height: 18));
            theImageView.image = UIImage(named: "hello")
            theImageView.tag = kHeaderSectionTag + section
            header.addSubview(theImageView)
            
            let titleLbl = UILabel(frame: CGRect(x: 10, y:5, width: header.frame.size.width, height: 30))
            titleLbl.text = "1.How do I get started ?"
           titleLbl.textColor = UIColor(displayP3Red: 72.0/255.0, green: 126.0/255.0, blue: 44.0/255.0, alpha: 1.0)
            header.addSubview(titleLbl)
        }
        if(section==1)
        {
            let headerFrame = self.view.frame.size
            let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 32, y:5, width: 18, height: 18));
            theImageView.image = UIImage(named: "hello")
            theImageView.tag = kHeaderSectionTag + section
            header.addSubview(theImageView)
            
            let titleLbl = UILabel(frame: CGRect(x: 10, y:5, width: header.frame.size.width, height: 30))
            titleLbl.text = "2.Can anyone invest ?"
            titleLbl.textColor = UIColor(displayP3Red: 72.0/255.0, green: 126.0/255.0, blue: 44.0/255.0, alpha: 1.0)
            header.addSubview(titleLbl)
            
       
        }
        else if(section==2)
        {
            let headerFrame = self.view.frame.size
            let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 32, y: 13, width: 18, height: 18));
            theImageView.image = UIImage(named: "hello")
            theImageView.tag = kHeaderSectionTag + section
            header.addSubview(theImageView)
            
            let titleLbl = UILabel(frame: CGRect(x: 10, y:7, width: header.frame.size.width, height: 30))
            titleLbl.text = "3.What is an accredited investor?"
            titleLbl.textColor = UIColor(displayP3Red: 72.0/255.0, green: 126.0/255.0, blue: 44.0/255.0, alpha: 1.0)
            header.addSubview(titleLbl)
            
          
        }
        else if(section==3)
        {
            let headerFrame = self.view.frame.size
            let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 32, y: 13, width: 18, height: 18));
            theImageView.image = UIImage(named: "hello")
            theImageView.tag = kHeaderSectionTag + section
            header.addSubview(theImageView)
            
            let titleLbl = UILabel(frame: CGRect(x: 10, y:7, width: header.frame.size.width-25, height: 35))
            titleLbl.text =  "4.What if I’m not an accredited investor?"
            titleLbl.numberOfLines = 0
            titleLbl.lineBreakMode = .byWordWrapping
            titleLbl.textColor = UIColor(displayP3Red: 72.0/255.0, green: 126.0/255.0, blue: 44.0/255.0, alpha: 1.0)
            header.addSubview(titleLbl)
        }
        else if(section==4)
        {
            let headerFrame = self.view.frame.size
            let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 32, y: 13, width: 18, height: 18));
            theImageView.image = UIImage(named: "hello")
            theImageView.tag = kHeaderSectionTag + section
            header.addSubview(theImageView)
            
            let titleLbl = UILabel(frame: CGRect(x: 10, y:7, width: header.frame.size.width-20, height: 50))
            titleLbl.text = "5.What kinds of projects will I see on your site?"
            titleLbl.numberOfLines = 0
            titleLbl.lineBreakMode = .byWordWrapping
            titleLbl.textColor = UIColor(displayP3Red: 72.0/255.0, green: 126.0/255.0, blue: 44.0/255.0, alpha: 1.0)
            header.addSubview(titleLbl)
            
          
        }
        else if(section==5)
        {
            let headerFrame = self.view.frame.size
            let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 32, y: 13, width: 18, height: 18));
            theImageView.image = UIImage(named: "hello")
            theImageView.tag = kHeaderSectionTag + section
            header.addSubview(theImageView)
            
    let titleLbl = UILabel(frame: CGRect(x: 10, y:7, width: header.frame.size.width, height: 30))
            titleLbl.text = "6.How do you select projects?"
          titleLbl.textColor = UIColor(displayP3Red: 72.0/255.0, green: 126.0/255.0, blue: 44.0/255.0, alpha: 1.0)
            header.addSubview(titleLbl)
        }
        else if(section==6)
        {
            let headerFrame = self.view.frame.size
            let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 32, y: 13, width: 18, height: 18));
            theImageView.image = UIImage(named: "hello")
            theImageView.tag = kHeaderSectionTag + section
            header.addSubview(theImageView)
            
        let titleLbl = UILabel(frame: CGRect(x:10, y:7, width: header.frame.size.width-30, height: 50))
            titleLbl.text = "7.Why should I consider an investment in agricultural real estate?"
            titleLbl.textColor = UIColor(displayP3Red: 72.0/255.0, green: 126.0/255.0, blue: 44.0/255.0, alpha: 1.0)
            titleLbl.numberOfLines = 0
            titleLbl.lineBreakMode = .byWordWrapping
            header.addSubview(titleLbl)
        }
        else if(section==7)
        {
            let headerFrame = self.view.frame.size
            let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 32, y: 13, width: 18, height: 18));
            theImageView.image = UIImage(named: "hello")
            theImageView.tag = kHeaderSectionTag + section
            header.addSubview(theImageView)
            
       let titleLbl = UILabel(frame: CGRect(x: 10, y:7, width: header.frame.size.width, height: 30))
            titleLbl.text = "8.How much should I invest?"
           titleLbl.textColor = UIColor(displayP3Red: 72.0/255.0, green: 126.0/255.0, blue: 44.0/255.0, alpha: 1.0)
            header.addSubview(titleLbl)
        }
        else if(section==8)
        {
            let headerFrame = self.view.frame.size
            let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 32, y: 13, width: 18, height: 18));
            theImageView.image = UIImage(named: "hello")
            theImageView.tag = kHeaderSectionTag + section
            header.addSubview(theImageView)
            
         let titleLbl = UILabel(frame: CGRect(x:10, y:7, width: header.frame.size.width, height: 30))
            titleLbl.text = "9.Are there minimum investments?"
      titleLbl.textColor = UIColor(displayP3Red: 72.0/255.0, green: 126.0/255.0, blue: 44.0/255.0, alpha: 1.0)
            header.addSubview(titleLbl)
        }
            
        else if(section==9)
        {
            let headerFrame = self.view.frame.size
            let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 32, y: 13, width: 18, height: 18));
            theImageView.image = UIImage(named: "hello")
            theImageView.tag = kHeaderSectionTag + section
            header.addSubview(theImageView)
            
            let titleLbl = UILabel(frame: CGRect(x:10, y:7, width: header.frame.size.width, height: 30))
            titleLbl.text = "10.Are these risky investments?"
          titleLbl.textColor = UIColor(displayP3Red: 72.0/255.0, green: 126.0/255.0, blue: 44.0/255.0, alpha: 1.0)
            header.addSubview(titleLbl)
        }
        else if(section==10)
        {
            let headerFrame = self.view.frame.size
            let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 32, y: 13, width: 18, height: 18));
            theImageView.image = UIImage(named: "hello")
            theImageView.tag = kHeaderSectionTag + section
            header.addSubview(theImageView)
            
            let titleLbl = UILabel(frame: CGRect(x:10, y: 7, width: header.frame.size.width-25, height: 50))
            titleLbl.text = "11.If I invest in a project, do I become personally liable for anything?"
          titleLbl.textColor = UIColor(displayP3Red: 72.0/255.0, green: 126.0/255.0, blue: 44.0/255.0, alpha: 1.0)
            titleLbl.numberOfLines = 0
            titleLbl.lineBreakMode = .byWordWrapping
            header.addSubview(titleLbl)
        }
        else if(section==11)
        {
            let headerFrame = self.view.frame.size
            let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 32, y: 13, width: 18, height: 18));
            theImageView.image = UIImage(named: "hello")
            theImageView.tag = kHeaderSectionTag + section
            header.addSubview(theImageView)
            
           let titleLbl = UILabel(frame: CGRect(x:10, y:7, width: header.frame.size.width, height: 30))
            titleLbl.text = "12. Describe the investment process."
           titleLbl.textColor = UIColor(displayP3Red: 72.0/255.0, green: 126.0/255.0, blue: 44.0/255.0, alpha: 1.0)
            header.addSubview(titleLbl)
        }
      else
        {
            let headerFrame = self.view.frame.size
            let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 32, y: 13, width: 18, height:18));
            theImageView.image = UIImage(named: "hello")
            theImageView.tag = kHeaderSectionTag + section
            //header.addSubview(theImageView)
            
        }
        // make headers touchable
        header.tag = section
        let headerTapGesture = UITapGestureRecognizer()
        headerTapGesture.addTarget(self, action: #selector(FrequentlyAskedVC.sectionHeaderWasTouched(_:)))
        header.addGestureRecognizer(headerTapGesture)
        
        return header
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        
        return 65.0;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FrequentlyCell") as! FrequentlyCell
        let section = self.sectionItems[indexPath.section] as! NSArray
        cell.answerLabel.textColor = UIColor.black
        cell.answerLabel.text  = section[indexPath.row] as? String
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        print("The Index Path is \(indexPath.row)")
    }
    
    
    
    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
        let headerView = sender.view as! UIView
        let section    = headerView.tag
        let eImageView = headerView.viewWithTag(kHeaderSectionTag + section) as? UIImageView
        
        if (self.expandedSectionHeaderNumber == -1)
        {
            self.expandedSectionHeaderNumber = section
            tableViewExpandSection(section, imageView: eImageView!)
        } else {
            if (self.expandedSectionHeaderNumber == section)
            {
                tableViewCollapeSection(section, imageView: eImageView!)
            } else
            {
                let cImageView = self.view.viewWithTag(kHeaderSectionTag + self.expandedSectionHeaderNumber) as? UIImageView
                tableViewCollapeSection(self.expandedSectionHeaderNumber, imageView: cImageView!)
                tableViewExpandSection(section, imageView: eImageView!)
            }
        }
    }
    
    
    func tableViewCollapeSection(_ section: Int, imageView: UIImageView)
     {
        let sectionData = self.sectionItems[section] as! NSArray
        
        self.expandedSectionHeaderNumber = -1;
        if (sectionData.count == 0) {
            return;
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: (0.0 * CGFloat(Double.pi)) / 180.0)
            })
            var indexesPath = [IndexPath]()
            for i in 0 ..< sectionData.count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            self.tableObject!.beginUpdates()
            self.tableObject!.deleteRows(at: indexesPath, with: UITableViewRowAnimation.fade)
            self.tableObject!.endUpdates()
        }
    }
    
    func tableViewExpandSection(_ section: Int, imageView: UIImageView)
    {
        let sectionData = self.sectionItems[section] as! NSArray
        
        if (sectionData.count == 0)
        {
            self.expandedSectionHeaderNumber = -1;
            return;
        }
        else
        {
            UIView.animate(withDuration: 0.4, animations:
                {
                    imageView.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
            })
            var indexesPath = [IndexPath]()
            for i in 0 ..< sectionData.count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            self.expandedSectionHeaderNumber = section
            self.tableObject!.beginUpdates()
            self.tableObject!.insertRows(at: indexesPath, with: UITableViewRowAnimation.left)
            self.tableObject!.endUpdates()
        }
    }
}
