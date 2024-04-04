//
//  ViewController.swift
//  Metal_Classes
//
//  Created by Maksim Ponomarev on 4/4/24.
//

import UIKit
import MetalKit

enum Colors {
	static let cstmGreen = MTLClearColor(red: 0, green: 0.4, blue: 0.21, alpha: 1)
}

class ViewController: UIViewController {

	var metalView: MTKView {
		return view as! MTKView
	}
	
	var renderer: Renderer?
	
	override func loadView() {
		self.view = MTKView()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		guard let device = MTLCreateSystemDefaultDevice() else {
			return
		}
		metalView.device = device
		metalView.clearColor = Colors.cstmGreen

		renderer = Renderer(device: device)
		renderer?.scene = GameScene(device: device, size: .zero)
		metalView.delegate = renderer
	}


}
