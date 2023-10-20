//
//  MetalView.swift
//  PlayWithMetal
//
//  Created by Łukasz Dziedzic on 20/10/2023.
//

import Foundation
import SwiftUI
import MetalKit

struct MetalView: NSViewRepresentable {

    typealias NSViewType = MTKView
    
    
    // used by context.coordinator
    func makeCoordinator() -> Renderer {
        Renderer(self)
    }
    
    func makeNSView(context: NSViewRepresentableContext<MetalView>) -> MTKView {
        let mtkView = MTKView()
        mtkView.delegate = context.coordinator
        
        mtkView.preferredFramesPerSecond = 60
        mtkView.enableSetNeedsDisplay = true
        
        if let metalDevice = MTLCreateSystemDefaultDevice() {
            mtkView.device = metalDevice
        }
        
        mtkView.framebufferOnly = false
        mtkView.drawableSize = mtkView.frame.size
        
        return mtkView
    }
    
    func updateNSView(_ nsView: NSViewType, context: NSViewRepresentableContext<MetalView>) {
        
    }
}
