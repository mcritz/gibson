//
//  DefendViewController.swift
//  gibson
//
//  Created by Jeffrey Bergier on 9/27/14.
//  Copyright (c) 2014 gibson. All rights reserved.
//

import UIKit

class DefendViewController: UIViewController {
    
    @IBOutlet weak var defendLogoImageView: UIImageView!
    @IBOutlet weak var killViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var sliderBarVerticalConstraint: NSLayoutConstraint!
    @IBOutlet weak var sliderBarView: UIView!
    @IBOutlet weak var defendDirectionsView: UIView!
    @IBOutlet weak var coldWarmHotHintTextLabel: UILabel!
    @IBOutlet weak var attackerNameTextLabel: UILabel!
    
	var defendLogoImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.tintColor = UIColor.whiteColor()
	defendLogoImage = UIImage(named: "defendLogo")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.defendLogoImageView.image! = self.defendLogoImage!
        self.defendDirectionsView.alpha = 0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func didTapShowViewButton(sender: UIButton) {
        if (self.defendDirectionsView.alpha == 0) {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.defendDirectionsView.alpha = 1
            })
            
        } else {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.defendDirectionsView.alpha = 0
            })        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
