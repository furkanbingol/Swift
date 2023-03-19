import UIKit

// Main Thread -- Background Thread

DispatchQueue.main.async {
    // Main Queue'da: INTERFACE,UI Operations gerçekleşir.
    foo()
}


// qos: Quality of Service
DispatchQueue.global(qos: .background).async {
    // fetch data from API
    
    DispatchQueue.main.async {
        // update ui
    }
}

func foo() {
    print("Hello")
}
