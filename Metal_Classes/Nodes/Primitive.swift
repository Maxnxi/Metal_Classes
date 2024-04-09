//
//  Primitive.swift
//  Metal_Classes
//
//  Created by Maksim Ponomarev on 4/8/24.
//

import MetalKit

class Primitive: Node {
	
	var vertices:	[Vertex] = []
	var indices:	[UInt16] = []
	
	var vertexBuffer:	MTLBuffer?
	var indexBuffer:	MTLBuffer?
	
	var time: Float = 0
	
	var modelConstants = ModelConstants()
	
	// Renderable
	var renderPipelineState: MTLRenderPipelineState!
	var vertexFunctionName:		String	= "vertex_shader"
	var fragmentFunctionName:	String	= "fragment_shader"
	
	var vertexDescriptor: MTLVertexDescriptor {
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
		
		return vertexDescriptor
	}
	
	// Texturable
	var texture: MTLTexture?
	var maskTexture: MTLTexture?

	
	init(device: MTLDevice) {
		vertexFunctionName		= "vertex_shader"
		fragmentFunctionName	= "fragment_shader"
		super.init()

		buildVertices()
		buildBuffers(device: device)
		renderPipelineState = buildPipelineState(device: device)

	}
	
	init(device: MTLDevice, imageName: String) {
		super.init()

		if let texture = setTexture(device: device, imageName: imageName) {
			self.texture = texture
			fragmentFunctionName = "textured_fragment"
		}
		buildVertices()
		buildBuffers(device: device)
		renderPipelineState = buildPipelineState(device: device)

	}
	
	init(device: MTLDevice, imageName: String, maskImageName: String) {
		super.init()
		if let texture = setTexture(device: device, imageName: imageName) {
			self.texture = texture
			fragmentFunctionName = "textured_fragment"
		}
		if let maskTexture = setTexture(device: device, imageName: maskImageName) {
			self.maskTexture = maskTexture
			fragmentFunctionName = "textured__mask_fragment"
		}
		buildVertices()
		buildBuffers(device: device)
		renderPipelineState = buildPipelineState(device: device)
	}
	
	func buildVertices() { }
	
	private
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
	
	

	
	
}

extension Primitive: Renderable {
	
	func draw(commandEncoder: MTLRenderCommandEncoder) {
		commandEncoder.setRenderPipelineState(renderPipelineState)
		commandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
		commandEncoder.setVertexBytes(&modelConstants, length: MemoryLayout<ModelConstants>.stride, index: 1)
		
		commandEncoder.drawIndexedPrimitives(type: .triangle,
											 indexCount: indices.count,
											 indexType: .uint16,
											 indexBuffer: indexBuffer!,
											 indexBufferOffset: 0)
	}
	
	func doRender(commandEncoder: MTLRenderCommandEncoder, modelViewMatrix: matrix_float4x4) {
		guard let indexBuffer else { return }
		
		let aspect = Float(1179.0 / 2566.0)
		
		let projectionMatrix = matrix_float4x4(
			projectionFov: radians(fromDegrees: 65),
			aspect: aspect,
			nearZ: 0.1,
			farZ: 100
		)
		
		modelConstants.modelViewMatrix = matrix_multiply(projectionMatrix, modelViewMatrix)
		
		
		commandEncoder.setRenderPipelineState(renderPipelineState)
		
		commandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
		
		commandEncoder.setVertexBytes(&modelConstants, length: MemoryLayout<ModelConstants>.stride, index: 1)
		
		commandEncoder.setFragmentTexture(texture, index: 0)
		commandEncoder.setFragmentTexture(maskTexture, index: 1)

		commandEncoder.setFrontFacing(.counterClockwise)
		commandEncoder.setCullMode(.back)
		
		commandEncoder.drawIndexedPrimitives(
			type: .triangle,
			indexCount: indices.count,
			indexType: .uint16,
			indexBuffer: indexBuffer,
			indexBufferOffset: 0
		)
	}
}

extension Primitive: Texturable {
	
}

