Shader "ffCustom/surface/ffAlphaHologramOffsetShader" {
	Properties {
		_Color ("Color", Color) = (0.7, 1, 1, 0) 
		_MainTex ("MainTex", 2D) = "white" {}
		_HologramTex ("HologramTex", 2D) = "white" {}
		_NormalMap ("NormalMap", 2D) = "bump" {}
		_Emission ("Emission", Range(0.0,10.0)) = 0.5
		_CamDistance("CamDistance", Float) = 0.0
		_MeshOffset("MeshOffset", Float) = 0.1
		_EffectTime("Effect Time (ms)", float) = 0
	}
     
	SubShader {
		Tags { "Queue" = "Transparent" "RenderType" = "Transparent" }
		LOD 2000
		Cull Off
       	
		CGPROGRAM
		#pragma surface surf Lambert vertex:vert alpha
		//==============================
		#include "UnityCG.cginc"
		#pragma target 3.0
		
		float4 _HologramTex_ST;
		sampler2D _HologramTex;

		sampler2D _MainTex;
		sampler2D _NormalMap;	
		float4 _Color; 
		half _Emission; 
		half _MeshOffset; 
		float _CamDistance;   
		float _EffectTime;                       
          
       	struct Input {
			float2 uv_MainTex;
			float2 uv_NormalMap;
			float4 screenPos;
			float3 worldPos;
		};
		       
		void vert (inout appdata_full v, out Input o) {
			UNITY_INITIALIZE_OUTPUT(Input,o);
			//v.vertex.xyz += (v.normal*_MeshOffset);
			//if (_EffectTime < Input.worldPos.y)
			//{
			//	v.vertex.xyz += (v.normal*_MeshOffset);
			//}
			if (_EffectTime <v.vertex.y)// o.worldPos.y-10)
			{
				v.vertex.xyz += (v.normal*_MeshOffset);
			}
		}
		
		void surf (Input IN, inout SurfaceOutput o) {
			float2 uv_n = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap));
						
			float2 screenUV = (IN.screenPos.xy / IN.screenPos.w)*_HologramTex_ST.xy*_CamDistance;
          	float3 hologram = tex2D (_MainTex, screenUV+_HologramTex_ST.zw+uv_n);
						
			fixed4 main = tex2D (_MainTex,IN.uv_MainTex);
			half alpha=1;
			if (_EffectTime < IN.worldPos.y)
			{
				alpha = 0;
			}
			else
			{
				alpha = 1;
			}

			o.Albedo = main.rgb;//*hologram.rgb;// * _Color.rgb;
			o.Emission = hologram.rgb * _Color.rgb * _Emission;
			//o.Emission =  saturate((1.0-(1.0-main.rgb)*(1.0-(hologram.rgb*_Color.rgb))))* _Emission;
	        o.Alpha =  _Color.a *alpha*main.r;//
			////=====================
			
			//o.Albedo = main.rgb * _Color.rgb;
			//o.Emission = main.rgb * _Color.rgb * _Emission; 
	  //      o.Alpha = _Color.a * main.r* alpha;
			/////======================
			
		}		
		ENDCG
     } 
     Fallback "Transparent/Diffuse"
 }