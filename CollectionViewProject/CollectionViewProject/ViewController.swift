//
//  ViewController.swift
//  CollectionViewProject
//
//  Created by Alex Lai on 8/8/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var data = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁","🐮", "🐷", "🐸", "🐵", "🐔", "🐧", "🐤", "🐥", "🦆", "🦅", "🦉", "🐺", "🐗", "🐴", "🦄", "🐝", "🪱", "🐛", "🦋", "🐌", "🐞", "🐜", "🦂", "🐍", "🦎", "🦖", "🦕", "🐙", "🦑", "🦐", "🦞", "🦀", "🐡", "🐠", "🐟", "🐬", "🐳", "🐋"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        let numOfColumn = 3
        let width = (self.view.frame.size.width - CGFloat((numOfColumn - 1)*10)) / CGFloat(numOfColumn)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedItem = sender as? String else{
            return
        }
        
        if segue.identifier == "detail" {
            guard let destinationVC = segue.destination as?
                    DetailViewController else{
                        return
                    }
        
            destinationVC.selectedData = selectedItem
        }
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let label = cell.viewWithTag(100) as? UILabel{
            label.text = data[indexPath.item]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedData = data[indexPath.item]
        self.performSegue(withIdentifier: "detail", sender: selectedData)
    }
    
}
