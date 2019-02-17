//
//  userBookingsController.swift
//  Foodly
//
//  Created by Stanley Zeng on 2/16/19.
//  Copyright © 2019 Stanley Zeng. All rights reserved.
//

import UIKit

class userBookingsController: UIViewController, UISearchBarDelegate {
    
    var avail: [Available] = []
    var arrStations = [Available]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avail = createArray()
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.hidesBackButton = true
        
    }
    
    func createArray() -> [Available]  {
        
        var tempStations: [Available] = []
        
        let station1 = Available(title: "14th Street")
        let station2 = Available(title: "14th Street - Union Sq")
        let station3 = Available(title: "23rd Street")
        let station4 = Available(title: "34th Street - Herald Sq")
        let station5 = Available(title: "34th Street - Penn Station")
        let station6 = Available(title: "42nd Street - Port Authority")
        let station7 = Available(title: "47-50 Sts-Rockefeller Ctr")
        let station8 = Available(title: "49 St")
        let station9 = Available(title: "50 St")
        let station10 = Available(title: "51 St")
        let station11 = Available(title: "59 St-Columbus Circle")
        let station12 = Available(title: "66 St- Lincoln Center")
        let station13 = Available(title: "72 St")
        let station14 = Available(title: "86 St")
        let station15 = Available(title: "96 St (1,2,3 Trains)")
        let station16 = Available(title: "96 St (Q Train)")
        let station17 = Available(title: "125 St")
        let station18 = Available(title: "135 St")
        let station19 = Available(title: "168 St")
        let station20 = Available(title: "175 St")
        let station21 = Available(title: "Bowling Green")
        let station22 = Available(title: "Broadway-Lafayette/Bleeker")
        let station23 = Available(title: "Brooklyn Bridge - City Hall")
        let station24 = Available(title: "Canal Street")
        let station25 = Available(title: "Chambers Street")
        let station26 = Available(title: "Cortlandt Street")
        let station27 = Available(title: "Dyckman Street")
        let station28 = Available(title: "Fulton Street")
        let station29 = Available(title: "Grand Central 42nd Street")
        let station30 = Available(title: "Inwood 207 Street")
        let station31 = Available(title: "Lexington Av/53rd St")
        let station32 = Available(title: "Lexington Av/63 St")
        let station33 = Available(title: "Roosevelt Island")
        let station34 = Available(title: "South Ferry")
        let station35 = Available(title: "West 4 St")
        let station36 = Available(title: "World Trade Center")
        let station37 = Available(title: "WTC - Cortlandt")
        let station38 = Available(title: "3 Av-149 St")
        let station39 = Available(title: "161 St-Yankee Stadium")
        let station40 = Available(title: "231 St")
        let station41 = Available(title: "Jay Street MetroTech")
        let station42 = Available(title: "Court Street")
        let station43 = Available(title: "Delancey Street/Essex Street")
        let station44 = Available(title: "Hunts Point Ave")
        let station45 = Available(title: "Gun Hill Rd")
        let station46 = Available(title: "Simpson Street")
        let station47 = Available(title: "Atlantic Av - Barclays Center")
        let station48 = Available(title: "Avenue H")
        let station49 = Available(title: "Pelham Bay Park")
        let station50 = Available(title: "Pelham Pkway")
        
        
        
        tempStations.append(station1)
        tempStations.append(station2)
        tempStations.append(station3)
        tempStations.append(station4)
        tempStations.append(station5)
        tempStations.append(station6)
        tempStations.append(station7)
        tempStations.append(station8)
        tempStations.append(station9)
        tempStations.append(station10)
        tempStations.append(station11)
        tempStations.append(station12)
        tempStations.append(station13)
        tempStations.append(station14)
        tempStations.append(station15)
        tempStations.append(station16)
        tempStations.append(station17)
        tempStations.append(station18)
        tempStations.append(station19)
        tempStations.append(station20)
        tempStations.append(station21)
        tempStations.append(station22)
        tempStations.append(station23)
        tempStations.append(station24)
        tempStations.append(station25)
        tempStations.append(station26)
        tempStations.append(station27)
        tempStations.append(station28)
        tempStations.append(station29)
        tempStations.append(station30)
        tempStations.append(station31)
        tempStations.append(station32)
        tempStations.append(station33)
        tempStations.append(station34)
        tempStations.append(station35)
        tempStations.append(station36)
        tempStations.append(station37)
        tempStations.append(station38)
        tempStations.append(station39)
        tempStations.append(station40)
        tempStations.append(station41)
        tempStations.append(station42)
        tempStations.append(station43)
        tempStations.append(station44)
        tempStations.append(station45)
        tempStations.append(station46)
        tempStations.append(station47)
        tempStations.append(station48)
        tempStations.append(station49)
        tempStations.append(station50)
        
        return tempStations
        
    }
    
    
    
}

extension userBookingsController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return avail.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! StationCell
        
        return cell
    }
 
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let good = UITableViewRowAction(style: .normal, title: "Complete", handler: {action, indexPath in })
        
        let report = UITableViewRowAction(style: .destructive, title: "Cancel", handler: {action, indexPath in })
        
        return[good, report]
    }
}
