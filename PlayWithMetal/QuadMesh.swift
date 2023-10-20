//
//  QuadMesh.swift
//  PlayWithMetal
//
//  Created by Łukasz Dziedzic on 20/10/2023.
//

import Foundation
import MetalKit

class QuadMesh {
    let vertexBuffer: MTLBuffer
    
    init(metalDevice: MTLDevice) {
        let red    = vector_float4(  1,   0,   0, 1)
        let green  = vector_float4(  0, 0.7,   0, 1)
        let blue   = vector_float4(0.2,   0,   1, 1)
        let yellow = vector_float4(  1,   1,   0, 1)
        
        let vertices = [
            Vertex(position:vector_float3(-1,-1, 0), color: green ), 
            Vertex(position:vector_float3( 1,-1, 0), color: blue ),
            Vertex(position:vector_float3( 1, 1, 0), color: red ),
            
            Vertex(position:vector_float3( 1, 1, 0), color: red ),
            
            Vertex(position:vector_float3( -1, 1, 0), color: yellow),
            Vertex(position:vector_float3(-1,-1, 0), color: green ),
            
            
        ]
        
        vertexBuffer = metalDevice.makeBuffer(bytes: vertices, 
                                              length: MemoryLayout<Vertex>.stride * vertices.count,
                                              options: [])!
    }
}
