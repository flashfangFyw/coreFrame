// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:False,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:True,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:False,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:True,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:True,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:4795,x:32957,y:32658,varname:node_4795,prsc:2|emission-1136-OUT,alpha-2426-A,clip-5025-OUT;n:type:ShaderForge.SFN_Multiply,id:2393,x:32367,y:32686,varname:node_2393,prsc:2|A-6098-RGB,B-5309-OUT,C-2426-RGB,D-4000-OUT;n:type:ShaderForge.SFN_Slider,id:5309,x:31672,y:32662,ptovrint:False,ptlb:Emission,ptin:_Emission,varname:node_5309,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:3.840697,max:10;n:type:ShaderForge.SFN_ScreenPos,id:5904,x:31487,y:32459,varname:node_5904,prsc:2,sctp:0;n:type:ShaderForge.SFN_Tex2d,id:6098,x:32081,y:32553,varname:node_6098,prsc:2,tex:d014008621d9f1d4f800ca0e2ef09083,ntxv:0,isnm:False|UVIN-1539-OUT,TEX-3608-TEX;n:type:ShaderForge.SFN_Tex2dAsset,id:3608,x:31793,y:32470,ptovrint:False,ptlb:HologramTex,ptin:_HologramTex,varname:node_3608,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:d014008621d9f1d4f800ca0e2ef09083,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Slider,id:9783,x:31423,y:32146,ptovrint:False,ptlb:CamDistance,ptin:_CamDistance,varname:node_9783,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:2.222222,max:10;n:type:ShaderForge.SFN_Multiply,id:1520,x:31737,y:32306,varname:node_1520,prsc:2|A-9783-OUT,B-5904-UVOUT,C-2757-UVOUT;n:type:ShaderForge.SFN_ValueProperty,id:7758,x:31962,y:33250,ptovrint:False,ptlb:EffectTime,ptin:_EffectTime,varname:node_7758,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5;n:type:ShaderForge.SFN_FragmentPosition,id:9052,x:31606,y:33334,varname:node_9052,prsc:2;n:type:ShaderForge.SFN_Step,id:2,x:32122,y:33080,varname:node_2,prsc:2|A-9052-Y,B-7758-OUT;n:type:ShaderForge.SFN_TexCoord,id:2757,x:31504,y:32662,varname:node_2757,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:1539,x:32081,y:32475,varname:node_1539,prsc:2|A-1520-OUT,B-2757-UVOUT,C-5992-RGB;n:type:ShaderForge.SFN_Tex2d,id:5992,x:32058,y:32324,ptovrint:False,ptlb:NormalMap,ptin:_NormalMap,varname:node_5992,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Fresnel,id:4000,x:31822,y:32969,varname:node_4000,prsc:2|EXP-5786-OUT;n:type:ShaderForge.SFN_Slider,id:5786,x:31430,y:32960,ptovrint:False,ptlb:FresnelRim,ptin:_FresnelRim,varname:node_5786,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1.623932,max:2;n:type:ShaderForge.SFN_Color,id:2426,x:31862,y:32786,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_2426,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0.210649,c3:0.9852941,c4:0.503;n:type:ShaderForge.SFN_Subtract,id:5137,x:31891,y:33350,varname:node_5137,prsc:2|A-7758-OUT,B-9052-Y;n:type:ShaderForge.SFN_Divide,id:7766,x:32012,y:33424,varname:node_7766,prsc:2|A-5137-OUT,B-9003-OUT;n:type:ShaderForge.SFN_ConstantLerp,id:4029,x:32219,y:33495,varname:node_4029,prsc:2,a:0,b:1|IN-7766-OUT;n:type:ShaderForge.SFN_If,id:6050,x:32455,y:33205,varname:node_6050,prsc:2|A-5137-OUT,B-9003-OUT,GT-2-OUT,EQ-4029-OUT,LT-4029-OUT;n:type:ShaderForge.SFN_Multiply,id:1136,x:32614,y:32706,varname:node_1136,prsc:2|A-2393-OUT,B-6050-OUT,C-4716-OUT;n:type:ShaderForge.SFN_Slider,id:9003,x:31613,y:33702,ptovrint:False,ptlb:TransientSize,ptin:_TransientSize,varname:node_9003,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0.001,cur:0.001,max:10;n:type:ShaderForge.SFN_ValueProperty,id:5855,x:31727,y:33874,ptovrint:False,ptlb:BottomValue,ptin:_BottomValue,varname:node_5855,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Step,id:2309,x:32188,y:33723,varname:node_2309,prsc:2|A-5855-OUT,B-9052-Y;n:type:ShaderForge.SFN_Multiply,id:5025,x:32754,y:33139,varname:node_5025,prsc:2|A-2-OUT,B-2309-OUT;n:type:ShaderForge.SFN_If,id:4716,x:32652,y:33505,varname:node_4716,prsc:2|A-7455-OUT,B-9003-OUT,GT-2309-OUT,EQ-5684-OUT,LT-5684-OUT;n:type:ShaderForge.SFN_Subtract,id:7455,x:32019,y:33875,varname:node_7455,prsc:2|A-9052-Y,B-5855-OUT;n:type:ShaderForge.SFN_Divide,id:7798,x:32244,y:33875,varname:node_7798,prsc:2|A-7455-OUT,B-9003-OUT;n:type:ShaderForge.SFN_ConstantLerp,id:5684,x:32429,y:33815,varname:node_5684,prsc:2,a:0,b:1|IN-7798-OUT;proporder:3608-5992-7758-5855-2426-5309-5786-9003-9783;pass:END;sub:END;*/

