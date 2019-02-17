//
//  pSignIn2.swift
//  Foodly
//
//  Created by Stanley Zeng on 2/15/19.
//  Copyright © 2019 Stanley Zeng. All rights reserved.
//

import UIKit

class pSignIn2: UIViewController {

    @IBOutlet var codeField: UITextField! = UITextField()
    //@IBOutlet var errorLabel: UILabel! = UILabel()
    
    var countryCode: String?
    var phoneNumber: String?
    var resultMessage: String?
    
    @IBAction func validateCode() {
        //self.errorLabel.text = nil // reset
        if let code = codeField.text {
            VerifyAPI.validateVerificationCode(self.countryCode!, self.phoneNumber!, code) { checked in
                if (checked.success) {
                    self.resultMessage = checked.message
                    self.performSegue(withIdentifier: "checkResultSegue", sender: nil)
                } else {
                    self.performSegue(withIdentifier: "checkResultSegue", sender: nil)
                    //self.errorLabel.text = checked.message
                }
            }
        }
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "checkResultSegue",
            let dest = segue.destination as? OBView1 {
            //dest.message = resultMessage
        }
    }
 */

}
