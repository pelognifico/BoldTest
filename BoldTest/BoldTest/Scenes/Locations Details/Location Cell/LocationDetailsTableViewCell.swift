//
//  LocationDetailsTableViewCell.swift
//  BoldTest
//
//  Created by Carlos Villamizar on 9/3/22.
//

import UIKit
import Foundation

class LocationDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateDayLabel: UILabel!
    @IBOutlet weak var theTempDegreeLabel: UILabel!
    @IBOutlet weak var theTemImageView: BTImageView!
    
    static let reuseIdentifier = "SearchLocationQueryCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func confiUI(dateTemp : LocationsDetailsModel.GetLocationsDetails.ViewModel, indexArray : Int, abbr: Bool){
        
        let applicableDate = indexArray + 1
        let logoTemp = dateTemp.consolidatedWeather?.consolidatedWeather?[applicableDate].weather_state_abbr
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "EEEE, MMMM d, yyyy"
        
        if let date = dateFormatterGet.date(from: (dateTemp.consolidatedWeather?.consolidatedWeather?[applicableDate].applicable_date)!) {
            print(dateFormatterPrint.string(from: date))
            dateDayLabel.text = dateFormatterPrint.string(from: date)
        } else {
           print("There was an error decoding the string")
        }
        
        theTemImageView.setImage(urlString: "https://www.metaweather.com/static/img/weather/png/\(logoTemp ?? "").png", imageView: theTemImageView)
        
        if let theTem = dateTemp.consolidatedWeather?.consolidatedWeather?[indexArray].the_temp {
            let theTemInt =  Int(theTem)
            theTempDegreeLabel.text = "\(theTemInt)°"
        }
        
        if abbr {
            dateDayLabel.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            theTempDegreeLabel.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        } else {
            dateDayLabel.textColor = .white
            theTempDegreeLabel.textColor = .white
        }
    }
    
}
