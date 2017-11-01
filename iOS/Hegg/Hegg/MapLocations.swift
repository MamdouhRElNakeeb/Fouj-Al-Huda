//
//  MapLocations.swift
//  Hegg
//
//  Created by Mamdouh El Nakeeb on 7/28/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire

class MapLocations: UIViewController, SWRevealViewControllerDelegate {
    
    var camp: Camp = Camp()
    
    let lat = 21.4151678
    let lon = 39.8789227
    let campName = "مخيم شركة فوج الهدى"
    
    var googleMaps: GMSMapView = GMSMapView()
    
    var locationManager = CLLocationManager()
    var locationSelected = Location.startLocation
    
    var locationStart = CLLocation()
    var locationEnd = CLLocation()
    
    var currentLocation = CLLocation()
    
    var campLocations = Array<CLLocation>()
    
    var spinner = UIActivityIndicatorView()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            locationManager.startMonitoringSignificantLocationChanges()
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: camp.latitude, longitude: camp.longitude, zoom: 12)
        googleMaps = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        googleMaps.settings.compassButton = true
        googleMaps.settings.scrollGestures = true
        googleMaps.settings.zoomGestures = true
        
        self.googleMaps.camera = camera
        self.googleMaps.delegate = self
        self.googleMaps.isMyLocationEnabled = true
        self.googleMaps.settings.myLocationButton = true
                
        // Creates a marker in the center of the map.
        
        let marker = GMSMarker()
        let markerIcon = UIImage(named: "markerIcon")!.withRenderingMode(.alwaysTemplate)
        let markerIconView = UIImageView(image: markerIcon)
        markerIconView.tintColor = UIColor.primaryColor()
        markerIconView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        marker.iconView = markerIconView
        
        marker.position = CLLocationCoordinate2D(latitude: camp.latitude, longitude: camp.longitude)
        marker.title = camp.name
        marker.snippet = camp.description
        marker.map = googleMaps
 
        googleMaps.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        self.view.addSubview(googleMaps)
        
        if revealViewController() != nil{
            
            self.revealViewController().delegate = self
            let image = UIImage(named:"sideMenuIcon")?.withRenderingMode(.alwaysTemplate)
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target:  revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            
        }
        
//        let image = UIImage(named:"sideMenuIcon")?.withRenderingMode(.alwaysTemplate)
//
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(SSASideMenu.presentRightMenuViewController))

        self.navigationItem.leftBarButtonItem?.title = "رجوع"
        
        let labelTitle = UILabel()
        labelTitle.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        labelTitle.text = "مواقع الحملة"
        labelTitle.font = UIFont(name: "GE SS Two", size: 17)
        labelTitle.textColor = UIColor.secondryColor()
        self.navigationItem.titleView = labelTitle
        
        
        let whiteNB = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        whiteNB.backgroundColor = UIColor.primaryColor()
        self.view.addSubview(whiteNB)
        
    }
    
    //MARK: - this is function for create direction path, from start location to desination location
    
    func drawPath(startLocation: CLLocation, endLocation: CLLocation)
    {
        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
        let destination = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"
        
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving"
        
        Alamofire.request(url).responseJSON { response in
            
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result as Any)   // result of response serialization
            
            if let result = response.result.value {
                
                let json = result as! NSObject
                
                //print(json)
                
                let routes = json.value(forKey: "routes") as! NSArray
                
                // print route using Polyline
                for route in routes
                {
                    let routeOverviewPolyline = (route as AnyObject).value(forKey: "overview_polyline") as! NSObject
                    
                    let points = routeOverviewPolyline.value(forKey: "points") as! String
                    let path = GMSPath.init(fromEncodedPath: points)
                    let polyline = GMSPolyline.init(path: path)
                    polyline.strokeWidth = 4
                    polyline.strokeColor = UIColor.red
                    polyline.map = self.googleMaps
                }
            }
            
        }
    }
}

extension MapLocations: GMSMapViewDelegate ,  CLLocationManagerDelegate{
    
    // MARK: - GMSMapViewDelegate
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        googleMaps.isMyLocationEnabled = true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        googleMaps.isMyLocationEnabled = true
        
        if (gesture) {
            mapView.selectedMarker = nil
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        googleMaps.isMyLocationEnabled = true
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("COORDINATE \(coordinate)") // when you tapped coordinate
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        googleMaps.isMyLocationEnabled = true
        googleMaps.selectedMarker = nil
        return false
    }

    //MARK: - Location Manager delegates
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error to get location : \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        currentLocation = manager.location!
        
        //		let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
        
        //createMarker(titleMarker: "Lokasi Tujuan", iconMarker: #imageLiteral(resourceName: "mapspin") , latitude: locationTujuan.coordinate.latitude, longitude: locationTujuan.coordinate.longitude)
        
        //createMarker(titleMarker: "Lokasi Aku", iconMarker: #imageLiteral(resourceName: "mapspin") , latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        
        
        //		self.googleMaps?.animate(to: camera)
        //self.locationManager.stopUpdatingLocation()
        
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        
        
        let campLocation = CLLocation(latitude: marker.position.latitude, longitude: marker.position.longitude)
        
        drawPath(startLocation: currentLocation, endLocation: campLocation)
        
    }
    
}

enum Location {
    case startLocation
    case destinationLocation
}



