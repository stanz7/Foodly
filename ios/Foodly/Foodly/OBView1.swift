//
//  OBView1.swift
//  Foodly
//
//  Created by Stanley Zeng on 2/15/19.
//  Copyright © 2019 Stanley Zeng. All rights reserved.
//

import UIKit

class OBView1: UIViewController {
    
    
    @IBOutlet weak var img: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }
    

    @IBAction func importImage(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
        //self.textLabel.text = "Got it!"
        
        
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

extension OBView1: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            img.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
}
