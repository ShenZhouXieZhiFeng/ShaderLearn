// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "stone/ShaderTemp"
{
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            struct appdata
            {
                float4 position: POSITION;
                float4 color: COLOR;
            };

            struct v2f
            {
                float4 pos: SV_POSITION;
            };

            v2f vert(appdata v)
            {
                v2f o;
                // o.pos = UnityObjectToClipPos(v.position);
                o.pos = UnityObjectToClipPos(v.position);
                return o;
            }

            float4 frag(v2f f): SV_TARGET
            {
                return 1;
            }

            ENDCG
        }
    }
}
