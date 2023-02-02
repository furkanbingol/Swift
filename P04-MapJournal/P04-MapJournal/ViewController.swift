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
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var MyButton: UIButton!
    
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    var selectedTitle = ""
    var selectedTitleID = UUID()
    
    var annotationTitle = ""
    var annotationSubtitle = ""
    var annotationLatitude = Double()
    var annotationLongitude = Double()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self    //View Controller'ımıza delegasyon hakkı veriyoruz. Bu sayede bu classlardaki fonksiyonları kullanabilir hale geleceğiz.
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()     //App'i kullandığımızda yetki isteyecek
        locationManager.startUpdatingLocation()
        
        
        if (selectedTitle != "") {  //Var olan veri gösterilecek
            MyButton.isHidden = true
            MyButton.isEnabled = false
            
            //CoreData
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
            let idString = selectedTitleID.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
            fetchRequest.returnsObjectsAsFaults = false

            do {
                let results = try context.fetch(fetchRequest)
                
                if (results.count > 0) {
                    for result in results as! [NSManagedObject] {
                        if let title = result.value(forKey: "title") as? String {
                            annotationTitle = title
                            
                            if let subtitle = result.value(forKey: "subtitle") as? String {
                                annotationSubtitle = subtitle
                              
                                if let latitude = result.value(forKey: "latitude") as? Double {
                                    annotationLatitude = latitude
                                    
                                    if let longitude = result.value(forKey: "longitude") as? Double {
                                        annotationLongitude = longitude
                                        
                                        //Annotation Ekleme
                                        let annotation = MKPointAnnotation()
                                        annotation.title = annotationTitle
                                        annotation.subtitle = annotationSubtitle
                                        let coordinate = CLLocationCoordinate2D(latitude: annotationLatitude, longitude: annotationLongitude)
                                        annotation.coordinate = coordinate
                                        mapView.addAnnotation(annotation)
                                        
                                        nameText.text = annotationTitle
                                        commentText.text = annotationSubtitle
                                        
                                        locationManager.stopUpdatingLocation()
                                        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
                                        let region = MKCoordinateRegion(center: coordinate, span: span)
                                        mapView.setRegion(region, animated: true)
                                    }
                                }
                            }
                        }
                    }
                }
            } catch {
                print("error!")
            }
        }
        else {  //Yeni veri eklenecek
            MyButton.isHidden = false
            MyButton.isEnabled = true
            
            //Gesture Recognizers
            let gr = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))    //Kullanıcı uzun basarsa bu recognizer çalışacak
            gr.minimumPressDuration = 2    //2 sn basarsa, pinleyecek
            mapView.addGestureRecognizer(gr)
        }
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //locations --> dizi
        
        if (selectedTitle == "") {  //Yeni place eklenecekse
            let lc = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)  //ENLEM,BOYLAM --> Kullanıcının bulunduğu yer
            let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)   //Zoom
            let region = MKCoordinateRegion(center: lc, span: span)
            
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    @objc func chooseLocation(gestureRecognizer: UILongPressGestureRecognizer) {
        
        if (gestureRecognizer.state == .began) {
            
            let touchedPoint = gestureRecognizer.location(in: mapView)
            let touchedCoordinates = mapView.convert(touchedPoint, toCoordinateFrom: mapView)
            
            chosenLatitude = touchedCoordinates.latitude
            chosenLongitude = touchedCoordinates.longitude
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinates
            annotation.title = nameText.text
            annotation.subtitle = commentText.text
            mapView.addAnnotation(annotation)
            
        }
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        //Core Data Operations
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Places", into: context)
        
        newPlace.setValue(UUID(), forKey: "id")
        newPlace.setValue(nameText.text, forKey: "title")
        newPlace.setValue(commentText.text, forKey: "subtitle")
        newPlace.setValue(chosenLatitude, forKey: "latitude")
        newPlace.setValue(chosenLongitude, forKey: "longitude")
        
        //Saving Data
        do{
            try context.save()
        } catch {
            print("error!")
        }
    }
    
}

