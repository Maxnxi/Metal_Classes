//
//  Texturable.swift
//  Metal_Classes
//
//  Created by Maksim Ponomarev on 4/4/24.
//

import MetalKit

protocol Texturable {
	var texture: MTLTexture? { get set }
}

extension Texturable {
	func setTexture(device: MTLDevice, imageName: String) -> MTLTexture? {
		let textureLoader = MTKTextureLoader(device: device)
		
		var texture: MTLTexture? = nil
		
		let textureLoaderOptions: [MTKTextureLoader.Option: NSObject]
		let origin = NSString(string: MTKTextureLoader.Origin.bottomLeft.rawValue)
		textureLoaderOptions = [MTKTextureLoader.Option.origin: origin]
		
		if let textureUrl = Bundle.main.url(forResource: imageName, withExtension: nil) {
			do {
				texture = try textureLoader.newTexture(URL: textureUrl, options: textureLoaderOptions)
			} catch {
				fatalError()
			}
		}
		return texture
	}
}
