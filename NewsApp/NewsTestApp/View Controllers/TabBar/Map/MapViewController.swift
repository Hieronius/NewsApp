//
//  MapViewController.swift
//  NewsTestApp
//
//  Created by Арсентий Халимовский on 23.02.2023.
//

import UIKit
import MapKit
import CoreLocation

final class MapViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private let nevaTowerPoint: MKPointAnnotation = {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: MoscowCityBuildings.shared.nevaTower.latitude,
                                                       longitude: MoscowCityBuildings.shared.nevaTower.longtitude)
        return annotation
    }()
    
    private let eyeTowerPoint: MKPointAnnotation = {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: MoscowCityBuildings.shared.eyeTower.latitude,
                                                       longitude: MoscowCityBuildings.shared.eyeTower.longtitude)
        return annotation
    }()
    
    private let eyeTowerSecondPoint: MKPointAnnotation = {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: MoscowCityBuildings.shared.eyeTowerSecond.latitude,
                                                       longitude: MoscowCityBuildings.shared.eyeTowerSecond.longtitude)
        return annotation
    }()
    
    private let towerUnderWaterPoint: MKPointAnnotation = {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: MoscowCityBuildings.shared.towerUnderWater.latitude,
                                                       longitude: MoscowCityBuildings.shared.towerUnderWater.longtitude)
        return annotation
    }()
    
    private let eurasiaPoint: MKPointAnnotation = {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: MoscowCityBuildings.shared.eurasia.latitude,
                                                       longitude: MoscowCityBuildings.shared.eurasia.longtitude)
        return annotation
    }()
    
    private var mapViewPinDefaultImage = UIImage(named: "Vector-8")
    private var pointsArray: [MKPointAnnotation] {
        [eyeTowerPoint, eyeTowerSecondPoint, nevaTowerPoint, eurasiaPoint, towerUnderWaterPoint]
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        setupMapViewConstraints()
        mapView.addAnnotations(pointsArray)
        mapView.delegate = self
        setMapViewRegion()
    }
    
    // MARK: - Private Methods
    
    private func setupMapViewConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    private func setMapViewRegion() {
        mapView.setRegion(MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: MoscowCityBuildings.shared.eurasia.latitude,
                longitude: MoscowCityBuildings.shared.eurasia.longtitude),
            span: MKCoordinateSpan(
                latitudeDelta: 0.01,
                longitudeDelta: 0.01)),
        animated: false)
    }
    
}

// MARK: - Extensions

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.image = mapViewPinDefaultImage
        return annotationView
    }
}
