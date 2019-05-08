//
//  WaypointVC.swift
//  TripPlanner
//
//  Created by Jonathan Kopp on 5/7/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.

import UIKit

class WaypointVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    var tableView = UITableView()
    var searchBar = UITextField()
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
        
       
        let b = UIButton(frame: CGRect(x: self.view.bounds.width - 65, y: 30, width: 60, height: 30))
        b.setTitle("Save", for: .normal)
        b.addTarget(self, action: #selector(addTrip), for: .touchUpInside)
        b.setTitleColor(.blue, for: .normal)
        
        let b2 = UIButton(frame: CGRect(x: 0, y: 30, width: 70, height: 35))
        b2.setTitle("Cancel", for: .normal)
        b2.titleLabel?.sizeToFit()
        b2.setTitleColor(.blue, for: .normal)
        b2.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        
        view.addSubview(label)
        view.addSubview(b)
        view.addSubview(b2)
        
        searchBar.frame = CGRect(x: 10, y: label.frame.maxY, width: self.view.bounds.width * 0.7, height: 50)
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
        tableView.frame = CGRect(x: 0, y: label.frame.maxY + 50, width: self.view.bounds.width, height: self.view.bounds.height / 2 - (label.frame.maxY + 50))
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        tableView.reloadData()
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
    @objc func addTrip()
    {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func addWP()
    {
        print("add trip pressed")
        //self.present(CreateTrip(), animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WayPointCell()
        cell.nameOfWP.text = "Vantaggio"
        return cell
    }
}



