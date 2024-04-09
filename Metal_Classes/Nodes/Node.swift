//
//  Node.swift
//  Metal_Classes
//
//  Created by Maksim Ponomarev on 4/4/24.
//

import MetalKit

class Node {
	var name = "Untitled"
	var children: [Node] = []

	var position	= SIMD3<Float>(repeating: 0)
	var rotation	= SIMD3<Float>(repeating: 0)
	var scale		= SIMD3<Float>(repeating: 0)
	
	var modelMatrix: matrix_float4x4 {
	  var matrix = matrix_float4x4(translationX: position.x, y: position.y, z: position.z)
	  matrix = matrix.rotatedBy(rotationAngle: rotation.x, x: 1, y: 0, z: 0)
	  matrix = matrix.rotatedBy(rotationAngle: rotation.y, x: 0, y: 1, z: 0)
	  matrix = matrix.rotatedBy(rotationAngle: rotation.z, x: 0, y: 0, z: 1)
	  matrix = matrix.scaledBy(x: scale.x, y: scale.y, z: scale.z)
	  return matrix
	}
	
	init() { }
	
	func add(child : Node)  {
		children.append(child)
	}
	
	func render(commandEncoder: MTLRenderCommandEncoder,
				parentModelViewMatrix: matrix_float4x4) {
	  let modelViewMatrix = matrix_multiply(parentModelViewMatrix, modelMatrix)
		
	  for child in children {
		child.render(commandEncoder: commandEncoder, parentModelViewMatrix: modelViewMatrix)
	  }
	  
	  if let renderable = self as? Renderable {
		commandEncoder.pushDebugGroup(name)
		renderable.doRender(commandEncoder: commandEncoder, modelViewMatrix: modelViewMatrix)
		commandEncoder.popDebugGroup()
	  }
	}
	
}
