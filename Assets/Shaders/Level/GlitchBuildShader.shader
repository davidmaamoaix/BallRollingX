Shader "Custom/GlitchBuildShader" {

    Properties {
        _Color ("Color", Color) = (1, 1, 1, 1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0, 1)) = 0.5
        _Metallic ("Metallic", Range(0, 1)) = 0
        _Percentage ("Build Percentage", Range(0, 1)) = 1
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
        };

        sampler2D _MainTex;
        half _Glossiness;
        half _Metallic;
        fixed4 _Color;
        float _Percentage;

        void surf(Input IN, inout SurfaceOutputStandard o) {

            clip(_Percentage - IN.uv_MainTex.x);
            
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }

        ENDCG
    }

    FallBack "Diffuse"
}
