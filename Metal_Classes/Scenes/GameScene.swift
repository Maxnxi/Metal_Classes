//
//  GameScene.swift
//  Metal_Classes
//
//  Created by Maksim Ponomarev on 4/4/24.
//

import MetalKit

class GameScene: Scene {
	
	var quad: Plane
	var cube: Cube
	
	override init(device: MTLDevice, size: CGSize) {
		quad = Plane(device: device, imageName: "metalFan.jpg")
		cube = Cube(device: device)
		super.init(device: device, size: size)
		add(child: cube)
		add(child: quad)
		
		cube.scale = float3(0.5)
		quad.scale = float3(3)
		quad.position.z = -3
		quad.position.y = 1
	}
	
	override func update(deltaTime: Float) {
		cube.rotation.y += deltaTime
	}
}
