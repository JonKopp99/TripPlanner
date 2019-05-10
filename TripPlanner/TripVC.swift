//
//  TripVC.swift
//  TripPlanner
//
//  Created by Jonathan Kopp on 5/7/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//
import UIKit

class TripVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var tableView = UITableView()
    var theTrip = Trip()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = .white
        
        let label = UILabel()
        label.frame = CGRect(x: 70, y: 30, width: self.view.bounds.width - 120, height: 35)
        label.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        label.font = UIFont(name: "AvenirNext-HeavyItalic", size: 25)
        label.text = theTrip.tripname
        label.textAlignment = .center
        
        
        let b = UIButton(frame: CGRect(x: 0, y: 30, width: 70, height: 35))
        b.setTitle("Back", for: .normal)
        b.titleLabel?.sizeToFit()
        b.setTitleColor(.blue, for: .normal)
        b.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        
        self.view.addSubview(b)
        self.view.addSubview(label)
        
        tableView.register(WayPointCell.self, forCellReuseIdentifier: "wpcell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: label.frame.maxY, width: self.view.bounds.width, height: self.view.bounds.height - label.frame.maxY)
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        createHeader()
        tableView.reloadData()
    }
    @objc func backPressed()
    {
        self.dismiss(animated: true, completion: nil)
    }
    func createHeader()
    {
        let hview = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height * 0.4))
        let label = UILabel()
        label.frame = CGRect(x: 20, y: self.view.bounds.height * 0.2, width: self.view.bounds.width - 40, height: 35)
        label.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        label.font = UIFont(name: "AvenirNext-HeavyItalic", size: 25)
        label.text = theTrip.tripname
        label.textAlignment = .center
        let b = UIButton(frame: CGRect(x: 10, y: label.frame.maxY + 20, width: self.view.bounds.width - 20, height: 35))
        b.setTitleColor(.blue, for: .normal)
        b.setTitle("Add more waypoints?", for: .normal)
        b.addTarget(self, action: #selector(addWP), for: .touchUpInside)
        if let wps = theTrip.waypoints
        {
            if(wps.count < 1)
            {
                label.text = "You haven't added any waypoints to your trip."
                b.setTitle("Get Started", for: .normal)
            }
        }
        
        hview.addSubview(label)
        hview.addSubview(b)
        tableView.tableHeaderView = hview
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.view.bounds.height * 0.4
    }
    @objc func addWP()
    {
        print("add trip pressed")
        self.present(WaypointVC(), animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let wps = theTrip.waypoints
        {
            return wps.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = WaypointVC()
        vc.theTrip = self.theTrip
        self.present(vc, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WayPointCell()
        if let wp = theTrip.waypoints{
            cell.nameOfWP.text = wp[indexPath.row].name
        }
        return cell
    }
}


