//
//  HackViewController.swift
//  gibson
//
//  Created by Jeffrey Bergier on 9/27/14.
//  Copyright (c) 2014 gibson. All rights reserved.
//

import UIKit

class HackViewController: UIViewController {
    
    @IBOutlet weak var bottomRightButtonImageView: UIImageView!
    @IBOutlet weak var bottomRightButton: UIButton!
    @IBOutlet weak var bottomLeftButtonImageView: UIImageView!
    @IBOutlet weak var bottomLeftButton: UIButton!
    @IBOutlet weak var topLeftButtonImageView: UIImageView!
    @IBOutlet weak var topLeftButton: UIButton!
    @IBOutlet weak var topRightButtonImageView: UIImageView!
    @IBOutlet weak var topRightButton: UIButton!
    @IBOutlet weak var hackLogoImageView: UIImageView!
    
	var defendLogoImage: UIImage?
    var switchButtonTimer: NSTimer?

    override func viewDidLoad() {
        super.viewDidLoad()
		self.defendLogoImage = UIImage(named: "hackLogo")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.hackLogoImageView.image = self.defendLogoImage
        self.view.tintColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
    
        self.bottomRightButtonImageView.backgroundColor = UIColor.blackColor()
        self.bottomRightButton.backgroundColor = UIColor.blackColor()
        self.bottomLeftButtonImageView.backgroundColor = UIColor.blackColor()
        self.bottomLeftButton.backgroundColor = UIColor.blackColor()
        self.topLeftButtonImageView.backgroundColor = UIColor.blackColor()
        self.topLeftButton.backgroundColor = UIColor.blackColor()
        self.topRightButtonImageView.backgroundColor = UIColor.blackColor()
        self.topRightButton.backgroundColor = UIColor.blackColor()
        self.hackLogoImageView.backgroundColor = UIColor.blackColor()
        
        self.bottomRightButtonImageView.tag = 0
        self.bottomRightButton.tag = 0
        self.bottomLeftButtonImageView.tag = 0
        self.bottomLeftButton.tag = 0
        self.topLeftButtonImageView.tag = 0
        self.topLeftButton.tag = 0
        self.topRightButtonImageView.tag = 0
        self.topRightButton.tag = 0
        self.hackLogoImageView.tag = 0
        
        self.topLeftButton.userInteractionEnabled = false
        self.topRightButton.userInteractionEnabled = false
        self.bottomRightButton.userInteractionEnabled = false
        self.bottomLeftButton.userInteractionEnabled = false
        
        self.switchButtonTimer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "changeButtonTimer", userInfo: nil, repeats: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapBottomRightButton(sender: UIButton) {
    }
    
    @IBAction func didTapBottomLeftButton(sender: UIButton) {
    }

    @IBAction func didTapTopLeftButton(sender: UIButton) {
    }

    @IBAction func didTapTopRightButton(sender: UIButton) {
    }
    
    func changeButtonTimer() {
        self.bottomRightButtonImageView.backgroundColor = UIColor.blackColor()
        self.bottomRightButton.backgroundColor = UIColor.blackColor()
        self.bottomLeftButtonImageView.backgroundColor = UIColor.blackColor()
        self.bottomLeftButton.backgroundColor = UIColor.blackColor()
        self.topLeftButtonImageView.backgroundColor = UIColor.blackColor()
        self.topLeftButton.backgroundColor = UIColor.blackColor()
        self.topRightButtonImageView.backgroundColor = UIColor.blackColor()
        self.topRightButton.backgroundColor = UIColor.blackColor()
        self.hackLogoImageView.backgroundColor = UIColor.blackColor()
        
        self.bottomRightButtonImageView.tag = 0
        self.bottomRightButton.tag = 0
        self.bottomLeftButtonImageView.tag = 0
        self.bottomLeftButton.tag = 0
        self.topLeftButtonImageView.tag = 0
        self.topLeftButton.tag = 0
        self.topRightButtonImageView.tag = 0
        self.topRightButton.tag = 0
        self.hackLogoImageView.tag = 0
        
        self.topLeftButton.userInteractionEnabled = false
        self.topRightButton.userInteractionEnabled = false
        self.bottomRightButton.userInteractionEnabled = false
        self.bottomLeftButton.userInteractionEnabled = false
        
        let randomNumber = arc4random()%3
        switch randomNumber {
        case 0:
            if (self.topLeftButton.tag == 0) {
                self.topLeftButton.backgroundColor = UIColor.whiteColor()
                self.topLeftButton.tag = 1
                self.topLeftButton.userInteractionEnabled = true
            } else {
                self.topLeftButton.backgroundColor = UIColor.blackColor()
                self.topLeftButton.tag = 0
                self.topLeftButton.userInteractionEnabled = false
                self.changeButtonTimer()
            }
        case 1:
            if (self.topRightButton.tag == 0) {
                self.topRightButton.backgroundColor = UIColor.whiteColor()
                self.topRightButton.tag = 1
                self.topRightButton.userInteractionEnabled = true
            } else {
                self.topRightButton.backgroundColor = UIColor.blackColor()
                self.topRightButton.tag = 0
                self.topRightButton.userInteractionEnabled = false
                self.changeButtonTimer()
            }
        case 2:
            if (self.bottomRightButton.tag == 0) {
                self.bottomRightButton.backgroundColor = UIColor.whiteColor()
                self.bottomRightButton.tag = 1
                self.bottomRightButton.userInteractionEnabled = true
            } else {
                self.bottomRightButton.backgroundColor = UIColor.blackColor()
                self.bottomRightButton.tag = 0
                self.bottomRightButton.userInteractionEnabled = false
                self.changeButtonTimer()
            }
        case 3:
            if (self.bottomLeftButton.tag == 0) {
                self.bottomLeftButton.backgroundColor = UIColor.whiteColor()
                self.bottomLeftButton.tag = 1
                self.bottomLeftButton.userInteractionEnabled = true
            } else {
                self.bottomLeftButton.backgroundColor = UIColor.blackColor()
                self.bottomLeftButton.tag = 0
                self.bottomLeftButton.userInteractionEnabled = false
                self.changeButtonTimer()
            }
        default:
            println("")
        }
    }
    
}
