﻿Shader "Tienchih/FlashPoint"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		[HDR]_OriColor("Color",Color) = (1,1,1,1)
		[HDR]_MainColor("Color",Color) = (1,1,1,1)
	}
		SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 100

		Pass
	{
		CGPROGRAM
#pragma vertex vert  
#pragma fragment frag  

#include "UnityCG.cginc"  

		struct appdata
	{
		float4 vertex : POSITION;
		float2 uv : TEXCOORD0;
	};

	struct v2f
	{
		float2 uv : TEXCOORD0;
		float4 vertex : SV_POSITION;
	};

	sampler2D _MainTex;
	float4 _MainTex_ST;
	float4 _OriColor;
	fixed4 _MainColor;
	v2f vert(appdata v)
	{
		v2f o;
		o.vertex = UnityObjectToClipPos(v.vertex);//基础部分
		o.uv = TRANSFORM_TEX(v.uv, _MainTex);
		return o;
	}

	fixed4 frag(v2f i) : SV_Target
	{
		fixed4 b_color = _MainColor*((cos(_Time.y * 4) + 3) / 8.0);
																   // sample the texture  
	fixed4 col = tex2D(_MainTex, i.uv)*b_color;
	return col;
	}
		ENDCG
	}
	}
}