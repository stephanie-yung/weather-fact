//
//  ForecastTableViewCell.swift
//  weather-fact
//
//  Created by Stephanie Yung on 11/28/21.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        dayLabel.text = "Monday11"
        // Configure the view for the selected state
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sevenForecast")

        // Configure YourCustomCell using the outlets that you've defined.

        return cell!
    }

}
