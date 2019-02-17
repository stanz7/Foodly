//
//  userSettings.swift
//  Foodly
//
//  Created by Stanley Zeng on 2/17/19.
//  Copyright © 2019 Stanley Zeng. All rights reserved.
//

import UIKit

class userSettings: UIViewController {

    var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backgroundImage = UIImageView(image: UIImage(named: "graybg"))
        self.backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(self.backgroundImage, at: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.backgroundImage.frame = self.view.bounds
    }
    
    @IBAction func logOutClicked(_ sender: Any) {
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "navControllerViewController") as! navControllerViewController
        
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDel.window?.rootViewController = loginVC
    }
    
    

}
