// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/myHologramShaderNotScreen"
{
	Properties
	{
		_Color("Color", Color) = (0.7, 1, 1, 0)
		_MainTex("MainTex", 2D) = "white" {}
		_NormalMap("NormalMap", 2D) = "bump" {}
		//_Emission("Emission", Range(0.0,10.0)) = 0.5
		_EmissionColor("EmissionColor", Color) = (0.7, 1, 1, 0)

		_FallOff("FallOff", Range(0.0,10.0)) = 5.0
	/*	_FallOff2("FallOff2", Range(0.0,10.0)) = 5.0*/
		_MeshOffset("MeshOffset", Float) = 0.1
		//_BrightnessCollision("BrightnessPointCollision", Range(0.0,1.0)) = 0.5
		//_MaxDistance("SizePointCollision", float) = 1
		//_Position("Collision", Vector) = (-1, -1, -1, -1)
		_EffectTime("Effect Time (ms)", float) = 0


		_CamDistance("CamDistance", Float) = 0.0
	}
	SubShader
		{
			Blend One Zero
			Blend Zero One
			/*Blend SrcAlpha OneMinusSrcAlpha
			Blend DstColor Zero*/
			Tags{ "Queue" = "Transparent" "RenderType" = "Transparent" }
			LOD 2000
			Cull Off

			CGPROGRAM
			#pragma surface surf Lambert vertex:vert alpha
			//#pragma surface surf BasicDiffuse  
			//#pragma surface surf Lambert finalcolor:mycolor
			//#pragma surface surf Lambert vertex:vert
			//#pragma surface surf Lambert
			#pragma target 3.0


			sampler2D _MainTex;
			sampler2D _NormalMap;
			float4 _Color;
			half _Emission;
			float4 _EmissionColor;
			float _EffectTime;
			half _FallOff;
			half _MeshOffset;
			float _CamDistance;

			struct Input {
				float2 uv_MainTex;
				float2 uv3_MainTex;
				float2 uv_NormalMap;
				float3 viewDir;
				float customDist;
				float4 screenPos;
				float3 worldPos;
			};

			void vert(inout appdata_full v, out Input o) {
				UNITY_INITIALIZE_OUTPUT(Input, o);
				v.vertex.xyz += v.normal*_MeshOffset;
				//o.customDist = distance(_Position.xyz, v.vertex.xyz);
				o.worldPos = mul(unity_ObjectToWorld, v.vertex);
			}
			void surf(Input IN, inout SurfaceOutput o) {
				float2 uv_n = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap));
				//float2 screenUV = (IN.screenPos.xy / IN.screenPos.w)*_MainTex_ST.xy*_CamDistance;
				//float3 c = tex2D(_MainTex, IN.uv_MainTex + uv_n) * _Color;
				//float4 c = tex2D(_MainTex, screenUV + _MainTex_ST.zw + uv_n);//screenUV + _MainTex_ST.zw+ uv_n
				float4 c = tex2D(_MainTex, IN.uv3_MainTex);
				//float4 c = tex2D(_MainTex, IN.uv_MainTex);

				half falloff = saturate(dot(o.Normal, normalize(IN.viewDir)));
				//falloff = saturate(pow((1.0f - falloff), _FallOff)*pow(falloff, _FallOff2));

				half alpha;
				//alpha = saturate(_EffectTime - (IN.customDist / _MaxDistance)) + _Color.a * falloff;
				if (_EffectTime > 0)
				{
					//if (_EffectTime < screenUV.y) alpha = 0;
					//if (_EffectTime <  _MainTex_ST.zw.y) alpha = 0;
					if (_EffectTime < IN.worldPos.y) alpha = 0;
					else alpha = 1;
				}
				else {
					alpha = 1;
				}
			

				/*o.Albedo = c.rgb;
				o.Emission = c.rgb*_Emission;
				o.Alpha = alpha;*/

				o.Albedo = c.rgb *_Color.rgb;// c.rgb;
				o.Emission = _EmissionColor;// c.rgb * _Color.rgb * _Emission;
				o.Alpha = _EmissionColor.a*alpha;
				//if (c.a ==1)
				//{
				//	o.Emission = c.rgb *_Color.rgb;
				//	o.Alpha = c.a*_Color.a;// alpha*_EmissionColor.a;// *falloff;
				//}
				//else {
				//	o.Emission = _EmissionColor;// c.rgb * _Color.rgb * _Emission;
				//	o.Alpha = _EmissionColor.a;
				//}
				

			}
			ENDCG
		}
	Fallback "Transparent/Diffuse"
}
