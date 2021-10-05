//
//  ViewController.swift
//  Regimen
//
//  Created by Alex Lai on 22/7/21.
//

import UIKit

class HomePageViewController: UIViewController{
    
    // Main Scroll View that hosts everything in this view controller
    @IBOutlet weak var scrollView: UIScrollView!
    
    // Collection View that contains progress bar cells
    @IBOutlet weak var collectionView: UICollectionView!
    
    // constraint height of the view controller that contains progress bar cells
    @IBOutlet weak var collectionHeight1: NSLayoutConstraint!
    
    // Button used to delete circular progress bar cells in collection view
    @IBOutlet weak var deleteBtn: UIBarButtonItem!
    
    // Label that displays the date
    @IBOutlet weak var timeLabel: UILabel!
    
    // Refresh control constant for Scroll view
    let refreshControl = UIRefreshControl()
    
    // View that enables when there's nothing in collection view
    @IBOutlet weak var noActivityView: UIView!
    
    // Function that runs when the view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Checking if Labels key exist, if it does, update labels with the existing key
        // If it does not exist, create key that stores the label
        if(isKeyPresentInUserDefaults(key: "Labels")){
            labels = (defaults.object(forKey: "Labels") as? Array<Array<String>>)!
        }
        else{
            defaults.set(labels, forKey: "Labels")
        }
        
        // Changing the height of the collection view according to the amount of cells present
        changeConstraint(Constraint: collectionHeight1, LabelLength: labels.count, ScreenWidth: screenWidth)
        
        // Adding edit button item on navigation bar
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Observe Notifications from AddItemViewController
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("Text"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(enableDetailScene(_:)), name: Notification.Name("Detail"), object: nil)
        
        // Current Date and time
        refreshTime(Label: timeLabel)
        
        // Controls the refresh of the scroll view
        refreshControl.addTarget(self, action: #selector(refreshPage), for: UIControl.Event.valueChanged)
        scrollView.refreshControl = refreshControl
    }
    
    // Deletes selected circular progress bar cells from collection view
    // Change height of collection view to accomendate the change
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
    
    // overrides default set editing function
    // Enables editing when navigation button edit is selected
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
    
    // Object function that activates once recieved notification from AddItemViewController
    // Creates a new cell with text recieved
    // Changes the height of the constraint on Collection view
    @objc func didGetNotification(_ notification: Notification){
        var item: [String]!
        let text = notification.object as! [String]?
        item = text
        labels.append(item)
        let indexPath = IndexPath(row: labels.count-1, section: 0)
        collectionView.insertItems(at: [indexPath])
        changeConstraint(Constraint: collectionHeight1, LabelLength: labels.count, ScreenWidth: screenWidth)
    }
    
    @objc func enableDetailScene(_ notification: Notification){
        if(isEditing == false){
            self.performSegue(withIdentifier: "DetailsSegue", sender: self)
            
        }
    }
    
    // things to do when refresh the page
    @objc func refreshPage(){
        refreshTime(Label: timeLabel)
        collectionView.reloadData()
        collectionView.refreshControl?.endRefreshing()
        scrollView.refreshControl?.endRefreshing()
    }
    
    // Action when add button is clicked
    @IBAction func addNewITem(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "addItem") as! AddItemViewController
        vc.modalPresentationStyle = .popover
        present(vc, animated: true)
    }
    
    // Changes the Constraint for Table Views with Circular Progress Bar Cells
    private func changeConstraint(Constraint: NSLayoutConstraint, LabelLength: Int, ScreenWidth: CGFloat){
        var lb = LabelLength
        if (lb % 2) != 0 { lb += 1 }
        Constraint.constant = CGFloat((ScreenWidth/2) * Double(Double(lb)/Double(2)))
        if(LabelLength == 0){
            noActivityView.isHidden = false
        }
        else{
            noActivityView.isHidden = true
        }
        defaults.set(labels, forKey: "Labels")
    }
    
    // Function that refreshes the time, taking in the label to display the time on
    private func refreshTime(Label: UILabel){
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        let dateTimeString = formatter.string(from: currentDateTime)
        Label.text = dateTimeString
    }
    
    private func isKeyPresentInUserDefaults(key: String) -> Bool {
        return defaults.object(forKey: key) != nil
    }
    
    public func displayDetailViewController(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as! AddItemViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

