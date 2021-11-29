//
//  MainPageViewController.swift
//  weather-fact
//
//  Created by Stephanie Yung on 11/7/21.
//

import UIKit

class MainPageViewController: UIViewController , UITableViewDataSource{

    @IBOutlet var tableView: UITableView!
    var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "mainpage")
        tableView.dataSource = self
        // Do any additional setup after loading the view.
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
