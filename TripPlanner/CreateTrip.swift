//
//  CreateTrip.swift
//  TripPlanner
//
//  Created by Jonathan Kopp on 5/7/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation
import UIKit

class CreateTrip: UIViewController, UITextFieldDelegate{
    var textField = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        textField.delegate = self
        
        let label = UILabel()
        label.frame = CGRect(x: 70, y: 30, width: self.view.bounds.width - 120, height: 35)
        label.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        label.font = UIFont(name: "AvenirNext-HeavyItalic", size: 25)
        label.text = "Add Trip"
        label.textAlignment = .center
        
        let b = UIButton(frame: CGRect(x: self.view.bounds.width - 40, y: 30, width: 35, height: 35))
        b.setTitle("Add", for: .normal)
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
        
        textField.frame = CGRect(x: 10, y: self.view.bounds.height / 2, width: self.view.bounds.width - 20, height: 40)
        textField.placeholder = "Trip Name: "
        textField.delegate = self
        textField.returnKeyType = .done
        textField.textAlignment = .center
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textField.layer.borderWidth = 2.5
        self.view.addSubview(textField)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        perform(#selector(addTrip))
        textField.resignFirstResponder()
        return true
    }
    
    @objc func addTrip()
    {
        print(textField.text!)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func backPressed()
    {
        self.dismiss(animated: true, completion: nil)
    }
}
