//
//  RestaurantPending.swift
//  Foodly
//
//  Created by Stanley Zeng on 2/16/19.
//  Copyright © 2019 Stanley Zeng. All rights reserved.
//

import UIKit



class RestaurantPending: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem.plain(barButtonSystemItem: UIBarButtonItem.SystemItem, target: self, action: nil)
        tableView.dataSource = self
        tableView.delegate = self
        super.viewDidLoad()
        //self.tableView.rowHeight = 100.0
        
        let tabbar = tabBarController as! Tab2
        /*
        dates = tabbar.dates
        pounds = tabbar.pounds
 */
        
        let refreshBtn = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refresh(_:)))
        self.navigationItem.rightBarButtonItem = refreshBtn
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem.Style
        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func refresheroo(_ sender: Any) {
        self.tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            dates.remove(at: indexPath.row)
            pounds.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
    /*
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let good = UITableViewRowAction(style: .normal, title: "Complete", handler: {action, indexPath in })
        
        let report = UITableViewRowAction(style: .destructive, title: "Cancel", handler: {action, indexPath in })
        
        
        return[good, report]
    }
    */
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
