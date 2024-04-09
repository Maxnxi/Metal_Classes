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
		quad = Plane(device: device, imageName: "metalFan.jpg")
		super.init(device: device, size: size)
		add(child: quad)
		
		quad.scale = float3(0.5)

		let flower = Plane(device: device, imageName: "flower.png")
		flower.scale = float3(0.5)
		flower.position.y = 1.5
		quad.add(child: flower)
		
		
		
	}
	
	override func update(deltaTime: Float) {
		quad.rotation.y += deltaTime
	}
}
