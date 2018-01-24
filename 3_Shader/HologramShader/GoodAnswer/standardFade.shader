// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/standardFade"
{
	Properties
	{
		//_MainTex ("Texture", 2D) = "white" {}
		_EffectTime("Effect Time (ms)", float) = 0
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
			//Blend SrcAlpha OneMinusSrcAlpha
			Blend Zero One
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
			
			float _EffectTime;

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
				float4 posWorld : TEXCOORD1;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				//o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.posWorld = mul(unity_ObjectToWorld, v.vertex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			float4 frag(v2f i, float facing : VFACE) : COLOR
			{
				float isFrontFace = (facing >= 0 ? 1 : 0);
				float faceSign = (facing >= 0 ? 1 : -1);
				//=================================
				half alpha = 1;
				if (_EffectTime < i.posWorld.y)
				{
					alpha = 0;
				}
				else
				{
					alpha = 1;
				}

				return alpha;
			}
			ENDCG
		}
	}
}
