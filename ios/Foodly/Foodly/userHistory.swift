//
//  userHistory.swift
//  Foodly
//
//  Created by Stanley Zeng on 2/17/19.
//  Copyright © 2019 Stanley Zeng. All rights reserved.
//

import UIKit

class userHistory: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pastRestNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        cell.textLabel?.text = pastRestNames[0]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toDetailsFromHistory", sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let good = UITableViewRowAction(style: .normal, title: "Works", handler: {action, indexPath in
            pastRestNames = restaurantNames
            restaurantNames.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
            
            
        })
        good.backgroundColor = UIColor.green
        
        
        
        return[good]
    }
    

}
