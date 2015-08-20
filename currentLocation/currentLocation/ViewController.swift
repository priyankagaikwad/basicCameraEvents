//
//  ViewController.swift
//  currentLocation
//
//  Created by Priyanka Gaikwad on 17/08/15.
//  Copyright © 2015 Priyanka Gaikwad. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
   
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lblAddress.hidden = true
    }

    @IBAction func findMyLocation(sender: AnyObject) {
        print("find me")
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    //delegates for CLLocationManager
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        //CLLocation *newLocation = locations[[locations count] -1];
        let currentLocation: CLLocation = location!;
        print(currentLocation.coordinate.latitude)
        print(currentLocation.coordinate.longitude)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location!.coordinate,
            1000 * 2.0, 1000 * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)

        let geoCoder = CLGeocoder()
//        let location1 = CLLocation(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
//        print(location1)
        var addrString :String = ""
        geoCoder.reverseGeocodeLocation(location!, completionHandler: { (placemarks, error) in
            let placeArray = placemarks
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placeArray?[0]
            
            // Address dictionary
            //print(placeMark.addressDictionary)
            
            // Location name
            if let locationName:NSString = placeMark.addressDictionary?["Name"] as? NSString {
                print("Location name : \(locationName)")
                addrString = locationName as String
            }
            
            // Street address
            if let street = placeMark.addressDictionary?["Thoroughfare"] as? NSString {
                print("Street : \(street)")
               // addrString = addrString + ", \(street)"
            }
            
            // City
            if let city = placeMark.addressDictionary?["City"] as? NSString {
                print("City : \(city)")
                addrString = addrString + ", \(city)"

            }
            
            // Zip code
            if let zip = placeMark.addressDictionary?["ZIP"] as? NSString {
                print("Zip : \(zip)")
            }
            
            // Country
            if let country = placeMark.addressDictionary?["Country"] as? NSString {
                print("Country : \(country)")
                addrString = addrString + ", \(country)"

            }
            self.lblAddress.hidden = false
            self.lblAddress.text = "\(addrString)"
            UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.lblAddress.alpha = 1.0
                }, completion: nil)
            
        })
        
       // print(currentLocation.description)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            var shouldIAllow = false
            var locationStatus: String;
            switch status {
            case CLAuthorizationStatus.Restricted:
                locationStatus = "Restricted Access to location"
            case CLAuthorizationStatus.Denied:
                locationStatus = "User denied access to location"
            case CLAuthorizationStatus.NotDetermined:
                locationStatus = "Status not determined"
            default:
                locationStatus = "Allowed to location Access"
                shouldIAllow = true
            }
            NSNotificationCenter.defaultCenter().postNotificationName("LabelHasbeenUpdated", object: nil)
            if (shouldIAllow == true) {
                print("Location to Allowed")
                // Start location services
                locationManager.startUpdatingLocation()
            } else {
                print("Denied access: \(locationStatus)")
            }
    }
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("STOP!!! \(error)")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

