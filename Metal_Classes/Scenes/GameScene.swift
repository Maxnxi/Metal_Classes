//
//  GameScene.swift
//  Metal_Classes
//
//  Created by Maksim Ponomarev on 4/4/24.
//

import MetalKit

class GameScene: Scene {
	
	let quad: Plane
	var cube: Cube
	
	override init(device: MTLDevice, size: CGSize) {
		cube = Cube(device: device)
		quad = Plane(device: device, imageName: "metalFan.jpg", maskImageName: "flower.png")
		super.init(device: device, size: size)
		add(child: cube)
		add(child: quad)
		
		let flower = Plane(device: device, imageName: "flower.png")
		flower.scale = float3(0.5)
		flower.position.y = 1.5
		quad.add(child: flower)
		
		quad.position.z = -3
		quad.position.y = -1.5
		quad.scale = float3(3)
	}
	
	override func update(deltaTime: Float) {
		cube.rotation.y += deltaTime
	}
	
//	override func render(commandEncoder: MTLRenderCommandEncoder, deltaTime: Float) {
//		quad.render(commandEncoder: commandEncoder, deltaTime: deltaTime)
//	}

}
