//
//  SnapVC.swift
//  SnapchatCloneFirebase
//
//  Created by Furkan Bingöl on 15.07.2023.
//

import UIKit
import ImageSlideshow

final class SnapVC: UIViewController {

    // MARK: - UI Elements
    @IBOutlet weak var timeLabel: UILabel!
    private var imageSlideShow: ImageSlideshow? = nil

    
    // MARK: - Properties
    var selectedSnap: Snap?
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let snap = selectedSnap {
                
            // For Time Label
            timeLabel.text = "Time Left: \(snap.timeDifference) hours"
            
            // For ImageSlider
            var inputImageArray = [KingfisherSource]()
            for imageUrl in snap.imageUrlArray {
                inputImageArray.append(KingfisherSource(urlString: imageUrl)!)
            }
            
            self.imageSlideShow = ImageSlideshow(frame: CGRect(x: 10,
                                                              y: 10,
                                                              width: self.view.frame.width * 0.95,
                                                              height: self.view.frame.height * 0.9))
            self.imageSlideShow!.backgroundColor = .white
            self.imageSlideShow!.contentScaleMode = .scaleAspectFit
            self.imageSlideShow!.circular = false
            let pageIndicator = UIPageControl()
            pageIndicator.currentPageIndicatorTintColor = .black
            pageIndicator.pageIndicatorTintColor = .lightGray
            imageSlideShow!.pageIndicator = pageIndicator
            
            imageSlideShow?.setImageInputs(inputImageArray)
            view.addSubview(self.imageSlideShow!)
            self.view.bringSubviewToFront(timeLabel)        // Time Label'i ÖNE GETİRDİK!
        }
    }
    
    
    // MARK: - Functions
    


}
