//
//  DebugViewController.swift
//  gibson
//
//  Created by Michael Critz on 9/27/14.
//  Copyright (c) 2014 gibson. All rights reserved.
//

import Foundation
import UIKit

class DebugViewController: UIViewController {
	@IBOutlet var label: UILabel?
	
	required init(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	override func viewDidAppear(animated: Bool) {
		var netManger = NetworkManager()
		if netManger.isBrowsing {
			if let label = self.label {
				label.text = "Network Manger online"
			}
		}
	}
}
