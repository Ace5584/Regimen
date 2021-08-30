//
//  StaticTableViewController.swift
//  Regimen
//
//  Created by Alex Lai on 29/8/21.
//

import UIKit

class StaticTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let cells = [["Profile"], ["ChangeProfile", "ChangeRegion", "ChangeDOB"]]

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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return cells.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cells[section].count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == [1, 0]{
            let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.delegate = self
            picker.sourceType = UIImagePickerController.SourceType.photoLibrary
            present(picker, animated: true)
        }
        else if indexPath == [1, 1]{
            
        }
        else if indexPath == [1, 2]{
            self.performSegue(withIdentifier: "DateSelectorSegue", sender: self)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        profilePicture.image = image
        
        let imageData = profilePicture.image!.pngData()! as NSData
        defaults.set(imageData, forKey: "ProfilePicture")
        
        dismiss(animated: true)
    }
    
    private func isKeyPresentInUserDefaults(key: String) -> Bool {
        return defaults.object(forKey: key) != nil
    }
}
