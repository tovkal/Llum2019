//
//  ViewController.swift
//  Llum2019
//
//  Created by Andrés Pizá Bückmann on 14/02/2019.
//  Copyright © 2019 Andrés Pizá Bückmann. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CoreLocation
import RxCoreLocation
import MapKit

class ViewController: UIViewController {

    // Views

    @IBOutlet private var mapView: MKMapView!

    // Location

    private lazy var locationManager = CLLocationManager()

    private let bag = DisposeBag()
    private var selectedPlace: Place?

    override func viewDidLoad() {
        super.viewDidLoad()

        downloadData()
        configLocation()
        configureMap()
    }

    private func downloadData() {
        guard let url = URL(string: "https://www-lameva.barcelona.cat/santaeulalia/json-mapa-instalacions") else {
            fatalError("Keep it real (the url) maaaan")
        }

        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else { return }
            guard let placesResponse = try? JSONDecoder().decode(PlacesResponse.self, from: data) else {
                return
            }

            DispatchQueue.main.async {
                self?.displayPlacesInMap(placesResponse.places)
            }
        }
        .resume()
    }

    private func configLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.rx.location
            .filter { $0 != nil }
            .map { $0! }
            .take(1)
            .subscribe(onNext: { [unowned self] (location) in
                let camera = MKMapCamera(lookingAtCenter: location.coordinate,
                                         fromDistance: 1000,
                                         pitch: 0,
                                         heading: 0)
                self.mapView.setCamera(camera, animated: true)
            })
            .disposed(by: bag)
    }

    private func configureMap() {
        mapView.showsUserLocation = true
        mapView.delegate = self
        mapView.register(CalloutView.self, forAnnotationViewWithReuseIdentifier: "place")
    }

    private func displayPlacesInMap(_ places: [Place]) {
        places.forEach { mapView.addAnnotation(PlaceAnnotation(place: $0)) }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? PlaceDetailsViewController, let place = self.selectedPlace else { return }
        vc.display(place)
    }
}

extension ViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is PlaceAnnotation else { return nil }

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "place")

        if annotationView == nil {
            annotationView = CalloutView(annotation: annotation, reuseIdentifier: "place")
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? PlaceAnnotation else { return }
        selectedPlace = annotation.place
        performSegue(withIdentifier: "details", sender: self)
    }
}
