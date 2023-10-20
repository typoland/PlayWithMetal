//
//  Shaders.metal
//  PlayWithMetal
//
//  Created by Łukasz Dziedzic on 20/10/2023.
//

#include <metal_stdlib>
#include "../Engine/defines.h"

using namespace metal;

struct RasterizerData {
    float4 position [[position]];
    float4 color;
    float2 size;
    int frameIndex;
};

vertex RasterizerData vertexShader(const device Vertex *vertices [[buffer(0)]],
                                   const device Uniforms *uniforms [[buffer(1)]],
                           uint vertexID [[vertex_id]]) {
    
    Vertex input = vertices[vertexID];
    Uniforms uniform = uniforms[0];
    RasterizerData data;
    data.position = float4(input.position, 1.0);
    data.color = input.color;
    data.size = uniform.size;
    data.frameIndex = uniform.frameIndex;
    
    return data;
}



    fragment float4 fragmentShader(RasterizerData input [[stage_in]],
                                   float2 uv [[point_coord]]) {
     
        float2 coord = (uv - float2(0.5)) * 2;

        return (sin(coord.x*10)/2)+ 0.5;//(atan(coord.y)+1);


    }
