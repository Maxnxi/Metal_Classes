//
//  Types.swift
//  Metal_Classes
//
//  Created by Maksim Ponomarev on 4/4/24.
//

import simd

struct Vertex {
	var position: SIMD3<Float>
	var color: SIMD4<Float>
	var texture: SIMD2<Float>
}

struct ModelConstants {
	var modelViewMatrix = matrix_identity_float4x4
}

struct SceneConstants {
	var projectionMatrix = matrix_identity_float4x4
}
