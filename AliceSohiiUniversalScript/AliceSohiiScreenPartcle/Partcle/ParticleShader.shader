Shader "Unlit/ParticleShader"
{
    Properties
    {
        _baseColor("baseColor", Color) = (0.254902,0.8588236,0.8352942,1)
        _uvOffset("uvOffset", Vector) = (0,-0.3,0,0)
        _flickInterval_Amplitude("flickInterval_Amplitude", Vector)=(0.05,0.5,0,0)
        _rotation("Rotation", Range(0, 360)) = 0
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Transparent" "Queue"="Transparent" }
        Cull Back
		AlphaToMask On
		Blend One One
        ZWrite On
		
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                
            };

            //sampler2D _MainTex;
            //float4 _MainTex_ST;
            float2 Rotate(float2 uv, float2 center, float rotation)
            {
                float sin_rad = sin(rotation);
                float cos_rad = cos(rotation);
                float2x2 rotation_matrix = float2x2(cos_rad, sin_rad, -sin_rad, cos_rad);
                uv -= center;
                uv = mul(rotation_matrix, uv);
                uv += center;
                return uv;
            }
            float DrawTriangle(float2 uv, float rotation, float scale)
            {
                uv = (uv - float2(0.5, 0.5)) * 2;
                float2 uv0 = Rotate(uv,float2(0,0),rotation);
                float2 uv1 = Rotate(uv,float2(0,0),rotation + radians(120));
                float2 uv2 = Rotate(uv,float2(0,0),rotation + radians(240));
                float sdf = max(max(uv0.y, uv1.y), uv2.y);
                return step(sdf, scale);
            }
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }
            float2 _uvOffset;
            float2 _flickInterval_Amplitude;
            float4 _baseColor;
            float _rotation;
            fixed4 frag (v2f i) : SV_Target
            {
                float time = ((sin(_Time.y*50)+1)*0.5);
                float sdfMask= time*_flickInterval_Amplitude.x+_flickInterval_Amplitude.y;
                float mask = DrawTriangle(i.uv+_uvOffset,_rotation * (3.1415926*2)/360 ,sdfMask);
                UNITY_APPLY_FOG(i.fogCoord, col);
                
                return mask*_baseColor*sdfMask*2;
            }
            ENDCG
        }
    }
}
