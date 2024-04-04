//
//  Renderer.swift
//  Metal_Classes
//
//  Created by Maksim Ponomarev on 4/4/24.
//

import MetalKit

class Renderer: NSObject {
	let device: MTLDevice
	let commandQueue: MTLCommandQueue

	var scene: Scene?
	
	init(device: MTLDevice) {
		self.device = device
		self.commandQueue = device.makeCommandQueue()!
		super.init()
	}
	
}

extension Renderer: MTKViewDelegate {
	func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
		
	}
	
	func draw(in view: MTKView) {
		guard let drawable = view.currentDrawable,
			  let descriptor = view.currentRenderPassDescriptor else {
			fatalError()
		}
		
		let commandBuffer = commandQueue.makeCommandBuffer()!
		let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: descriptor)!
		
		let deltaTime = 1 / Float(view.preferredFramesPerSecond)
		
		scene?.render(commandEncoder: commandEncoder, deltaTime: deltaTime)
		
		commandEncoder.endEncoding()
		commandBuffer.present(drawable)
		commandBuffer.commit()
	}
}
