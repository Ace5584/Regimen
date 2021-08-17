//
//  CollectionViewController.swift
//  Regimen
//
//  Created by Alex Lai on 31/7/21.
//

import UIKit

public let defaults = UserDefaults.standard
public var labels = [String]()
public var labelLength = labels.count
public var measure = Double(screenWidth) / 2

public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

class CollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: Notification.Name("Detail"), object: nil)
    }
}
