//
//  CollectionViewController.swift
//  Regimen
//
//  Created by Alex Lai on 31/7/21.
//

import UIKit

private let reuseIdentifier = "Cell"
public var labels = ["A", "B", "C"]
public var labelLength = labels.count
public var measure = Double(screenWidth) / 2
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

class CollectionViewController: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var deleteBtn : UIBarButtonItem!
    
    @IBAction func deleteItem(_ sender: Any) {
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! CollectionViewCell
        cell.setProgressView()
        cell.setLabel(label: labels[indexPath.row])
        return cell
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.dataSource = self
        self.delegate = self
    }
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return labels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        measure = collectionView.frame.size.width
        let measurement = collectionView.frame.size.width / 2
        return CGSize(width: measurement, height: measurement)
    }
}
