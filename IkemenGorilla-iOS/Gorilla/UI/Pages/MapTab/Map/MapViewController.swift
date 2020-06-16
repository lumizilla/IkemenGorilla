//
//  MapViewController.swift
//  Gorilla
//
//  Created by admin on 2020/06/16.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import MapKit

final class MapViewController: UIViewController, View, ViewConstructor {
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    let mapView = MKMapView()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
        setupMap()
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        view.addSubview(mapView)
    }
    
    func setupViewConstraints() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupMap() {
        mapView.delegate = self
    }
    
    // MARK: - Bind Method
    func bind(reactor: MapReactor) {
        // Action
        reactor.action.onNext(.loadZoos)
        
        // State
        reactor.state.map { $0.zoos }
            .distinctUntilChanged()
            .bind { [weak self] zoos in
                for zoo in zoos {
                    let pointAnnotation = PointZooAnnotation(zoo: zoo)
                    let lat = zoo.latitude
                    let lon = zoo.longitude
                    pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                    pointAnnotation.title = zoo.name
                    self?.mapView.addAnnotation(pointAnnotation)
                }
            }
            .disposed(by: disposeBag)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKPointAnnotation {
            let markerAnnotation = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "marker")
            markerAnnotation.displayPriority = .required
            markerAnnotation.clusteringIdentifier = "id"
            markerAnnotation.canShowCallout = true
            
            return markerAnnotation
        }
        return nil
    }
}
