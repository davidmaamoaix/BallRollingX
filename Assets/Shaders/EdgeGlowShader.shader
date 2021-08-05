Shader "Custom/EdgeGlowShader" {

    Properties {
        _Color ("Color", Color) = (1, 1, 1, 1)
        [HDR] _EdgeColor ("Color", Color) = (1, 1, 1, 1)
    }

    SubShader {

        Tags {
            "RenderType" = "Opaque"
        }

        LOD 200

        CGPROGRAM

        #pragma surface surf Lambert fullforwardshadows
        #pragma target 3.0

        struct Input {
            float2 uv_MainTex;
        };

        fixed4 _Color;
        fixed4 _EdgeColor;

        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf(Input IN, inout SurfaceOutput o) {
            
            o.Albedo = _Color;
            o.Emission = _EdgeColor;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
