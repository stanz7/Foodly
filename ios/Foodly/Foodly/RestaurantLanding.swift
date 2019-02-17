//
//  RestaurantLanding.swift
//  Foodly
//
//  Created by Stanley Zeng on 2/16/19.
//  Copyright © 2019 Stanley Zeng. All rights reserved.
//

import UIKit

class RestaurantLanding: UIViewController {

    @IBOutlet weak var restName: UILabel!
    
    var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restName.text = restaurantNames[0]
        self.backgroundImage = UIImageView(image: UIImage(named: "foodbg2"))
        self.backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(self.backgroundImage, at: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.backgroundImage.frame = self.view.bounds
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
