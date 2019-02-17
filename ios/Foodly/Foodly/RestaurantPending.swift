//
//  RestaurantPending.swift
//  Foodly
//
//  Created by Stanley Zeng on 2/16/19.
//  Copyright © 2019 Stanley Zeng. All rights reserved.
//

import UIKit


class RestaurantPending: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dates = [String]()
    var pounds = [String]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem.plain(barButtonSystemItem: UIBarButtonItem.SystemItem, target: self, action: nil)
        super.viewDidLoad()
        //self.tableView.rowHeight = 100.0
        let tabbar = tabBarController as! Tab2
        dates = tabbar.dates
        pounds = tabbar.pounds
        tableView.dataSource = self
        tableView.delegate = self
        let refreshBtn = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refresh(_:)))
        self.navigationItem.rightBarButtonItem = refreshBtn
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem.Style
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func refresh(_ sender: Any) {
        self.tableView.reloadData()
    }
    
    func add(date: String, pound: String) {
        dates.append(date)
        pounds.append(pound)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "restCell", for: indexPath)
        cell.textLabel?.text = dates[0] + " , pounds: " + pounds[0]
        //cell.tableCellLabel.text = dates[indexPath.row]
        //cell.tableCellLabel2.text = pounds[indexPath.row]
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
