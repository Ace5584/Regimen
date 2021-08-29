//
//  PersonalViewController.swift
//  Regimen
//
//  Created by Alex Lai on 26/8/21.
//

import UIKit

class PersonalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var profilePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicture.layer.cornerRadius = profilePicture.bounds.width / 2
        profilePicture.layer.masksToBounds = true
        profilePicture.layer.borderWidth = 3
        profilePicture.layer.borderColor = UIColor.systemTeal.cgColor
        
        if(isKeyPresentInUserDefaults(key: "ProfilePicture")){
            let data = UserDefaults.standard.object(forKey: "ProfilePicture") as! NSData
            profilePicture.image = UIImage(data: data as Data)
        }
        else{
            let imageData = profilePicture.image!.pngData()! as NSData
            defaults.set(imageData, forKey: "ProfilePicture")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(isKeyPresentInUserDefaults(key: "ProfilePicture")){
            let data = UserDefaults.standard.object(forKey: "ProfilePicture") as! NSData
            profilePicture.image = UIImage(data: data as Data)
        }
        else{
            let imageData = profilePicture.image!.pngData()! as NSData
            defaults.set(imageData, forKey: "ProfilePicture")
        }
    }
    
    private func isKeyPresentInUserDefaults(key: String) -> Bool {
        return defaults.object(forKey: key) != nil
    }
}
