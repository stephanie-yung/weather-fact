//
//  LocationViewController.swift
//  weather-fact
//
//  Created by Stephanie Yung on 11/7/21.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController , UITableViewDataSource, UISearchBarDelegate, CLLocationManagerDelegate{
//    var data = [String]() //let = constant
    var data = ["New York", "Jersey City", "Orlando"]
    var userCity: String?
    var filteredData: [String]!

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var getButton: UIButton!
    let locationManager = CLLocationManager()
    var location: CLLocation?
    
    
    var updatingLocation = false
    var lastLocationError: Error?
    
    //reverse geocoding
    let geocoder = CLGeocoder()
    var placemark: CLPlacemark?
    var performingReverseGeocoding = false
    var lastGeocodingError: Error?
    
    var timer: Timer?
    
    //self = class I am in
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        searchBar.delegate = self
        filteredData = data //initialize filteredData
        
        //        placemark = nil
//        lastGeocodingError = nil
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    //MARK: - Actions
    @IBAction func getLocation(){
        let authStatus = locationManager.authorizationStatus
        if authStatus == .notDetermined{
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        if authStatus == .denied || authStatus == .restricted{
            showLocationServicesDeniedAlert()
            return
        }
        
        if updatingLocation{
            stopLocationManager()
        }
        else{
            location = nil
            lastLocationError = nil
            startLocationManager()
        }
        
        tableView.reloadData()
    }
    
    //MARK: - CLLocationManagerDelegate
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ){
        print("didFailWithError \(error.localizedDescription)")
        
        if (error as NSError).code == CLError.locationUnknown.rawValue{
            return
        }
        lastLocationError = error
        stopLocationManager()
    }

    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ){
        let newLocation = locations.last!
        print("didUpdateLocations \(newLocation)")

        //1
        if newLocation.timestamp.timeIntervalSinceNow < -5 {
            return
        }

        //2
        if newLocation.horizontalAccuracy < 0 {
            return
        }

        var distance = CLLocationDistance(Double.greatestFiniteMagnitude)
        if let location = location{
            distance = newLocation.distance(from: location)
        }

        //3
        if location == nil || location!.horizontalAccuracy > newLocation.horizontalAccuracy{

            //4
            lastLocationError = nil
            location = newLocation


            //5
            if newLocation.horizontalAccuracy <= locationManager.desiredAccuracy{
                print("**We're done!")
                stopLocationManager()

                if distance > 0{
                    performingReverseGeocoding = false
                }

            }

            if !performingReverseGeocoding {
                print("** Going to geocode")
                performingReverseGeocoding = true

                geocoder.reverseGeocodeLocation(newLocation){
                    placemarks, error in

                    //MARK: geocoding closure
                    self.lastGeocodingError = error
                    if error == nil, let places = placemarks, !places.isEmpty{
                        self.placemark = places.last!
                    }
                    else{
                        self.placemark = nil
                    }

                    self.performingReverseGeocoding = false
//                    address = string(from: placemark)
                    print("PLACEMARK LOCALITY")
                    print(self.placemark?.locality as Any) //city
                    self.userCity = self.placemark?.locality
                    print(type(of: self.userCity))
                    print(self.data)
                    self.data.append(self.userCity!)
                    print(self.data)
//                    print(self.placemark?.administrativeArea) //state
//                    print(self.placemark?.postalCode) //zip code
                }
            }
            else if distance < 1{
                let timeInterval = newLocation.timestamp.timeIntervalSince(location!.timestamp)
                if timeInterval > 10{
                    print("** Force done!")
                    stopLocationManager()

                }
            }


        }
        location = newLocation
        lastLocationError = nil
//        updateLabels()
    }
    

    func startLocationManager(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            updatingLocation = true
            
            timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(didTimeOut), userInfo: nil, repeats: false)
        }
    }
    
    
    func stopLocationManager(){
        if updatingLocation{
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            updatingLocation = false
            if let timer = timer{
                timer.invalidate()
            }
        }
    }
    
    //MARK: - Helper Methods
    func showLocationServicesDeniedAlert(){
        let alert = UIAlertController(
            title: "Location Services Disabled",
            message: "Please enable location services for this app in Settings.",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
            
        )
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func didTimeOut(){
        print("** Time out")
        if location == nil{
            stopLocationManager()
            lastLocationError = NSError(domain: "MyLocationsErrorDomain", code: 1, userInfo: nil)
        }
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//
        cell.textLabel?.text = self.data[indexPath.row]

        return cell
    }
    
    //MARK: - Search Bar Config
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        <#code#>
//    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