Shader "Shader Forge/hologramShaderForShaderForgeUnlit" {
    Properties {
        _HologramTex ("HologramTex", 2D) = "white" {}
        _NormalMap ("NormalMap", 2D) = "bump" {}
        _EffectTime ("EffectTime", Float ) = 0.5
        _BottomValue ("BottomValue", Float ) = 0
        _Color ("Color", Color) = (0,0.210649,0.9852941,0.503)
        _Emission ("Emission", Range(0, 10)) = 3.840697
        _FresnelRim ("FresnelRim", Range(0, 2)) = 1.623932
        _TransientSize ("TransientSize", Range(0.001, 10)) = 0.001
        _CamDistance ("CamDistance", Range(0, 10)) = 2.222222
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
            
            AlphaToMask On
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal 
            #pragma target 3.0
            uniform float _Emission;
            uniform sampler2D _HologramTex; uniform float4 _HologramTex_ST;
            uniform float _CamDistance;
            uniform float _EffectTime;
            uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            uniform float _FresnelRim;
            uniform float4 _Color;
            uniform float _TransientSize;
            uniform float _BottomValue;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float4 projPos : TEXCOORD3;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float node_2 = step(i.posWorld.g,_EffectTime);
                float node_2309 = step(_BottomValue,i.posWorld.g);
                clip((node_2*node_2309) - 0.5);
////// Lighting:
////// Emissive:
                float3 _NormalMap_var = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(i.uv0, _NormalMap)));
                float3 node_1539 = (float3((_CamDistance*(sceneUVs * 2 - 1).rg*i.uv0),0.0)+float3(i.uv0,0.0)+_NormalMap_var.rgb);
                float4 node_6098 = tex2D(_HologramTex,TRANSFORM_TEX(node_1539, _HologramTex));
                float node_5137 = (_EffectTime-i.posWorld.g);
                float node_6050_if_leA = step(node_5137,_TransientSize);
                float node_6050_if_leB = step(_TransientSize,node_5137);
                float node_4029 = lerp(0,1,(node_5137/_TransientSize));
                float node_7455 = (i.posWorld.g-_BottomValue);
                float node_4716_if_leA = step(node_7455,_TransientSize);
                float node_4716_if_leB = step(_TransientSize,node_7455);
                float node_5684 = lerp(0,1,(node_7455/_TransientSize));
                float3 emissive = ((node_6098.rgb*_Emission*_Color.rgb*pow(1.0-max(0,dot(normalDirection, viewDirection)),_FresnelRim))*lerp((node_6050_if_leA*node_4029)+(node_6050_if_leB*node_2),node_4029,node_6050_if_leA*node_6050_if_leB)*lerp((node_4716_if_leA*node_5684)+(node_4716_if_leB*node_2309),node_5684,node_4716_if_leA*node_4716_if_leB));
                float3 finalColor = emissive;
                return fixed4(finalColor,_Color.a);
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
