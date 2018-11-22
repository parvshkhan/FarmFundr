//
//  AppColors.swift
//  FarmFundr
//
//  Created by Anupriya on 24/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import Foundation
import UIKit
enum AppColors {
    case red
    case green
    case lightGreen
    case lightGray
    case white
    case blue
    var color : UIColor{
        switch self {
        case .blue:
            return #colorLiteral(red: 0.08783785254, green: 0.338482976, blue: 0.9661460519, alpha: 1)
        case .green:
            return #colorLiteral(red: 0.2, green: 0.5991417766, blue: 0.399366498, alpha: 1)
        case .lightGreen:
            return #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        case .white:
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .red:
            return #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        case .lightGray:
           return #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        default:
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
    }
}
