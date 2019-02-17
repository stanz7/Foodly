//
//  restDetails.swift
//  Foodly
//
//  Created by Stanley Zeng on 2/17/19.
//  Copyright © 2019 Stanley Zeng. All rights reserved.
//

import UIKit

class restDetails: UIViewController {

    @IBOutlet weak var restAddy: UILabel!
    @IBOutlet weak var restPhone: UILabel!
    @IBOutlet weak var restPickUpDate: UILabel!
    @IBOutlet weak var pickUpDescription: UILabel!
    
    var backgroundImage: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restAddy.text = restaurantAddresses[0]
        restPhone.text = restaurantPhoneNumbers[0]
        restPickUpDate.text = dates[0]
        pickUpDescription.text = globalDescription[0]
        self.backgroundImage = UIImageView(image: UIImage(named: "foodbg2"))
        self.backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(self.backgroundImage, at: 0)
        

        // Do any additional setup after loading the view.
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
