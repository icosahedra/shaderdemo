Shader "Presentation/Distance" {

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
    float4  screenPosition : TEXCOORD2;
    float4  worldPosition : TEXCOORD1;
    float2  uv : TEXCOORD0;
};

VertexToFragment VertexProgram (VertexInput vertex)
{
    VertexToFragment output;
    output.position = output.screenPosition = mul (UNITY_MATRIX_MVP, vertex.position);
    output.worldPosition = mul(_Object2World, vertex.position);
    output.uv = TRANSFORM_TEX (vertex.uv, _MainTex);
    return output;
}

half4 FragmentProgram (VertexToFragment fragment) : COLOR
{
    float distanceToPoint = distance(_WorldSpaceCameraPos.xyz, fragment.worldPosition.xyz)/10;
    //half4 texcol = half4(distanceToPoint);
    half4 texcol = half4(fragment.screenPosition.z)/10;
    return texcol * _Color;
}

ENDCG



    }
}

Fallback "VertexLit"
} 
