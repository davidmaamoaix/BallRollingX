Shader "Custom/GlitchImageEffect" {

    Properties {
        _MainTex ("Texture", 2D) = "white" {}
        _NoiseTex ("Noise Texture", 2D) = "white" {}
        _Intensity ("Glitch Intensity", Range(0, 1)) = 0.5
        _Speed ("Glitch Speed", Range(0, 1)) = 0.5
        _RedSpeed ("Red Speed", Range(0, 2)) = 1
        _GreSpeed ("Green Speed", Range(0, 2)) = 1
    }

    SubShader {
        
        Cull Off ZWrite Off ZTest Always

        Pass {

            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            sampler2D _MainTex;
            sampler2D _NoiseTex;
            float _Intensity;
            float _Speed;
            float4 _RedSpeed;
            float4 _GreSpeed;

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
                fixed4 col = tex2D(_MainTex, i.uv);

                float time = _Time[1] * 0.25;
                float2 redOffset = float2(sin(time), cos(time)) * 0.05;
                float2 greOffset = float2(cos(time), sin(time)) * 0.05;

                fixed4 red = tex2D(_MainTex, i.uv - redOffset) * _Intensity;
                fixed4 gre = tex2D(_MainTex, i.uv - greOffset) * _Intensity;

                float offset = _Time[0] * _Speed;
                fixed4 renderRed = tex2D(_NoiseTex, float2(offset, 0));
                fixed4 renderGreen = tex2D(_NoiseTex, float2(offset + 0.5, 0));

                red *= float4(1, 0, 0, 1) * renderRed;
                gre *= float4(0, 1, 0, 1) * renderGreen;
                
                return col + red + gre;
            }

            ENDCG
        }
    }
}
