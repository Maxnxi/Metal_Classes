//
//  Plane.swift
//  Metal_Classes
//
//  Created by Maksim Ponomarev on 4/4/24.
//

import MetalKit

class Plane: Node {
	
	var vertices: [Vertex] = [
		Vertex(
			position: SIMD3<Float>(-1,1,0),
			color: SIMD4<Float>(1,0,0,1),
			texture: SIMD2<Float>(0,1)
		),
		Vertex(
			position: SIMD3<Float>(-1,-1,0),
			color: SIMD4<Float>(0,1,0,1),
			texture: SIMD2<Float>(0,0)
		),
		Vertex(
			position: SIMD3<Float>(1,-1,0),
			color: SIMD4<Float>(0,0,1,1),
			texture: SIMD2<Float>(1,0)
		),
		Vertex(
			position: SIMD3<Float>(1,1,0),
			color: SIMD4<Float>(1,0,1,1),
			texture: SIMD2<Float>(1,1)
		)
	]
	
	var indices: [UInt16] = [
		0,1,2,
		2,3,0
	]
	
	var vertexBuffer: MTLBuffer?
	var indexBuffer: MTLBuffer?
	
	var time: Float = 0
	
	var modelConstants = ModelConstants()
	
	// Renderable
	var pipelineState: MTLRenderPipelineState!
	var vertexFunctionName: String		= "vertex_shader"
	var fragmentFunctionName: String	= "fragment_shader"
	
	// Texturable
	var texture: MTLTexture?
	
	init(device: MTLDevice) {
		super.init()
		buildBuffers(device: device)
		pipelineState = buildPipelineState(device: device)
	}
	
	init(device: MTLDevice, imageName: String) {
		super.init()
		
		if let texture = setTexture(device: device, imageName: imageName) {
			self.texture = texture
			fragmentFunctionName = "textured_fragment"
		}
		buildBuffers(device: device)
		pipelineState = buildPipelineState(device: device)
	}
	
	init(device: MTLDevice, imageName: String, maskImageName: String) {
		super.init()
		
		if let texture = setTexture(device: device, imageName: imageName) {
			self.texture = texture
			fragmentFunctionName = "textured_fragment"
		}
		buildBuffers(device: device)
		pipelineState = buildPipelineState(device: device)
	}
	
	func buildBuffers(device: MTLDevice) {
		vertexBuffer = device.makeBuffer(
			bytes: vertices,
			length: vertices.count * MemoryLayout<Vertex>.stride,
			options: []
		)
		indexBuffer = device.makeBuffer(
			bytes: indices,
			length: indices.count * MemoryLayout<UInt16>.size,
			options: []
		)
	}
	
	
	func buildPipelineState(device: MTLDevice) -> MTLRenderPipelineState {
		let library = device.makeDefaultLibrary()
		let vertexFunction = library?.makeFunction(name: vertexFunctionName)
		let fragmentFunction = library?.makeFunction(name: fragmentFunctionName)
		
		let piplineDescriptor = MTLRenderPipelineDescriptor()
		piplineDescriptor.vertexFunction = vertexFunction
		piplineDescriptor.fragmentFunction = fragmentFunction
		piplineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
		
		let vertexDescriptor = MTLVertexDescriptor()
		
		vertexDescriptor.attributes[0].format = .float3
		vertexDescriptor.attributes[0].offset = 0
		vertexDescriptor.attributes[0].bufferIndex = 0
		
		vertexDescriptor.attributes[1].format = .float4
		vertexDescriptor.attributes[1].offset = MemoryLayout<SIMD3<Float>>.stride
		vertexDescriptor.attributes[1].bufferIndex = 0
		
		vertexDescriptor.attributes[2].format = .float2
		vertexDescriptor.attributes[2].offset = MemoryLayout<SIMD3<Float>>.stride + MemoryLayout<SIMD4<Float>>.stride
		vertexDescriptor.attributes[2].bufferIndex = 0
		
		vertexDescriptor.layouts[0].stride = MemoryLayout<Vertex>.stride
		
		piplineDescriptor.vertexDescriptor = vertexDescriptor
		
		let pipelineState = try? device.makeRenderPipelineState(descriptor: piplineDescriptor)
		return pipelineState!

	}
	
	override func render(commandEncoder: MTLRenderCommandEncoder, deltaTime: Float) {
		super.render(commandEncoder: commandEncoder, deltaTime: deltaTime)
		
		guard let indexBuffer else { return }
		
		time += deltaTime
		let animatedBy = abs(sin(time)/2 + 0.5)

		var modelViewMatrix = matrix_float4x4(scaleX: 0.5, y: 0.5, z: 0.5)
		
		let rotationMatrix = matrix_float4x4(rotationAngle: animatedBy, x: 0, y: 0, z: 1)
		
		let viewMatrix = matrix_float4x4(translationX: 0, y: 0, z: -4)
		
		modelViewMatrix = matrix_multiply(rotationMatrix, viewMatrix)
		
		
		let aspect = Float(1179.0 / 2566.0)
		
		let projectionMatrix = matrix_float4x4(
			projectionFov: radians(fromDegrees: 65),
			aspect: aspect,
			nearZ: 0.1,
			farZ: 100
		)
		
		modelConstants.modelViewMatrix = matrix_multiply(projectionMatrix, modelViewMatrix)

		
		commandEncoder.setRenderPipelineState(pipelineState)
		
		commandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
		
		commandEncoder.setVertexBytes(&modelConstants, length: MemoryLayout<ModelConstants>.stride, index: 1)
		
		commandEncoder.setFragmentTexture(texture, index: 0)
		
		commandEncoder.drawIndexedPrimitives(
			type: .triangle,
			indexCount: indices.count,
			indexType: .uint16,
			indexBuffer: indexBuffer,
			indexBufferOffset: 0
		)
	}
}

extension Plane: Renderable {
	
}

extension Plane: Texturable {
	
}
