//
//  HomeTableViewCell.swift
//  BoldTest
//
//  Created by Carlos Villamizar on 9/3/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    static let reuseIdentifier = "SearchLocationQueryCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configUI(locations: SearchLocationModel.GetSearchLocationQuery.Response) {
        titleLabel.text = locations.title
        cityLabel.text = locations.location_type
    }

    
}
