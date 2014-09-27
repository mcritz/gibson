//
//  ViewController.swift
//  RotateImageTest
//
//  Created by Prashanth Reddy Kambalapally on 9/27/14.
//  Copyright (c) 2014 SimpleSolutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var radarBackground: UIImageView!
    @IBOutlet var radarRotator: UIImageView!
    var timer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "animate", userInfo: nil, repeats: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func animate() {
        self.rotateImage(self.radarRotator)
    }
    
    func rotateImage(imageView:UIImageView){
        UIView.animateWithDuration(1.0, delay: 0, options: .CurveLinear | .BeginFromCurrentState, animations: {
            var radarRotatorFrame = imageView.frame
             imageView.transform = CGAffineTransformRotate(imageView.transform, CGFloat(M_PI/2))
            }, completion: {
                finished in

        })
       
    }

}

