//
//  Shader.metal
//  Metal_Classes
//
//  Created by Maksim Ponomarev on 4/4/24.
//

#include <metal_stdlib>
using namespace metal;

struct Constants {
	float animateBy;
};

struct VertexIn {
	float4 position [[ attribute(0) ]];
	float4 color [[ attribute(1) ]];
};

struct VertexOut {
	float4 position [[ position ]];
	float4 color;
};

vertex VertexOut vertex_shader(const VertexIn vertexIn [[ stage_in ]] ) {
	VertexOut vertexOut;
	vertexOut.position = vertexIn.position;
	vertexOut.color = vertexIn.color;
	
	return vertexOut;
}

fragment half4 fragment_shader(VertexOut vertexIn [[ stage_in ]]) {
	
	/// multicolor
	//return half4(vertexIn.color);
	
	/*
	 https://medium.com/@yuyaHorita/swift-metal-image-processing-75f1c2342306
	 Theory of grayscale:
	 Average: V= (R + G + B) / 3
	 Common: V= R * 0.3 + G * 0.59 + B * 0.11
	 BT.709: V= R * 0.2126 + G * 0.7152 + B * 0.0722
	 BT.601: V= R * 0.299 + G * 0.587 + B * 0.114
	 */
	/// grayscale
	half gray = (vertexIn.color.r + vertexIn.color.g + vertexIn.color.b) / 3;
	half4 grayscaleColor = half4(gray, gray, gray, vertexIn.color.a);
	
	return  grayscaleColor;
	
}
