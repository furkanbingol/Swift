//
//  ViewController2.swift
//  ViewControllerLifecycle
//
//  Created by Furkan Bingöl on 17.02.2023.
//

import UIKit

class PurpleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("PurpleViewController - viewDidLoad()")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("PurpleViewController - viewWillAppear()")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("PurpleViewController - viewDidAppear()")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("PurpleViewController - viewWillDisappear()")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("PurpleViewController - viewDidDisappear()")
    }
    
}
