//
//  ViewController.swift
//  IconFontDemo_Xcode12
//
//  Created by 宮内 龍之介 on 2020/08/27.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var imageView1: UIImageView!
	@IBOutlet weak var imageView2: UIImageView! {
		didSet {
			self.imageView2.image = UIImage(named: "star")?.withTintColor(.green)
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}


}

