//
//  ViewController.swift
//  TripPlanner
//
//  Created by Jonathan Kopp on 5/7/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var tableView = UITableView()
    var store: CoreDataStack!
    var trips: [Trip]!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(TripCell.self, forCellReuseIdentifier: "tripcell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        tableView.separatorStyle = .none
        
        //tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchTrips()
    }
    func createHeader()
    {
        let hview = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 35))
        let label = UILabel()
        label.frame = CGRect(x: 20, y: 0, width: self.view.bounds.width - 40, height: 35)
        label.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        label.font = UIFont(name: "AvenirNext-HeavyItalic", size: 25)
        label.text = "Planned Trips"
        label.textAlignment = .center
        let b = UIButton(frame: CGRect(x: self.view.bounds.width - 40, y: 0, width: 35, height: 35))
        b.setImage(#imageLiteral(resourceName: "icons8-plus-64"), for: .normal)
        b.addTarget(self, action: #selector(addTrip), for: .touchUpInside)
        
        hview.addSubview(label)
        hview.addSubview(b)
        //hview.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).withAlphaComponent(0.8)
        tableView.tableHeaderView = hview
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.view.bounds.height * 0.1
    }
    @objc func addTrip()
    {
        print("add trip pressed")
        let vc = CreateTrip()
        vc.store = self.store
        self.present(vc, animated: true, completion: nil)
    }
    func fetchTrips()
    {
        self.store.fetchPersistedData {
            
            (fetchItemsResult) in
            
            switch fetchItemsResult {
            case let .success(items):
                self.trips = items
            case .failure(_):
                self.trips.removeAll()
            }
            // reload the collection view's data source to present the current data set to the user
            self.tableView.reloadData()
            self.view.addSubview(self.tableView)
            self.createHeader()
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let item = self.trips[indexPath.row]
            store.persistentContainer.viewContext.delete(item)
            store.saveContext()
            trips.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TripVC()
        vc.theTrip = self.trips[indexPath.row]
        vc.store = self.store
        self.present(vc, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TripCell()
        cell.nameOfTrip.text = trips[indexPath.row].tripname
        return cell
    }
}

