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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(TripCell.self, forCellReuseIdentifier: "tripcell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        createHeader()
        tableView.reloadData()
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
        self.present(CreateTrip(), animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.present(TripVC(), animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TripCell()
        cell.nameOfTrip.text = "San Francisco"
        return cell
    }
}

