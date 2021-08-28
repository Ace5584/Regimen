//
//  SettingsViewController.swift
//  Regimen
//
//  Created by Alex Lai on 23/8/21.
//

import UIKit

struct SettingssOption{
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handle: (() -> Void)
}

struct Section{
    let title: String
    let options: [SettingssOption]
}

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        return table
    }()
    
    var models = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Settings"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        navigationItem.largeTitleDisplayMode = .always
    }
    
    func configure(){
        tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 70, bottom: 0, right: 0)
        models.append(Section(title: "General", options: [
            SettingssOption(title: "Background", icon: UIImage(systemName: "person.crop.artframe"), iconBackgroundColor: .systemCyan){
            print("Selected first cell")
        },
            SettingssOption(title: "Color Scheme", icon: UIImage(systemName: "paintpalette.fill"), iconBackgroundColor: .systemRed){
            
        }]))
        
        models.append(Section(title: "Privacy", options: [
            SettingssOption(title: "Personal Information", icon: UIImage(systemName: "person.circle"), iconBackgroundColor: .systemPink){
            
        },
            SettingssOption(title: "Notification", icon: UIImage(systemName: "alarm"), iconBackgroundColor: .systemBlue){
            
        },
            SettingssOption(title: "Account Information", icon: UIImage(systemName: "person.fill"), iconBackgroundColor: .systemGreen){
            
        },
            SettingssOption(title: "Permissions", icon: UIImage(systemName: "globe"), iconBackgroundColor: .systemOrange){
            
        },
            SettingssOption(title: "Social", icon: UIImage(systemName: "person.3.fill"), iconBackgroundColor: .systemBrown){
                              
        }]))
        
        models.append(Section(title: "Advanced", options: [
            SettingssOption(title: "Data", icon: UIImage(systemName: "lock.laptopcomputer"), iconBackgroundColor: .systemIndigo){
            
        }]))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.section].options[indexPath.row]
        model.handle()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}

