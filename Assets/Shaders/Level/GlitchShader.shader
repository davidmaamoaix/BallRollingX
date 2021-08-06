Shader "Custom/GlitchShader" {

    Properties {
        _MainTex ("Texture", 2D) = "white" {}
        _NoiseTex ("Noise", 2D) = "white" {}
        _Speed ("Speed", Range(0, 2)) = 0.85
        _NoiseBias ("Noise Bias", Range(0, 1)) = 0.65
    }

    SubShader {

        Tags {
            "RenderType" = "Opaque"
        }

        LOD 100

        Pass {

            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata {
                float4 vertex: POSITION;
                float2 uv: TEXCOORD0;
            };

            struct v2f {
                float2 uv: TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex: SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            sampler2D _NoiseTex;
            float4 _NoiseTex_ST;

            float _Speed;
            float _NoiseBias;

            v2f vert(appdata v) {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o, o.vertex);

                return o;
            }

            fixed4 frag (v2f i): SV_Target {
                
                UNITY_APPLY_FOG(i.fogCoord, col);

                float offset = frac(_Time.x * _Speed);
                float noise = tex2D(_NoiseTex, float2(offset, i.uv.x));
                noise = floor(noise + _NoiseBias);
                float col = tex2D(_MainTex, i.uv);

                return float4(noise, noise, noise, 1) * col;
            }

            ENDCG
        }
    }
}
