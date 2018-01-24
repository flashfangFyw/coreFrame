// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unlit/gridShader"
{
	Properties
	{
		_Color("Color", Color) = (0.7, 1, 1, 0)
		_MainTex("MainTex", 2D) = "white" {}
		_NormalMap("NormalMap", 2D) = "bump" {}
		_EmissionColor("EmissionColor", Color) = (0.7, 1, 1, 0)

		_FallOff("FallOff", Range(0.0,10.0)) = 5.0
		_MeshOffset("MeshOffset", Float) = 0.1
		_EffectTime("Effect Time (ms)", float) = 0
		_CamDistance("CamDistance", Float) = 0.0
	}
	SubShader
	{
		Tags{ "Queue" = "Transparent" "RenderType" = "Transparent" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

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
			};

			float4 _MainTex_ST;
			sampler2D _MainTex;
			sampler2D _NormalMap;
			float4 _Color;
			float4 _EmissionColor;
			float _EffectTime;
			half _FallOff;
			half _MeshOffset;
			float _CamDistance;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				//v.vertex.xyz += v.normal*_MeshOffset;

				//o.uv2 = ;


				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv);
				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
				//=======================
				//float2 screenUV = (i.screenPos.xy / i.screenPos.w)*_MainTex_ST.xy*_CamDistance;
				//float4 col = tex2D(_MainTex, screenUV + _MainTex_ST.zw );//screenUV + _MainTex_ST.zw+ uv_n
				//half falloff = saturate(dot(o.Normal, normalize(IN.viewDir)));
				//half alpha;
				//if (_EffectTime > 0)
				//{
				//	if (_EffectTime < IN.worldPos.y) alpha = 0;
				//	else alpha = 1;
				//}
				//else {
				//	alpha = 1;
				//}

				//o.Albedo = col.rgb *_Color.rgb;
				//o.Emission = _EmissionColor;
				//o.Alpha = _EmissionColor.a*alpha;
			}
			ENDCG
		}
	}
}
