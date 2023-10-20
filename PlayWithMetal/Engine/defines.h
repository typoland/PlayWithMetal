//
//  defines.h
//  PlayWithMetal
//
//  Created by Łukasz Dziedzic on 20/10/2023.
//

#ifndef defines_h
#define defines_h

#include <simd/simd.h>

//Build Settings / Swift Compiler - General / Objective-C Bridging Header / path/to/this/file

//Drawing primiteves
struct Vertex {
    vector_float3 position;
    vector_float4 color;
};

struct Uniforms {
    //matrix_float4x4 viewMatrix;
    //matrix_float4x4 viewProjectionMatrix;
    vector_float2 size;
    unsigned int frameIndex;
    //vector_float2 jitter;
};


#endif /* defines_h */
