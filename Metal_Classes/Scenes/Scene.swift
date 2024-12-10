//
//  Scene.swift
//  Metal_Classes
//
//  Created by Maksim Ponomarev on 4/4/24.
//

import MetalKit

class Scene: Node {
	var device: MTLDevice
	var size: CGSize
	var camera = Camera()
	var sceneConstants = SceneConstants()
	
	init(device: MTLDevice, size: CGSize) {
		self.device = device
		self.size = size
		super.init()
		
		camera.aspect = Float(size.width / size.height)
//		camera.position.z = -6
		add(child: camera)
	}
	
	func update(deltaTime: Float) {}
	
	func render(commandEncoder: MTLRenderCommandEncoder, deltaTime: Float) {
		update(deltaTime: deltaTime)
		
		sceneConstants.projectionMatrix = camera.projectionMatrix
		commandEncoder.setVertexBytes(&sceneConstants, length: MemoryLayout<SceneConstants>.stride, index: 2)
				
		for child in children {
			child.render(commandEncoder: commandEncoder, parentModelViewMatrix: camera.viewMatrix)
		}
	}
	
}
