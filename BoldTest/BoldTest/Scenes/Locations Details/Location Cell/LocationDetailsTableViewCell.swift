//
//  LocationDetailsTableViewCell.swift
//  BoldTest
//
//  Created by UnLimited on 9/3/22.
//

import UIKit

class LocationDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateDayLable: UILabel!
    @IBOutlet weak var theTempDegreeLabel: UILabel!
    @IBOutlet weak var theTemImageView: LHImageView!
    
    static let reuseIdentifier = "SearchLocationQueryCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func confiUI(dateTemp : LocationsDetailsModel.GetLocationsDetails.ViewModel, indexArray : Int, abbr: Bool){
        
        let applicableDate = indexArray + 1
        let logoTemp = dateTemp.consolidatedWeather?.consolidatedWeather?[applicableDate].weather_state_abbr
        
        dateDayLable.text = dateTemp.consolidatedWeather?.consolidatedWeather?[applicableDate].applicable_date
        
        theTemImageView.setImage(urlString: "https://www.metaweather.com/static/img/weather/png/\(logoTemp ?? "").png", imageView: theTemImageView)
        
        if let theTem = dateTemp.consolidatedWeather?.consolidatedWeather?[indexArray].the_temp {
            let theTemInt =  Int(theTem)
            theTempDegreeLabel.text = "\(theTemInt)°"
        }
        
        if abbr {
            dateDayLable.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            theTempDegreeLabel.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        } else {
            dateDayLable.textColor = .white
            theTempDegreeLabel.textColor = .white
        }
    }
    
}
