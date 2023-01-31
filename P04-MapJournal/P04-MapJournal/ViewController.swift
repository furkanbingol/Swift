//
//  ViewController.swift
//  P04-MapJournal
//
//  Created by Furkan Bingöl on 30.01.2023.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
    }


}

