//
//  ViewController.swift
//  Regimen
//
//  Created by Alex Lai on 22/7/21.
//

import UIKit

class ViewController: UIViewController{

    
    
    @IBOutlet weak var collectionHeight1: NSLayoutConstraint!
    @IBAction func editBtn(_ sender: UIButton) {
//        let tableViewEditingMode = tableView.isEditing
//        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
//    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
//    let count = 20
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        heightConstraint.constant = CGFloat(Double(count) * 44.5)
        collectionHeight1.constant = CGFloat(Double(labelLength/2 * 210))
        
    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 20
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
//        cell?.textLabel!.text = "My Name is Alex"
//        return cell!
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete{
//            print("Delete")
//        }
//    }

}

