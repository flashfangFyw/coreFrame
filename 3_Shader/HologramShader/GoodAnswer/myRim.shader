// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/myRim"
{
	Properties
	{
		_RimColor("Rim Color", Color) = (0.5,0.5,0.5,0.5)
		_InnerColor("Inner Color", Color) = (0.5,0.5,0.5,0.5)
		_InnerColorPower("Inner Color Power", Range(0.0,1.0)) = 0.5
		_RimPower("Rim Power", Range(0.0,5.0)) = 2.5
		_AlphaPower("Alpha Rim Power", Range(0.0,8.0)) = 4.0
		_AllPower("All Power", Range(0.0, 10.0)) = 1.0
	}
	SubShader
	{
		Tags{ "Queue" = "Transparent" "RenderType" = "Transparent" }
		LOD 2000
	
		Pass
		{
			Name "FORWARD"
			Tags{
			"LightMode" = "ForwardBase"
			}
			Blend SrcAlpha OneMinusSrcAlpha
			/*Cull Off
			ZWrite Off*/

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#define UNITY_PASS_FORWARDBASE
			#include "UnityCG.cginc"
			#pragma multi_compile_fwdbase
			#pragma multi_compile_fog
			#pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
			#pragma target 3.0


			float4 _RimColor;
			float _RimPower;
			float _AlphaPower;
			float _AlphaMin;
			float _InnerColorPower;
			float _AllPower;
			float4 _InnerColor;

			struct VertexInput {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 texcoord3 : TEXCOORD3;
			};
			struct VertexOutput {
				//===============
				float4 pos : SV_POSITION;
				float3 normalDir : TEXCOORD0;
				float4 posWorld : TEXCOORD2;
				float4 viewWorld : TEXCOORD3;
			};
			VertexOutput vert(VertexInput v) {
				VertexOutput o = (VertexOutput)0;
				o.normalDir = UnityObjectToWorldNormal(v.normal);
				o.pos = UnityObjectToClipPos(v.vertex);
				o.posWorld = mul(unity_ObjectToWorld, v.vertex);
				return o;
			}
			float4 frag(VertexOutput i) : COLOR
			{
				/*o.Emission = _RimColor.rgb * pow(rim, _RimPower)*_AllPower + (_InnerColor.rgb * 2 * _InnerColorPower);
				o.Alpha = (pow(rim, _AlphaPower))*_AllPower;*/
				
				//===rim
					float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
					half rim = 1.0 - saturate(dot(normalize(viewDirection), i.normalDir));

				//====
				float3 emissive = _RimColor.rgb * pow(rim, _RimPower)*_AllPower + (_InnerColor.rgb * 2 * _InnerColorPower);
				float3 finalColor = emissive;
				fixed4 finalRGBA = fixed4(finalColor, (pow(rim, _AlphaPower))*_AllPower);
				return finalRGBA;
			}
				ENDCG
		}
	}
}
