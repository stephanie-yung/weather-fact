//
//  SevenDayWeatherTableViewCell.swift
//  weather-fact
//
//  Created by Stephanie Yung on 11/13/21.
//

import UIKit

class SevenDayWeatherTableViewCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate{


//    @IBOutlet weak var tableView: UITableView!
    var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dayLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "sevenDayCell")
        tableView.dataSource = self
        tableView.delegate = self
        // Configure the view for the selected state
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
       return "7 Day Forecast!"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return self.days.count
        return 7
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(
//            withIdentifier: "sevenForecast",
//            for: indexPath)
        let cell = UITableViewCell()

//        cell.textLabel?.text = self.days[indexPath.row]
        cell.textLabel?.text = "This is row \(indexPath.row)"

        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }



}
