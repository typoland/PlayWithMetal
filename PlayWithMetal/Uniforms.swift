//
//  Uniforms.swift
//  PlayWithMetal
//
//  Created by Łukasz Dziedzic on 20/10/2023.
//

import Foundation
import MetalKit
import SwiftUI

class ViewData {
    let uniformsBuffer: MTLBuffer
    
    init(metalDevice: MTLDevice, size: NSSize, frameIndex: UInt32) {
        
        let pack = [Uniforms(size: SIMD2<Float>(Float(size.width), Float(size.height)),
                            frameIndex: frameIndex)]
        
        
        uniformsBuffer = metalDevice.makeBuffer(bytes: pack, 
                                              length: MemoryLayout<Uniforms>.stride,
                                              options: [])!
    }
}
