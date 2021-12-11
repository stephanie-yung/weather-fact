//
//  SubWeatherTableViewCell.swift
//  weather-fact
//
//  Created by Stephanie Yung on 12/4/21.
//

import UIKit

class SubWeatherTableViewCell: UITableViewCell {
    var datelabel: String = ""
    var conditionlabel: String = ""
    var lowlabel: Float = 0
    var highlabel: Float = 0
    var precipitationlabel: Float = 0
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var conditionLbl: UILabel!
    @IBOutlet weak var lowLbl: UILabel!
    @IBOutlet weak var highLbl: UILabel!
    @IBOutlet weak var precipLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        dateLbl.text = "dec 2"
        conditionLbl.text = "Cloudy"
        lowLbl.text = "53"
        highLbl.text = "73"
        precipLbl.text = "20%"
        print("datelabel", datelabel)
        dateLbl.text = datelabel
        conditionLbl.text = conditionlabel
        lowLbl.text = "\(lowlabel)"
        highLbl.text = "\(highlabel)"
        precipLbl.text = "\(precipitationlabel)"
    }

}
