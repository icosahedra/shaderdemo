Shader "Example/UV Flow" {

Properties {
    _MainTex ("Texture", 2D) = "white" { }
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

sampler2D _MainTex;
float4 _MainTex_ST;

struct VertexInput {
    float4  position : POSITION;
    float4  uv : TEXCOORD0;
};

struct VertexToFragment {
    float4  position : POSITION;
    float2  uv : TEXCOORD0;
};

VertexToFragment VertexProgram (VertexInput vertex)
{
    VertexToFragment output;
    output.position = mul (UNITY_MATRIX_MVP, vertex.position);
    vertex.uv.x = fmod(0.5*_Time.y,1);
    output.uv = vertex.uv.xy;
    return output;
}

half4 FragmentProgram (VertexToFragment fragment) : COLOR
{
    return tex2D (_MainTex, fragment.uv);
}

ENDCG



    }
}

Fallback "VertexLit"
} 
