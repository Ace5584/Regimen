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
    }
    
    @IBAction func btnPicture(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        profilePicture.image = image
        dismiss(animated: true)
    }
}
