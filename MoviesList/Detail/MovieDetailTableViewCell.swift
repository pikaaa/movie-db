//
//  MovieDetailTableViewCell.swift
//  MoviesList
//
//  Created by Priyanka Sabhagani on 24/04/19.
//  Copyright © 2019 Priyanka Sabhagani. All rights reserved.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell{
    
    @IBOutlet weak var cellLabel: UILabel!
    
    func configureCell(label: String){
        cellLabel.text = label
    }
}
