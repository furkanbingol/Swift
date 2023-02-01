//
//  ViewController.swift
//  P04-MapJournal
//
//  Created by Furkan Bingöl on 30.01.2023.
//

import UIKit
import MapKit         //Map görünümü için
import CoreData       //Veritabanı için
import CoreLocation   //Kullanıcının locationunu almak için

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self    //View Controller'ımıza delegasyon hakkı veriyoruz. Bu sayede bu classlardaki fonksiyonları kullanabilir hale geleceğiz.
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()     //App'i kullandığımızda yetki isteyecek
        locationManager.startUpdatingLocation()
        
        //Gesture Recognizers
        let gr = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))    //Kullanıcı uzun basarsa bu recognizer çalışacak
        gr.minimumPressDuration = 2    //2 sn basarsa, pinleyecek
        mapView.addGestureRecognizer(gr)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //locations --> dizi
        let lc = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)    //ENLEM, BOYLAM
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)   //Zoom
        let region = MKCoordinateRegion(center: lc, span: span)
        
        mapView.setRegion(region, animated: true)
    }
    
    
    @objc func chooseLocation(gestureRecognizer: UILongPressGestureRecognizer) {
        
        
        
    }

}

