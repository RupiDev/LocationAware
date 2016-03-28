//
//  ViewController.swift
//  LocationAware
//
//  Created by Rupin Bhalla on 1/2/16.
//  Copyright © 2016 Rupin Bhalla. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation



class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate
{
    var locationManager = CLLocationManager();
    
    @IBOutlet weak var informationLabel: UILabel!
    
    @IBOutlet weak var map: MKMapView!
    
    var address = "";

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.requestWhenInUseAuthorization();
        locationManager.startUpdatingLocation();
        
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
       
    }
    
    func getCurrentAddress(let location: CLLocation) -> String
    {
        let geoCoder = CLGeocoder();
        
        
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) -> Void in
            
            if(error != nil)
            {
                print(error);
            }
            else
            {
                if let p = placemarks?.first
                {
                    //print(p)
                    self.address = p.subThoroughfare! + " " + p.thoroughfare! + " \n" + p.locality! + " " + p.postalCode! + " " + p.country!
                }
            }
            
            
        }
        return address;
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        print(locations[0]);
        print("")
        
        var userLocation: CLLocation = locations[0];
        
        let latitude: CLLocationDegrees = userLocation.coordinate.latitude;
        
        let longitude: CLLocationDegrees = userLocation.coordinate.longitude;
        
        let latDelta: CLLocationDegrees = 0.01;
        
        let longDelta: CLLocationDegrees = 0.01;
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta);
        
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span);
        
    
        
        
        map.setRegion(region, animated: true);
        
        let course = userLocation.course;
        let altitude = userLocation.altitude;
        let speed = userLocation.speed;
        
        let latitudeText = String(format: "%.2f", latitude);
        let longitudeText = String(format: "%.2f", longitude);
        let courseText = String(format: "%.2f", course);
        let altitudeText = String(format: "%.2f", altitude)
        let speedText = String(format: "%.2f", speed)
        
        let address = getCurrentAddress(userLocation);
        print(address);
        
        
        //informationLabel.text = "The latitude is \(latitude)\n";
        
        informationLabel.text = "The latitude is \(latitudeText)\n"
        informationLabel.text! += "The longitude is \(longitudeText)\n"
        informationLabel.text! += "The course is \(courseText)\n"
        informationLabel.text! += "The altitude is \(altitudeText)\n"
        informationLabel.text! += "The speed is \(speedText)\n"
        informationLabel.text! += "The current address is \(address)";
        
    }
    
    


}

