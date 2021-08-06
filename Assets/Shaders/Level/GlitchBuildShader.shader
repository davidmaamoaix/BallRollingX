Shader "Custom/GlitchBuildShader" {

    Properties {
        _Color ("Color", Color) = (1, 1, 1, 1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0, 1)) = 0.5
        _Metallic ("Metallic", Range(0, 1)) = 0
        _Percentage ("Build Percentage", Range(0, 1)) = 1
        _BuildTex ("Build Texture", 2D) = "white" {}
        [HDR] _BuildColor ("BuildColor", Color) = (1, 1, 1, 1)
    }

    SubShader {

        Tags {
            "RenderType"="Opaque"
        }

        LOD 200

        CGPROGRAM
        
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0
        
        struct Input {
            float2 uv_MainTex;
            float2 uv_BuildTex;
        };

        sampler2D _MainTex;
        sampler2D _BuildTex;
        half _Glossiness;
        half _Metallic;
        float4 _Color;
        float4 _BuildColor;
        float _Percentage;

        void surf(Input IN, inout SurfaceOutputStandard o) {

            clip(_Percentage - IN.uv_MainTex.x);
            
            float4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            float4 emit = tex2D(_BuildTex, IN.uv_BuildTex) * _Color;
            o.Albedo = c.rgb;
            
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = IN.uv_MainTex;
            //o.Emission = emit * _BuildColor;
        }

        ENDCG
    }

    FallBack "Diffuse"
}
