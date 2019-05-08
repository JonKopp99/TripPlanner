//
//  WayPointCell.swift
//  TripPlanner
//
//  Created by Jonathan Kopp on 5/7/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation
import UIKit

class WayPointCell: UITableViewCell{
    
    var nameOfWP = UILabel()
    override func layoutSubviews() {
        
        
        nameOfWP.frame = CGRect(x: 15, y: 10, width: frame.width - 30, height: 50)
        nameOfWP.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        nameOfWP.font = UIFont(name: "AvenirNext-BoldItalic", size: 25)
        
        self.addSubview(nameOfWP)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

