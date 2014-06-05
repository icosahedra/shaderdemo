Shader "Debug/UV" {

Properties {

}

SubShader {
	Tags {"Queue"="Geometry" "RenderType"="Opaque"}

    Pass {
    	Cull Back // default
    	ZWrite On //default
    	ZTest LEqual //default
    	Blend Off
    	AlphaTest Off


CGPROGRAM
#pragma vertex VertexProgram
#pragma fragment FragmentProgram

#include "UnityCG.cginc"


struct VertexInput {
    float4  position : POSITION;
    float4  uv : TEXCOORD0;
};

struct VertexToFragment {
    float4  position : POSITION;
    float4  color : COLOR0;
};

VertexToFragment VertexProgram (VertexInput vertex)
{
    VertexToFragment output;
    output.position = mul (UNITY_MATRIX_MVP, vertex.position);
    output.color.rg = vertex.uv.xy;
    return output;
}

half4 FragmentProgram (VertexToFragment fragment) : COLOR
{
    
    return fragment.color;
}

ENDCG



    }
}

Fallback "VertexLit"
} 
