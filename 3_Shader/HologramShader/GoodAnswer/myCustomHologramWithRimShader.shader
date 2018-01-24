// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/myCustomHologramWithRimShader"
{
	Properties
	{
		_Color("Color", Color) = (0.7, 1, 1, 0)
		_MainTex("MainTex", 2D) = "white" {}
		//_NormalMap("NormalMap", 2D) = "bump" {}
		_EmissionColor("EmissionColor", Color) = (0.7, 1, 1, 0)
		_FallOff("FallOff", Range(0.0,10.0)) = 5.0
		_MeshOffset("MeshOffset", Float) = 0.1
		_EffectTime("Effect Time (ms)", float) = 0
		_Size("Size", float) = 5.0
		//===========rim
		_InnerColorPower("Inner Color Power", Range(0.0,1.0)) = 0.5
		_RimPower("Rim Power", Range(0.0,5.0)) = 2.5
		_AlphaPower("Alpha Rim Power", Range(0.0,8.0)) = 1.3
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
			//Cull Off
			ZWrite Off

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#define UNITY_PASS_FORWARDBASE
			#include "UnityCG.cginc"
			#pragma multi_compile_fwdbase
			#pragma multi_compile_fog
			#pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
			#pragma target 3.0


			float4 _MainTex_ST;
			sampler2D _MainTex;
			sampler2D _NormalMap;
			float4 _Color;
			float4 _EmissionColor;
			float _EffectTime;
			half _FallOff;
			half _MeshOffset;
			float _Size;
			//==rim
			float _AlphaPower;
			float _AllPower;
			float _RimPower;
			float _InnerColorPower;
			//====

			struct VertexInput {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 texcoord3 : TEXCOORD3;
			};
			struct VertexOutput {
				//===============
				float4 pos : SV_POSITION;
				float3 normalDir : TEXCOORD0;
				float2 uv3 : TEXCOORD1;
				float4 posWorld : TEXCOORD2;
				float4 viewWorld : TEXCOORD3;
			};
			VertexOutput vert(VertexInput v) {
				VertexOutput o = (VertexOutput)0;
				o.normalDir = UnityObjectToWorldNormal(v.normal);
				v.vertex.xyz += (v.normal*_MeshOffset);
				o.pos = UnityObjectToClipPos(v.vertex);
				o.posWorld = mul(unity_ObjectToWorld, v.vertex);
				o.uv3 = v.texcoord3;
				return o;
			}
			float4 frag(VertexOutput i, float facing : VFACE) : COLOR{
				float isFrontFace = (facing >= 0 ? 1 : 0);
				float faceSign = (facing >= 0 ? 1 : -1);
				float2 uv_n = UnpackNormal(tex2D(_NormalMap, i.normalDir));
				float4 _MainTex_var = tex2D(_MainTex, TRANSFORM_TEX(i.uv3, _MainTex));
				//===rim
				float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
				half rim = 1.0 - saturate(dot(normalize(viewDirection), i.normalDir));
				//====
				//==falloff
				/*half falloff = saturate(dot(o.Normal, normalize(IN.viewDir)));
				falloff = saturate(pow((1.0f - falloff), _FallOff)*pow(falloff, _FallOff2));*/
				half falloff = saturate(pow((1.0f - _FallOff), _FallOff));
				//==
				//=================================
				
				//float3 emissive = (_EmissionColor.rgb + (_MainTex_var.rgb*_Color.rgb*2.0));
				float3 emissive = _EmissionColor.rgb * pow(rim, _RimPower)*_AllPower + (_EmissionColor.rgb * 2 * _InnerColorPower)+ _MainTex_var.rgb*_Color.rgb;
				//float3 emissive = _RimColor.rgb * pow(rim, _RimPower)*_AllPower + (_InnerColor.rgb * 2 * _InnerColorPower);
				float3 finalColor = emissive;
				half alpha=1;
					if (_EffectTime < i.posWorld.y)
					{
						alpha = 0;
					}
					else
					{
						falloff = saturate((_EffectTime- i.posWorld.y)*_Size);
						falloff = saturate(pow(falloff, _FallOff));//pow((1.0f - falloff), _FallOff));// *
						alpha = 1*falloff;
					}
				
				fixed4 finalRGBA = fixed4(finalColor, (pow(rim, _AlphaPower))*_AllPower*alpha);
				//fixed4 finalRGBA = fixed4(finalColor, (_MainTex_var.a*_EmissionColor.a*alpha));
				//UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
				return finalRGBA;
			}
				ENDCG
		}
	}
}
