// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge v1.35 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.35;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:3138,x:33375,y:32932,varname:node_3138,prsc:2|emission-2700-OUT,clip-1406-OUT;n:type:ShaderForge.SFN_Color,id:7241,x:32242,y:32569,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_7241,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.07843138,c2:0.3921569,c3:0.7843137,c4:1;n:type:ShaderForge.SFN_Tex2d,id:4929,x:32272,y:32781,ptovrint:False,ptlb:MainTexture,ptin:_MainTexture,varname:node_4929,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:6163,x:32963,y:32877,varname:node_6163,prsc:2|A-4929-RGB,B-7013-OUT,C-24-OUT,D-7241-A,E-7241-RGB;n:type:ShaderForge.SFN_ValueProperty,id:1416,x:32056,y:33200,ptovrint:False,ptlb:EffectTime,ptin:_EffectTime,varname:node_1416,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5;n:type:ShaderForge.SFN_ValueProperty,id:1084,x:32038,y:33425,ptovrint:False,ptlb:BottomValue,ptin:_BottomValue,varname:node_1084,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_FragmentPosition,id:7365,x:31980,y:33272,varname:node_7365,prsc:2;n:type:ShaderForge.SFN_Subtract,id:7100,x:32263,y:33218,varname:node_7100,prsc:2|A-1416-OUT,B-7365-Y;n:type:ShaderForge.SFN_Subtract,id:2809,x:32263,y:33356,varname:node_2809,prsc:2|A-7365-Y,B-1084-OUT;n:type:ShaderForge.SFN_Slider,id:3105,x:32109,y:33725,ptovrint:False,ptlb:TransientSize,ptin:_TransientSize,varname:node_3105,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0.01,cur:0.01,max:10;n:type:ShaderForge.SFN_Divide,id:4528,x:32457,y:33278,varname:node_4528,prsc:2|A-7100-OUT,B-3105-OUT;n:type:ShaderForge.SFN_Divide,id:4517,x:32467,y:33436,varname:node_4517,prsc:2|A-2809-OUT,B-3105-OUT;n:type:ShaderForge.SFN_Step,id:3183,x:32263,y:33060,varname:node_3183,prsc:2|A-7365-Y,B-1416-OUT;n:type:ShaderForge.SFN_Step,id:7592,x:32241,y:33553,varname:node_7592,prsc:2|A-1084-OUT,B-7365-Y;n:type:ShaderForge.SFN_If,id:24,x:32762,y:33049,varname:node_24,prsc:2|A-7100-OUT,B-3105-OUT,GT-3183-OUT,EQ-4864-OUT,LT-4864-OUT;n:type:ShaderForge.SFN_If,id:7013,x:32829,y:33610,varname:node_7013,prsc:2|A-2809-OUT,B-3105-OUT,GT-7592-OUT,EQ-3890-OUT,LT-3890-OUT;n:type:ShaderForge.SFN_ConstantLerp,id:4864,x:32647,y:33278,varname:node_4864,prsc:2,a:0,b:1|IN-4528-OUT;n:type:ShaderForge.SFN_ConstantLerp,id:3890,x:32647,y:33436,varname:node_3890,prsc:2,a:0,b:1|IN-4517-OUT;n:type:ShaderForge.SFN_Multiply,id:1406,x:33080,y:33372,varname:node_1406,prsc:2|A-3183-OUT,B-7592-OUT;n:type:ShaderForge.SFN_ValueProperty,id:4024,x:32481,y:32987,ptovrint:False,ptlb:Emission,ptin:_Emission,varname:node_4024,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Multiply,id:2700,x:33124,y:33012,varname:node_2700,prsc:2|A-6163-OUT,B-4024-OUT;proporder:7241-4929-1416-1084-3105-4024;pass:END;sub:END;*/

Shader "Shader Forge/TextureScan" {
    Properties {
        _Color ("Color", Color) = (0.07843138,0.3921569,0.7843137,1)
        _MainTexture ("MainTexture", 2D) = "white" {}
        _EffectTime ("EffectTime", Float ) = 0.5
        _BottomValue ("BottomValue", Float ) = 0
        _TransientSize ("TransientSize", Range(0.01, 10)) = 0.01
        _Emission ("Emission", Float ) = 1
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
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _Color;
            uniform sampler2D _MainTexture; uniform float4 _MainTexture_ST;
            uniform float _EffectTime;
            uniform float _BottomValue;
            uniform float _TransientSize;
            uniform float _Emission;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float node_3183 = step(i.posWorld.g,_EffectTime);
                float node_7592 = step(_BottomValue,i.posWorld.g);
                clip((node_3183*node_7592) - 0.5);
////// Lighting:
////// Emissive:
                float4 _MainTexture_var = tex2D(_MainTexture,TRANSFORM_TEX(i.uv0, _MainTexture));
                float node_2809 = (i.posWorld.g-_BottomValue);
                float node_7013_if_leA = step(node_2809,_TransientSize);
                float node_7013_if_leB = step(_TransientSize,node_2809);
                float node_3890 = lerp(0,1,(node_2809/_TransientSize));
                float node_7100 = (_EffectTime-i.posWorld.g);
                float node_24_if_leA = step(node_7100,_TransientSize);
                float node_24_if_leB = step(_TransientSize,node_7100);
                float node_4864 = lerp(0,1,(node_7100/_TransientSize));
                float3 emissive = ((_MainTexture_var.rgb*lerp((node_7013_if_leA*node_3890)+(node_7013_if_leB*node_7592),node_3890,node_7013_if_leA*node_7013_if_leB)*lerp((node_24_if_leA*node_4864)+(node_24_if_leB*node_3183),node_4864,node_24_if_leA*node_24_if_leB)*_Color.a*_Color.rgb)*_Emission);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Back
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float _EffectTime;
            uniform float _BottomValue;
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float4 posWorld : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float node_3183 = step(i.posWorld.g,_EffectTime);
                float node_7592 = step(_BottomValue,i.posWorld.g);
                clip((node_3183*node_7592) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
