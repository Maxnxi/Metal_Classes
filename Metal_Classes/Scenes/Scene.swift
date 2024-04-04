//
//  Scene.swift
//  Metal_Classes
//
//  Created by Maksim Ponomarev on 4/4/24.
//

import MetalKit

class Scene: Node {
	
	var device: MTLDevice!

	init(device: MTLDevice, size: CGSize) {
		self.device = device
		super.init()
	}
	
	
}
