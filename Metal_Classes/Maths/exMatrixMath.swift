////
////  MatrixMath.swift
////  Metal_Classes
////
////  Created by Maksim Ponomarev on 4/8/24.
////
////https://developer.apple.com/documentation/accelerate/working_with_matrices
//
//import simd
//
//let pi = Float(M_PI)
//
//func radians(fromDegrees degrees: Float) -> Float {
//	return (degrees / 180) * pi
//}
//
//func degrees(fromRadians radians: Float) -> Float {
//	return (radians / pi) * 180
//}
//
//extension Float {
//	var radiansToDegrees: Float {
//		return (self / Float.pi) * 180
//	}
//	
//	var degreesToRadians: Float {
//		return (self / 180) * Float.pi
//	}
//}
//
//extension matrix_float4x4 {
//	init(translationX x: Float, y: Float, z: Float) {
//		self.init()
//		columns = (
//			float4(1, 0, 0, 0),
//			float4(0, 1, 0, 0),
//			float4(0, 0, 1, 0),
//			float4(x, y, z, 1)
//		)
//	}
//	
//	func translatedBy(x: Float, y: Float, z: Float) -> matrix_float4x4 {
//		let translationMatrix = matrix_float4x4(translationX: x, y: y, z: z)
//		return matrix_multiply(self, translationMatrix)
//	}
//	
//	init(scaleX x: Float, y: Float, z: Float) {
//		self.init()
//		columns = (
//			float4(x, 0, 0, 0),
//			float4(0, y, 0, 0),
//			float4(0, 0, z, 0),
//			float4(0, 0, 0, 1)
//		)
//	}
//	
//	func scaledBy(x: Float, y: Float, z: Float) -> matrix_float4x4 {
//		let scaledMatrix = matrix_float4x4(scaleX: x, y: y, z: z)
//		return matrix_multiply(self, scaledMatrix)
//	}
//	
//	init(rotationAngle angle: Float, x: Float, y: Float, z: Float) {
//		self.init()
//		columns = (
//			float4(cos(angle), -sin(angle), 0, 0),
//			float4(sin(angle), cos(angle), 0, 0),
//			float4(0, 0, z, 0),
//			float4(0, 0, 0, 1)
//		)
//	}
//	
//	func rotatedBy(rotationAngle angle: Float, x: Float, y: Float, z: Float) -> matrix_float4x4 {
//		let scaledMatrix = matrix_float4x4(rotationAngle: angle, x: x, y: y, z: z)
//		return matrix_multiply(self, scaledMatrix)
//	}
//	
//	init(projectionFov fov: Float, aspect: Float, nearZ: Float, farZ: Float) {
//		self.init()
//		let y = 1 / tan(fov * 0.5)
//		let x = y / aspect
//		let z = farZ / (nearZ - farZ)
//		columns = (
//			float4( x,  0,  0,  0),
//			float4( 0,  y,  0,  0),
//			float4( 0,  0,  z, -1),
//			float4( 0,  0,  z * nearZ,  0)
//		)
//	}
//	
//	func upperLeft3x3() -> matrix_float3x3 {
//		return (matrix_float3x3(columns: (
//			float3(columns.0.x, columns.0.y, columns.0.z),
//			float3(columns.1.x, columns.1.y, columns.1.z),
//			float3(columns.2.x, columns.2.y, columns.2.z)
//		)))
//	}
//}
//
//extension matrix_float4x4: CustomReflectable {
//	
//	public var customMirror: Mirror {
//		let c00 = String(format: "%  .4f", columns.0.x)
//		let c01 = String(format: "%  .4f", columns.0.y)
//		let c02 = String(format: "%  .4f", columns.0.z)
//		let c03 = String(format: "%  .4f", columns.0.w)
//		
//		let c10 = String(format: "%  .4f", columns.1.x)
//		let c11 = String(format: "%  .4f", columns.1.y)
//		let c12 = String(format: "%  .4f", columns.1.z)
//		let c13 = String(format: "%  .4f", columns.1.w)
//		
//		let c20 = String(format: "%  .4f", columns.2.x)
//		let c21 = String(format: "%  .4f", columns.2.y)
//		let c22 = String(format: "%  .4f", columns.2.z)
//		let c23 = String(format: "%  .4f", columns.2.w)
//		
//		let c30 = String(format: "%  .4f", columns.3.x)
//		let c31 = String(format: "%  .4f", columns.3.y)
//		let c32 = String(format: "%  .4f", columns.3.z)
//		let c33 = String(format: "%  .4f", columns.3.w)
//		
//		
//		let children = DictionaryLiteral<String, Any>(dictionaryLiteral:
//														(" ", "\(c00) \(c01) \(c02) \(c03)"),
//													  (" ", "\(c10) \(c11) \(c12) \(c13)"),
//													  (" ", "\(c20) \(c21) \(c22) \(c23)"),
//													  (" ", "\(c30) \(c31) \(c32) \(c33)")
//		)
//		return Mirror(matrix_float4x4.self, children: children)
//	}
//}
//
//extension float4: CustomReflectable {
//	
//	public var customMirror: Mirror {
//		let sx = String(format: "%  .4f", x)
//		let sy = String(format: "%  .4f", y)
//		let sz = String(format: "%  .4f", z)
//		let sw = String(format: "%  .4f", w)
//		
//		let children = DictionaryLiteral<String, Any>(dictionaryLiteral:
//														(" ", "\(sx) \(sy) \(sz) \(sw)")
//		)
//		return Mirror(float4.self, children: children)
//	}
//}
