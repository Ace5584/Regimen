//
//  ViewController.swift
//  Regimen
//
//  Created by Alex Lai on 22/7/21.
//

import UIKit

class ViewController: UIViewController{

    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionHeight1: NSLayoutConstraint!
    @IBOutlet weak var deleteBtn: UIBarButtonItem!
    @IBAction func deleteBtn(_ sender: UIButton) {
        if let selectedItems = collectionView.indexPathsForSelectedItems{
            let items = selectedItems.map{$0.item}.sorted().reversed()
            for item in items {
                labels.remove(at: item)
            }
            collectionView.deleteItems(at: selectedItems)
            changeConstraint(Constraint: collectionHeight1, LabelLength: labels.count, ScreenWidth: screenWidth)
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        collectionView.allowsMultipleSelection = editing
        deleteBtn.isEnabled = editing
        let indexPaths = collectionView.indexPathsForVisibleItems
        collectionView.indexPathsForSelectedItems?.forEach({ (indexPaths) in collectionView.deselectItem(at: indexPaths, animated: false)})
        for indexPath in indexPaths {
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
            cell.isInEditingMode = editing
        }
    }
    
    @objc func didGetNotification(_ notification: Notification){
        var item: String!
        let text = notification.object as! String?
        item = text
        labels.append(item)
        let indexPath = IndexPath(row: labels.count-1, section: 0)
        collectionView.insertItems(at: [indexPath])
        changeConstraint(Constraint: collectionHeight1, LabelLength: labels.count, ScreenWidth: screenWidth)
    }
    
    @IBAction func addNewITem(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "addItem") as! AddItemViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        changeConstraint(Constraint: collectionHeight1, LabelLength: labels.count, ScreenWidth: screenWidth)
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("Text"), object: nil)
    }
    
    private func changeConstraint(Constraint: NSLayoutConstraint, LabelLength: Int, ScreenWidth: CGFloat){
        var lb = LabelLength
        if (lb % 2) != 0 { lb += 1 }
        Constraint.constant = CGFloat((ScreenWidth/2) * Double(Double(lb)/Double(2)))
    }
}

