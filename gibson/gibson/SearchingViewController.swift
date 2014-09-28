//
//  ViewController.swift
//  RotateImageTest
//
//  Created by Prashanth Reddy Kambalapally on 9/27/14.
//  Copyright (c) 2014 SimpleSolutions. All rights reserved.
//

import UIKit

class SearchingViewController: UIViewController {

   
    @IBOutlet weak var radarBackground: UIImageView!
    @IBOutlet weak var searchRadarHorizontalConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var instructionTextLabel: UILabel!
    @IBOutlet weak var radarRotator: UIImageView!
    
    var timer: NSTimer?
    let gibsonLogoImage = UIImage(named: "gibsonLogo").imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.tintColor = UIColor.whiteColor()
        self.logoImageView.image = self.gibsonLogoImage
        self.instructionTextLabel.alpha = 0
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "animate", userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.animateRadarIntoPosition()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func animateRadarIntoPosition() {
        UIView .animateWithDuration(1.0, delay: 2.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
            self.searchRadarHorizontalConstraint.constant = -120
            self.view.layoutIfNeeded()
        }) { (Bool) -> Void in
            self.animateInstructionTextLabelIntoView()
        }
    }
    
    func animateInstructionTextLabelIntoView() {
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.instructionTextLabel.alpha = 1
        })
    }

    @IBAction func didTapTargetChosenButton(sender: UIButton) {
    }
    
    @IBAction func didTapNewTargetButton(sender: UIButton) {
        //add dot to the screen
        let radarWidth = self.radarBackground.frame.size.width - 40
        let radarHeight = self.radarBackground.frame.size.height - 40
        let radarX = self.radarBackground.frame.origin.x + 40
        let radarY = self.radarBackground.frame.origin.y + 40
        let newDotX = radarX + CGFloat(arc4random()%UInt32(radarWidth))
        let newDotY = radarY + CGFloat(arc4random()%UInt32(radarHeight))
        let dotFrame = CGRectMake(newDotX, newDotY, 10, 10)
        let newDot = UIView(frame: dotFrame)
        newDot.layer.borderColor=self.view.tintColor.CGColor
        newDot.layer.borderWidth = 2
        newDot.layer.cornerRadius = newDot.frame.size.width/2
        newDot.clipsToBounds = true
        newDot.backgroundColor = UIColor.greenColor()
        newDot.alpha = 0
        self.view.addSubview(newDot)
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5.0, options: nil, animations: { () -> Void in
            newDot.alpha = 1
            newDot.transform = CGAffineTransformScale(newDot.transform, 2.0, 2.0)
        }) { (Bool) -> Void in
            //
        }
        
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

