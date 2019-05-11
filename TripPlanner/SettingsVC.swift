//
//  SettingsVC.swift
//  TripPlanner
//
//  Created by Jonathan Kopp on 5/11/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation
import UIKit

class SettingsVC: UIViewController, UITextFieldDelegate{
    var xLoc = UITextField()
    var yLoc = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let label = UILabel()
        label.frame = CGRect(x: 20, y: 35, width: self.view.bounds.width - 40, height: 25)
        label.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        label.font = UIFont(name: "AvenirNext-HeavyItalic", size: 25)
        label.text = "Settings"
        label.textAlignment = .center
        
        let b = UIButton(frame: CGRect(x: 5, y: 30, width: 60, height: 35))
        b.setTitle("Back", for: .normal)
        b.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        b.setTitleColor(.blue, for: .normal)
        
        self.view.addSubview(b)
        self.view.addSubview(label)
        
        setUpLocationView()
    }
    
    func setUpLocationView()
    {
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 80, width: self.view.bounds.width - 20, height: 25)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Bold", size: 25)
        label.text = "Enter your default location!"
        label.textAlignment = .center
        self.view.addSubview(label)
        
        xLoc.frame = CGRect(x: 10, y: 150, width: self.view.bounds.width - 20, height: 40)
        xLoc.placeholder = "Longitude"
        xLoc.delegate = self
        xLoc.returnKeyType = .done
        xLoc.textAlignment = .center
        xLoc.layer.cornerRadius = 10
        xLoc.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        xLoc.layer.borderWidth = 2.5
        self.view.addSubview(xLoc)
        
        yLoc.frame = CGRect(x: 10, y: 200, width: self.view.bounds.width - 20, height: 40)
        yLoc.placeholder = "Latitude"
        yLoc.delegate = self
        yLoc.returnKeyType = .done
        yLoc.textAlignment = .center
        yLoc.layer.cornerRadius = 10
        yLoc.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        yLoc.layer.borderWidth = 2.5
        self.view.addSubview(yLoc)
        
        
        let userDefaults = Foundation.UserDefaults.standard
        if let xT = userDefaults.string(forKey: "xLoc")
        {
            if let yT = userDefaults.string(forKey: "yLoc")
            {
                if(!xT.isEmpty && !yT.isEmpty)
                {
                    xLoc.placeholder = xT
                    yLoc.placeholder = yT
                }
            }
        }
        
        let b = UIButton(frame: CGRect(x: 10, y: 250, width: self.view.bounds.width - 20, height: 40))
        b.setTitle("Done", for: .normal)
        b.addTarget(self, action: #selector(donePressed), for: .touchUpInside)
        b.setTitleColor(.blue, for: .normal)
        
        self.view.addSubview(b)
    }
    
    @objc func donePressed()
    {
        if let xT = xLoc.text{
            if let yT = yLoc.text{
                print(xT,yT)
                let userDefaults = Foundation.UserDefaults.standard
                if(!xT.isEmpty && !yT.isEmpty)
                {
                    userDefaults.set(xT, forKey: "xLoc")
                    userDefaults.set(yT, forKey: "yLoc")
                }
            }
        }
    }
    @objc func backPressed()
    {
        self.dismiss(animated: true, completion: nil)
    }
}
