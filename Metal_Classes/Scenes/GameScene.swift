//
//  GameScene.swift
//  Metal_Classes
//
//  Created by Maksim Ponomarev on 4/4/24.
//

import MetalKit

class GameScene: Scene {
	
	let quad: Plane
	
	override init(device: MTLDevice, size: CGSize) {
		quad = Plane(device: device, imageName: "metalFan.jpg", maskImageName: "flower.png")
		super.init(device: device, size: size)
		
		add(child: quad)
		
		let flower = Plane(device: device, imageName: "flower.png")
		
		add(child: flower)
	}
	
	override func render(commandEncoder: MTLRenderCommandEncoder, deltaTime: Float) {
		quad.render(commandEncoder: commandEncoder, deltaTime: deltaTime)
	}

}
