Shader "XZF/C6/BlinnPhong"
{
    Properties
    {
        _Diffuse("Diffuse", Color) = (1,1,1,1)
        _Specular("Specular", Color) = (1,1,1,1)
        _Gloss("Gloss", Range(8, 256)) = 20
    }
    SubShader
    {
        Pass
        {
            Tags{
                "LightModel" = "FowardBase"
            }

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "Lighting.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 wPos : TEXCOORD0;
                float3 wNormal : TEXCOORD1;
            };

            fixed4 _Diffuse;
            fixed4 _Specular;
            float _Gloss;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.wNormal = normalize(UnityObjectToWorldNormal(v.normal)); 
                o.wPos = UnityObjectToWorldDir(v.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;

                fixed3 wLight = normalize(UnityWorldSpaceLightDir(i.wPos));
                fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * saturate(dot(i.wNormal, wLight));

                fixed3 viewDir = normalize(UnityWorldSpaceViewDir(i.wPos));
                fixed3 halfDir = normalize(wLight + viewDir);
                fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(max(0, dot(i.wNormal, halfDir)), _Gloss);
                fixed3 color = ambient + diffuse + specular;

                return fixed4(color, 1);
            }
            ENDCG
        }
    }
}
