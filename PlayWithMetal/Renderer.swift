//
//  Renderer.swift
//  PlayWithMetal
//
//  Created by Łukasz Dziedzic on 20/10/2023.
//

import Foundation
import MetalKit

class Renderer: NSObject, MTKViewDelegate {
    var parent: MetalView
    var metalDevice: MTLDevice!
    var metalCommandQueue: MTLCommandQueue!
    var piplineState: MTLRenderPipelineState
    var vertexBuffer: MTLBuffer
    var uniformsBuffer: MTLBuffer
    
    init(_ parent: MetalView) {
        self.parent = parent
        if let metalDevice = MTLCreateSystemDefaultDevice() {
            self.metalDevice = metalDevice
        }
        
        self.metalCommandQueue = self.metalDevice.makeCommandQueue()
        let piplineDescriptor = MTLRenderPipelineDescriptor()
        let library = self.metalDevice.makeDefaultLibrary()
        piplineDescriptor.vertexFunction = library?.makeFunction(name: "vertexShader")
        piplineDescriptor.fragmentFunction = library?.makeFunction(name: "fragmentShader")
        piplineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        do {
            try self.piplineState = self.metalDevice.makeRenderPipelineState(descriptor: piplineDescriptor)
        } catch {
            fatalError("Cannot create Pipline \(error)")
        }
        
        
        let quadMesh = QuadMesh(metalDevice: metalDevice)
        vertexBuffer = quadMesh.vertexBuffer
        
        //Dopisane
        let viewData = ViewData(metalDevice: metalDevice, size: CGSize(width: 500.0, height: 100.0), frameIndex: 0)
        uniformsBuffer = viewData.uniformsBuffer
        //
        
        super.init()
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable else { return }
        let commandBuffer = metalCommandQueue.makeCommandBuffer()
        
        //Resources, colors etc...
        guard let renderPassDescriptor = view.currentRenderPassDescriptor else { return }
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        renderPassDescriptor.colorAttachments[0].loadAction = .clear
        renderPassDescriptor.colorAttachments[0].storeAction = .store
        
   
        guard let renderEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor) else { return }
        
        renderEncoder.setViewport(.init(originX: 0, 
                                        originY: 0, 
                                        width: view.drawableSize.width, 
                                        height: view.drawableSize.height, 
                                        znear: 0.0, zfar: 1.0))
        
        renderEncoder.setRenderPipelineState(piplineState)
        
        
        //renderEncoder.setTriangleFillMode(.fill)
        renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        
        //DOPISANE
        renderEncoder.setVertexBuffer(uniformsBuffer, offset: 0, index: 1)
        //---
        renderEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 6)
        
        renderEncoder.endEncoding()
        
        //At the end
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
}
