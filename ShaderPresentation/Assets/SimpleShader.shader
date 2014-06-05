Shader "Presentation/Simple Shader" {

Properties {
    _Color ("Main Color", Color) = (1,1,1,0.5)
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

float4 _Color;
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
    output.uv = TRANSFORM_TEX (vertex.uv, _MainTex);
    return output;
}

half4 FragmentProgram (VertexToFragment fragment) : COLOR
{
    half4 texcol = tex2D (_MainTex, fragment.uv);
    return texcol * _Color;
}

ENDCG

    }
}

Fallback "VertexLit"
} 


