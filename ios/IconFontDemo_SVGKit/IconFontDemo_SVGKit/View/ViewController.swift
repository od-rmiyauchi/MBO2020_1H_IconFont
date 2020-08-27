//
//  ViewController.swift
//  IconFontDemo_SVGKit
//
//  Created by 宮内 龍之介 on 2020/08/27.
//  Copyright © 2020 opendoor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet weak var imageView1: UIImageView! {
		didSet {
			self.imageView1.image = .svg(.starBorder, size: CGSize(width: 100, height: 100))
		}
	}
	@IBOutlet weak var imageView2: UIImageView! {
		didSet {
			self.imageView2.image = .svg(.starHalf, size: CGSize(width: 100, height: 100), color: .blue)
		}
	}
	@IBOutlet weak var imageView3: UIImageView! {
		didSet {
			self.imageView3.image = .svg(.star, size: CGSize(width: 100, height: 100), color: .green)
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}


}

