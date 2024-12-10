//
//  Renderable.swift
//  Metal_Classes
//
//  Created by Maksim Ponomarev on 4/4/24.
//

import MetalKit

protocol Renderable {
	var fragmentFunctionName:	String { get set }
	var vertexFunctionName:		String { get set }
	var vertexDescriptor: 		MTLVertexDescriptor { get }
	var renderPipelineState: 	MTLRenderPipelineState! { get set }
	
	var modelConstants: 		ModelConstants { get set }
	
	func doRender(commandEncoder: MTLRenderCommandEncoder, modelViewMatrix: matrix_float4x4)
	
}

extension Renderable {
	func buildPipelineState(device: MTLDevice) -> MTLRenderPipelineState {
		let library				= device.makeDefaultLibrary()
		let vertexFunction		= library?.makeFunction(name: vertexFunctionName)
		let fragmentFunction	= library?.makeFunction(name: fragmentFunctionName)
		
		let piplineDescriptor = MTLRenderPipelineDescriptor()
		piplineDescriptor.vertexFunction 	= vertexFunction
		piplineDescriptor.fragmentFunction 	= fragmentFunction
		piplineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
		piplineDescriptor.depthAttachmentPixelFormat = .depth32Float
		
		piplineDescriptor.vertexDescriptor = vertexDescriptor
		
		let pipelineState = try? device.makeRenderPipelineState(descriptor: piplineDescriptor)
		return pipelineState!
	}
}
