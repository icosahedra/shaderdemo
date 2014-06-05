Shader "Example/Position UV Flow ObjUV" {

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
    float4  normal : NORMAL;
};

struct VertexToFragment {
    float4  position : POSITION;
    float2  uv : TEXCOORD0;
};

VertexToFragment VertexProgram (VertexInput vertex)
{
    VertexToFragment output;
    output.position = mul (UNITY_MATRIX_MVP, vertex.position);
    output.uv = vertex.uv.xy;
    output.position += vertex.normal*(1+sin(_Time.y + 10*output.uv.y));
    output.uv = output.position/10;
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
