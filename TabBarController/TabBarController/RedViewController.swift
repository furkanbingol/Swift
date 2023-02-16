//
//  RedViewController.swift
//  TabBarController
//
//  Created by Furkan Bingöl on 16.02.2023.
//

import UIKit

class RedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Programatic olarak tabBarItem'ların badge değeleri değiştirilebilir.
        tabBarItem.badgeValue = "1"
        tabBarItem.badgeColor = .blue
        
        //Badge'in görünmemesini istiyorsanız değerini 'nil' olarak atamalısınız.
        tabBarItem.badgeValue = nil
    }

}
