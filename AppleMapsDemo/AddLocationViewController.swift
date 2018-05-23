//
//  AddLocationViewController.swift
//  AppleMapsDemo
//
//  Created by Sayalee on 5/18/18.
//  Copyright © 2018 Assignment. All rights reserved.
//

import UIKit
import CoreData

class AddLocationViewController: UIViewController {

    @IBOutlet weak var locationName: UITextField!
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var longitude: UITextField!
    
    private let managedContext =
        AppDelegate.shared.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func saveTapped(_ sender: Any) {
        if let title = locationName.text, !title.isEmpty,
            let latitude = latitude.text, !latitude.isEmpty,
            let longitude = longitude.text, !longitude.isEmpty {
            let location = Location(context: managedContext)
            location.setValuesForKeys(["title" : title, "lat": latitude, "long": longitude])
            AppDelegate.shared.saveContext()
            let alert = UIAlertController (title: "", message: "Location saved!", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController (title: "", message: "Please input all the fields.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        resetTextFields()
    }
    
    @IBAction func useCurrentLocationTapped(_ sender: Any) {
        
    }
    
    func resetTextFields() {
        locationName.text = ""
        latitude.text = ""
        longitude.text = ""
    }
}
