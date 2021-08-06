Shader "Custom/GlitchBuildShader" {

    Properties {
        _Color ("Color", Color) = (1, 1, 1, 1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0, 1)) = 0.5
        _Metallic ("Metallic", Range(0, 1)) = 0
        _Percentage ("Build Percentage", Range(0, 1)) = 1
        _BuildTex ("Build Texture", 2D) = "white" {}
        _Falloff ("Color Fall Off", Float) = 0.9
        _FlucSpeed ("Fluctuation Speed", Float) = 1
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
        float _Falloff;
        float _FlucSpeed;

        void surf(Input IN, inout SurfaceOutputStandard o) {

            float dist = _Percentage - IN.uv_MainTex.x;
            clip(dist);
            
            float4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            float4 emit = tex2D(_BuildTex, IN.uv_BuildTex) * _Color;

            float strength = saturate(1 - abs(dist) - _Falloff);
            float fluc = saturate(sin(_Time.z * _FlucSpeed) / 2 + 1);

            o.Albedo = c.rgb;
            
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = IN.uv_MainTex;
            o.Emission = emit * _BuildColor * pow(strength, 2) * fluc;
        }

        ENDCG
    }

    FallBack "Diffuse"
}
