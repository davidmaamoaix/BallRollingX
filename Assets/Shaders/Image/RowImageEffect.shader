Shader "Custom/RowImageEffect" {

    Properties {
        _MainTex ("Texture", 2D) = "white" {}
        _RowSpeed ("Row Speed", Range(0, 10)) = 1
        _RowSize ("Row Size", Range(0, 1)) = 0.7
        _RowPow ("Row Power", Range(5, 20)) = 2
    }

    SubShader {
        
        Cull Off ZWrite Off ZTest Always

        Pass {

            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            sampler2D _MainTex;
            float _RowSpeed;
            float _RowSize;
            float _RowPow;

            struct appdata {
                float4 vertex: POSITION;
                float2 uv: TEXCOORD0;
            };

            struct v2f {
                float2 uv: TEXCOORD0;
                float4 vertex: SV_POSITION;
            };

            v2f vert(appdata v) {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i): SV_Target {
                float rowPos = 1 - frac(_Time[0] * _RowSpeed);
                float noise = saturate(1 - abs(rowPos - i.uv.y) - _RowSize);
                float offset = pow(noise * 2, _RowPow);

                fixed4 col = tex2D(_MainTex, float2(i.uv.x + offset, i.uv.y));
                
                return col + (noise * float4(0.75, 0.75, 0.75, 1));
            }

            ENDCG
        }
    }
}
