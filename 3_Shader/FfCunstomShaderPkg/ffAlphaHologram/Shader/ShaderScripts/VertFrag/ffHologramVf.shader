// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "ffCustom/vfShader/ffHologramVf"
{
	Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _Color ("Color", Color) = (0,0.2965517,1,0.309)
        _Emission ("Emission", Range(0, 10)) = 3.840697
        _HologramTex ("HologramTex", 2D) = "white" {}
        _CamDistance ("CamDistance", Range(0, 10)) = 3.637335
        _EffectTime ("EffectTime", Float ) = 0
        _Normal ("Normal", 2D) = "bump" {}
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend One One
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _MainTex;
            uniform float4 _MainTex_ST;
            uniform float4 _Color;
            uniform float _Emission;
            uniform sampler2D _HologramTex; 
            uniform float4 _HologramTex_ST;
            uniform float _CamDistance;
            uniform float _EffectTime;
            uniform sampler2D _Normal; 
            uniform float4 _Normal_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
                float4 screenPos : TEXCOORD5;
                LIGHTING_COORDS(6,7)
                UNITY_FOG_COORDS(8)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex );
                o.screenPos = o.pos;
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                    float isFrontFace = ( facing >= 0 ? 1 : 0 );
                    float faceSign = ( facing >= 0 ? 1 : -1 );
                    i.normalDir = normalize(i.normalDir);
                    i.normalDir *= faceSign;
                i.screenPos = float4( i.screenPos.xy / i.screenPos.w, 0, 0 );
                i.screenPos.y *= _ProjectionParams.x;
                    float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                    float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _Normal_var = UnpackNormal(tex2D(_Normal,TRANSFORM_TEX(i.uv0, _Normal)));
                    float3 normalLocal = _Normal_var.rgb;
                    float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                clip(step(i.posWorld.g,_EffectTime) - 0.5);
                    float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                    float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 diffuseColor = _MainTex_var.rgb;
                float3 diffuse = directDiffuse * diffuseColor;
////// Emissive:
                float3 screenUV = (float3((_CamDistance*i.screenPos.rg*i.uv0),0.0)+float3(i.uv0,0.0)+_Normal_var.rgb);
                float4 HologramTex = tex2D(_HologramTex,TRANSFORM_TEX(screenUV, _HologramTex));
                float3 emissive = (HologramTex.rgb*_Emission*_Color.rgb);
/// Final Color:
                float3 finalColor = diffuse + emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                return finalRGBA;
            }
            ENDCG
        }
    }
}
