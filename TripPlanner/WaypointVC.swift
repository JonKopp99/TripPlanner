//
//  WaypointVC.swift
//  TripPlanner
//
//  Created by Jonathan Kopp on 5/7/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.

import UIKit
import MapKit
import CoreData

class WaypointVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, MKMapViewDelegate{
    
    var tableView = UITableView()
    var searchBar = UITextField()
    var mapView = MKMapView()
    var matchingItems:[MKMapItem] = []
    var wView = UIView()
    var selectedWP = MKMapItem()
    var theTrip: Trip!
    var store: CoreDataStack!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = .white
        
        let label = UILabel()
        label.frame = CGRect(x: 70, y: 30, width: self.view.bounds.width - 120, height: 35)
        label.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        label.font = UIFont(name: "AvenirNext-HeavyItalic", size: 25)
        label.text = "Waypoints"
        label.textAlignment = .center
        
       
        
        let b2 = UIButton(frame: CGRect(x: 0, y: 30, width: 70, height: 35))
        b2.setTitle("Cancel", for: .normal)
        b2.titleLabel?.sizeToFit()
        b2.setTitleColor(.blue, for: .normal)
        b2.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        
        view.addSubview(label)
        view.addSubview(b2)
        
        searchBar.frame = CGRect(x: 20, y: label.frame.maxY, width: self.view.bounds.width - 40, height: 30)
        searchBar.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        searchBar.layer.cornerRadius = 10
        searchBar.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        searchBar.layer.borderWidth = 1
        searchBar.returnKeyType = .done
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        self.view.addSubview(searchBar)
        
        
        tableView.register(WayPointCell.self, forCellReuseIdentifier: "wpcell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: label.frame.maxY + 30, width: self.view.bounds.width, height: self.view.bounds.height / 2 - (label.frame.maxY + 30))
        //tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        tableView.reloadData()
        mapView.frame = CGRect(x: 0, y: tableView.frame.maxY, width: self.view.bounds.width, height: self.view.bounds.height - tableView.frame.maxY)
        mapView.delegate = self
        centerMap(location: CLLocation(latitude: 37.7862002, longitude: -122.408004))
        let userDefaults = Foundation.UserDefaults.standard
        if let xT = userDefaults.string(forKey: "xLoc")
        {
            if let yT = userDefaults.string(forKey: "yLoc")
            {
                if(!xT.isEmpty && !yT.isEmpty)
                {
                    centerMap(location: CLLocation(latitude: CLLocationDegrees(xT)!, longitude: CLLocationDegrees(yT)!))
                }
            }
        }
        
        self.view.addSubview(mapView)
    }
    
    func selectedWPView(place: MKMapItem)
    {
        wView = UIView()
        wView.frame = tableView.frame
        tableView.removeFromSuperview()
        let label = UILabel()
        label.frame = CGRect(x: 20, y: wView.frame.height / 2 - 12.5, width: self.view.bounds.width - 40, height: 25)
        label.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        label.font = UIFont(name: "AvenirNext-HeavyItalic", size: 25)
        label.text = place.name
        label.textAlignment = .center
        
        let b = UIButton(frame: CGRect(x: 10, y: label.frame.maxY + 10, width: self.view.bounds.width / 2 - 20, height: 35))
        b.setTitleColor(.blue, for: .normal)
        b.setTitle("Add?", for: .normal)
        b.addTarget(self, action: #selector(addWP), for: .touchUpInside)
        
        let b2 = UIButton(frame: CGRect(x: self.view.bounds.width / 2 + 10, y: label.frame.maxY + 10, width: self.view.bounds.width / 2 - 20, height: 35))
        b2.setTitleColor(.blue, for: .normal)
        b2.setTitle("Cancel", for: .normal)
        b2.addTarget(self, action: #selector(cancelWP), for: .touchUpInside)
        
        wView.addSubview(label)
        wView.addSubview(b)
        wView.addSubview(b2)
        self.view.addSubview(wView)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("Being called")
        if let searchBarText = textField.text{
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = searchBarText
            request.region = mapView.region
            let search = MKLocalSearch(request: request)
            search.start { response, _ in
                guard let response = response else {
                    return
                }
                self.matchingItems = response.mapItems
                self.tableView.reloadData()
            }
        }
        return true
    }
    
    func centerMap(location: CLLocation)
    {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    func dropPinZoomIn(placemark:MKPlacemark){
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        mapView.addAnnotation(annotation)
        if let location = placemark.location
        {
            centerMap(location: location)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchBar.text!)
        textField.resignFirstResponder()
        return true
    }
    
    @objc func backPressed()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func addWP()
    {
        print("add trip pressed")
//        wView.removeFromSuperview()
////        self.view.addSubview(tableView)
//        var prevWP = theTrip.waypoints
//        let tripName = theTrip.tripname
//        prevWP?.append(selectedWP)
//        let viewContext = store.persistentContainer.viewContext
//        let newTrip = NSEntityDescription.insertNewObject(forEntityName: "Trip", into: viewContext) as! Trip
//        newTrip.tripname = tripName
//        newTrip.waypoints = prevWP
//        viewContext.delete(theTrip)
        theTrip.addWP(mapItem: selectedWP)
        store.saveContext()
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func cancelWP()
    {
        print("add trip pressed")
        wView.removeFromSuperview()
        self.view.addSubview(tableView)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.matchingItems.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.matchingItems[indexPath.row]
        self.selectedWP = item
        let placeMark = item.placemark
        dropPinZoomIn(placemark: placeMark)
        selectedWPView(place: item)
        print(placeMark.coordinate)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WayPointCell()
        //cell.nameOfWP.text = "Vantaggio"
        cell.nameOfWP.text = self.matchingItems[indexPath.row].name
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}



