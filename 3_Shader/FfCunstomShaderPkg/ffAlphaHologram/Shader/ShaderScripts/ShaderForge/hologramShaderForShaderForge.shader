// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge v1.32 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.32;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:2,spmd:1,trmd:0,grmd:0,uamb:False,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:True,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:True,fnfb:True;n:type:ShaderForge.SFN_Final,id:4795,x:32957,y:32658,varname:node_4795,prsc:2|diff-6074-RGB,normal-5992-RGB,emission-2393-OUT,alpha-2426-A,clip-5532-OUT;n:type:ShaderForge.SFN_Tex2d,id:6074,x:32443,y:32248,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:2393,x:32368,y:32834,varname:node_2393,prsc:2|A-6098-RGB,B-5309-OUT,C-2426-RGB,D-4000-OUT;n:type:ShaderForge.SFN_Slider,id:5309,x:31769,y:32885,ptovrint:False,ptlb:Emission,ptin:_Emission,varname:node_5309,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:3.840697,max:10;n:type:ShaderForge.SFN_ScreenPos,id:5904,x:31487,y:32459,varname:node_5904,prsc:2,sctp:0;n:type:ShaderForge.SFN_Tex2d,id:6098,x:32155,y:32742,varname:node_6098,prsc:2,tex:d014008621d9f1d4f800ca0e2ef09083,ntxv:0,isnm:False|UVIN-1539-OUT,TEX-3608-TEX;n:type:ShaderForge.SFN_Tex2dAsset,id:3608,x:31847,y:32698,ptovrint:False,ptlb:HologramTex,ptin:_HologramTex,varname:node_3608,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:d014008621d9f1d4f800ca0e2ef09083,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Slider,id:9783,x:31440,y:32322,ptovrint:False,ptlb:CamDistance,ptin:_CamDistance,varname:node_9783,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:2.222222,max:10;n:type:ShaderForge.SFN_Multiply,id:1520,x:31726,y:32459,varname:node_1520,prsc:2|A-9783-OUT,B-5904-UVOUT,C-2757-UVOUT;n:type:ShaderForge.SFN_ValueProperty,id:7758,x:32127,y:33300,ptovrint:False,ptlb:EffectTime,ptin:_EffectTime,varname:node_7758,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_FragmentPosition,id:9052,x:32139,y:33118,varname:node_9052,prsc:2;n:type:ShaderForge.SFN_Step,id:2,x:32547,y:33036,varname:node_2,prsc:2|A-9052-Y,B-7758-OUT;n:type:ShaderForge.SFN_TexCoord,id:2757,x:31504,y:32662,varname:node_2757,prsc:2,uv:0;n:type:ShaderForge.SFN_Add,id:1539,x:32100,y:32558,varname:node_1539,prsc:2|A-1520-OUT,B-2757-UVOUT,C-5992-RGB;n:type:ShaderForge.SFN_Tex2d,id:5992,x:32058,y:32324,ptovrint:False,ptlb:NormalMap,ptin:_NormalMap,varname:node_5992,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Fresnel,id:4000,x:31866,y:33138,varname:node_4000,prsc:2|EXP-5786-OUT;n:type:ShaderForge.SFN_Slider,id:5786,x:31512,y:33188,ptovrint:False,ptlb:FresnelRim,ptin:_FresnelRim,varname:node_5786,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1.623932,max:2;n:type:ShaderForge.SFN_Color,id:2426,x:31957,y:32976,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_2426,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0.210649,c3:0.9852941,c4:0.503;n:type:ShaderForge.SFN_ValueProperty,id:2360,x:32441,y:33154,ptovrint:False,ptlb:BottomValue,ptin:_BottomValue,varname:node_2360,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Step,id:8437,x:32601,y:33216,varname:node_8437,prsc:2|A-2360-OUT,B-9052-Y;n:type:ShaderForge.SFN_Multiply,id:5532,x:32742,y:33076,varname:node_5532,prsc:2|A-2-OUT,B-8437-OUT;proporder:6074-3608-5992-2426-5309-9783-5786-7758-2360;pass:END;sub:END;*/

Shader "Shader Forge/hologramShaderForShaderForge" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _HologramTex ("HologramTex", 2D) = "white" {}
        _NormalMap ("NormalMap", 2D) = "bump" {}
        _Color ("Color", Color) = (0,0.210649,0.9852941,0.503)
        _Emission ("Emission", Range(0, 10)) = 3.840697
        _CamDistance ("CamDistance", Range(0, 10)) = 2.222222
        _FresnelRim ("FresnelRim", Range(0, 2)) = 1.623932
        _EffectTime ("EffectTime", Float ) = 1
        _BottomValue ("BottomValue", Float ) = 0
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend One One
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Emission;
            uniform sampler2D _HologramTex; uniform float4 _HologramTex_ST;
            uniform float _CamDistance;
            uniform float _EffectTime;
            uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            uniform float _FresnelRim;
            uniform float4 _Color;
            uniform float _BottomValue;
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
                UNITY_FOG_COORDS(6)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos(v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.screenPos = o.pos;
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
                float3 _NormalMap_var = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(i.uv0, _NormalMap)));
                float3 normalLocal = _NormalMap_var.rgb;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                clip((step(i.posWorld.g,_EffectTime)*step(_BottomValue,i.posWorld.g)) - 0.5);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = 1;
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 diffuseColor = _MainTex_var.rgb;
                float3 diffuse = directDiffuse * diffuseColor;
////// Emissive:
                float3 node_1539 = (float3((_CamDistance*i.screenPos.rg*i.uv0),0.0)+float3(i.uv0,0.0)+_NormalMap_var.rgb);
                float4 node_6098 = tex2D(_HologramTex,TRANSFORM_TEX(node_1539, _HologramTex));
                float3 emissive = (node_6098.rgb*_Emission*_Color.rgb*pow(1.0-max(0,dot(normalDirection, viewDirection)),_FresnelRim));
/// Final Color:
                float3 finalColor = diffuse + emissive;
                fixed4 finalRGBA = fixed4(finalColor,_Color.a);
                UNITY_APPLY_FOG_COLOR(i.fogCoord, finalRGBA, fixed4(0.5,0.5,0.5,1));
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Emission;
            uniform sampler2D _HologramTex; uniform float4 _HologramTex_ST;
            uniform float _CamDistance;
            uniform float _EffectTime;
            uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            uniform float _FresnelRim;
            uniform float4 _Color;
            uniform float _BottomValue;
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
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos(v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
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
                float3 _NormalMap_var = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(i.uv0, _NormalMap)));
                float3 normalLocal = _NormalMap_var.rgb;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                clip((step(i.posWorld.g,_EffectTime)*step(_BottomValue,i.posWorld.g)) - 0.5);
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
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
/// Final Color:
                float3 finalColor = diffuse;
                fixed4 finalRGBA = fixed4(finalColor * _Color.a,0);
                UNITY_APPLY_FOG_COLOR(i.fogCoord, finalRGBA, fixed4(0.5,0.5,0.5,1));
                return finalRGBA;
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
