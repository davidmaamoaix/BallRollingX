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
            float3 viewDir;
            float3 worldNormal;
        };

        fixed4 _Color;
        fixed4 _EdgeColor;

        void surf(Input IN, inout SurfaceOutput o) {
            float power = saturate(dot(IN.worldNormal, normalize(IN.viewDir)));

            o.Albedo = _Color;
            o.Emission = _EdgeColor * pow(1 - power, 10);
        }

        ENDCG
    }

    FallBack "Diffuse"
}
