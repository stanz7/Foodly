//
//  StationCell.swift
//  Foodly
//
//  Created by Stanley Zeng on 2/16/19.
//  Copyright © 2019 Stanley Zeng. All rights reserved.
//

import Foundation
import UIKit

class StationCell : UITableViewCell {
    @IBOutlet weak var stationLabel: UILabel!
    
    func setStation(availi : Available) {
        stationLabel.text = availi.title
        if (availi.title == "14th Street - Union Sq") {
            stationLabel.textColor = UIColor.red
        }
        else if (availi.title == "Pelham Bay Park"){
            stationLabel.textColor = UIColor.red
        }
        else {
            
        }
    }
}
