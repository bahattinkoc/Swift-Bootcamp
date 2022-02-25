//
//  MapViewController.swift
//  week7
//
//  Created by Bahattin Koç on 19.02.2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var lastLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkLocationService()
    }
    
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func showUserLocationCenterMap(){
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 100, longitudinalMeters: 100)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationService(){
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // MARK: Kullanıcıyı ayarlardan konum servisini açmak için yönlendir
        }
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus(){

        case .notDetermined: // ilk defa uygulamayı açtığı zaman
            print("not Determined")
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            print("restricted")
            break
        case .denied:
            print("denied")
            break
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            trackingLocation()
            break
        }
    }
    
    func trackingLocation(){
        mapView.showsUserLocation = true
        showUserLocationCenterMap()
        locationManager.startUpdatingLocation()
        lastLocation = getCenterLocation(mapView: mapView)
    }
    
    func getCenterLocation(mapView: MKMapView) -> CLLocation{
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}

extension MapViewController: CLLocationManagerDelegate{
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}

extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(mapView: mapView)
        let geoCoder = CLGeocoder()
        
        guard let lastLocation = lastLocation else { return }
        guard center.distance(from: lastLocation) > 30 else { return }
        
        self.lastLocation = center
        geoCoder.reverseGeocodeLocation(center) { [weak self] placeMarks, error in
            guard let self = self else { return }
            if let error = error {
                print("\(error)")
                return
            }
            
            guard let placemark = placeMarks?.first else {return}
            let city = placemark.locality ?? "City"
            let street = placemark.thoroughfare ?? "Street"
            
            self.addressLabel.text = "\(city) - \(street)"
        }
    }
}
