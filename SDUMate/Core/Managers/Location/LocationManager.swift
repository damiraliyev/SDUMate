//
//  LocationManager.swift
//  BePRO
//
//  Created by Yessenali Zhanaidar on 29.07.2023.
//
import CoreLocation

protocol ILocationManagerDelegate: AnyObject {
    func locationDidUpdate(to location: CLLocation)
    func locationAccessDenied()
}

protocol ILocationManager: AnyObject {
    var delegate: ILocationManagerDelegate? { get set }
    func requestLocation()
}

final class LocationManager: NSObject, ILocationManager {
    
    weak var delegate: ILocationManagerDelegate?
    private var manager: CLLocationManager
    
    init(manager: CLLocationManager) {
        self.manager = manager
        super.init()
        manager.delegate = self
    }
    
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            status = manager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        case .notDetermined:
            break
        default:
            manager.stopUpdatingLocation()
            delegate?.locationAccessDenied()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        delegate?.locationDidUpdate(to: location)
    }
}

