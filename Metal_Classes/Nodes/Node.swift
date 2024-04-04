//
//  Node.swift
//  Metal_Classes
//
//  Created by Maksim Ponomarev on 4/4/24.
//

import MetalKit

class Node {
	var children: [Node] = []
	
	var renderPipelineState : MTLRenderPipelineState!
	
	init() {

	}
	
	func add(child : Node)  {
		children.append(child)
	}
	
	func render(commandEncoder: MTLRenderCommandEncoder, deltaTime: Float) {
		
	}
	
}
