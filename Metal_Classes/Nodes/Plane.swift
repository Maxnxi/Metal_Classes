//
//  Plane.swift
//  Metal_Classes
//
//  Created by Maksim Ponomarev on 4/4/24.
//

import MetalKit

class Plane: Primitive {
	
	override func buildVertices() {
		vertices = [
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
		
		indices = [
			0,1,2,
			2,3,0
		]
	}
}
