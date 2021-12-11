//
//  MainPageViewController.swift
//  weather-fact
//
//  Created by Stephanie Yung on 11/7/21.
//

import UIKit

class MainPageViewController: UIViewController , UITableViewDataSource{
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureHighLabel: UILabel!
    @IBOutlet weak var temperatureLowLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "mainpage")
        tableView.dataSource = self
        
        locationLabel.text = "New York"
        temperatureLabel.text = "67°"
        temperatureHighLabel.text = "72°"
        temperatureLowLabel.text = "53°"
        precipitationLabel.text = "20%"
        weatherConditionLabel.text = "Partly Cloudy"
        quoteLabel.text = "The answer to the Ultimate Question of Life, the Universe, and Everything is 42"
        // Do any additional setup after loading the view.
        
        //api
        let headers = [
            "x-rapidapi-host": "weatherapi-com.p.rapidapi.com",
            "x-rapidapi-key": "31b15844femsh5871d44730f7f47p1d491djsn846fb4398848"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://weatherapi-com.p.rapidapi.com/search.json?q=New%20York")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            }
            else {
                print("THIS IS WEATHER API: \(data)")
                do{
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any]{
                        print("json variable ",json)

                    }
                }
                catch{
                    print("JSONSERIALIZAITION ERROR:")
                }
                let httpResponse = response as? HTTPURLResponse
//                print(httpResponse)
            }
        })

        dataTask.resume()
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.days.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "mainpage",
            for: indexPath)

        cell.textLabel?.text = self.days[indexPath.row]

        return cell
        
        
    }

}
