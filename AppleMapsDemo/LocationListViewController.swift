//
//  LocationListViewController.swift
//  AppleMapsDemo
//
//  Created by Sayalee on 5/18/18.
//  Copyright © 2018 Assignment. All rights reserved.
//

import UIKit
import CoreData

class LocationListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    let managedContext = AppDelegate.shared.persistentContainer.viewContext
    var locationList: [Location] = []
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchLocationList()
        
        let subviews = tableView.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }

        if locationList.count == 0 {
            addListEmptyLabel()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func addListEmptyLabel() {
        let messageLabel = UILabel(frame: CGRect(x: 20, y: tableView.frame.height/2 - 50, width: tableView.frame.width - 40, height: 50))
        messageLabel.text = NSLocalizedString("Please add locations using \u{FF0B} button at top right corner.", comment: "")
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "Helvetica", size: 16)
        messageLabel.textColor = #colorLiteral(red: 0.7719142122, green: 0.7945639071, blue: 0.8187171569, alpha: 1)
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping
        tableView.addSubview(messageLabel)
    }
    
    func fetchLocationList() {
        locationList = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        let sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        
        do {
            if let result = try managedContext.fetch(fetchRequest) as? [Location] {
                locationList = result
                self.tableView.reloadData()
            }
        } catch {
            debugPrint("Fetch Error!")
        }
    }
    
    //MARK:- UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        let location = locationList[indexPath.row]
        cell.textLabel?.text = location.title
        
        if let lat = location.lat, let long = location.long {
            cell.detailTextLabel?.text =  "Lat: " + lat + ", Long: " + long
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedIndex = indexPath.row
        return indexPath
    }
    
 
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else {
            return
        }
        
        if segueIdentifier == "ShowMap" {
            let mapViewController = segue.destination as? MapViewController
            mapViewController?.location = locationList[selectedIndex]
        }
    }
   

}
