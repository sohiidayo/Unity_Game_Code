// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "AliceSohiSabaku"
{
	Properties
	{
		[HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[ASEBegin]_UVSelce("UVSelce", Float) = 1
		[NoScaleOffset]_BaseColor("BaseColor", 2D) = "white" {}
		_HeightColoration_LowColor("HeightColoration_LowColor", Color) = (0.7019608,0.3764706,0,1)
		_HeightColoration_HightColor("HeightColoration_HightColor", Color) = (0.8000001,0.5568628,0.2745098,1)
		_HeightColoration_intensity("HeightColoration_intensity", Range( 0 , 1)) = 0.3412706
		_HeightColoration_BaseHeight_Pow_Scale("HeightColoration_BaseHeight_Pow_Scale", Vector) = (0,1,1,0)
		[NoScaleOffset]_MetallicMap("MetallicMap", 2D) = "white" {}
		_BaseObjEmissionMapScale("BaseObjEmissionMapScale", Float) = 1
		_MetalicSelce("MetalicSelce", Range( 0 , 10)) = 0.6117647
		[NoScaleOffset]_SmoothnessMap("SmoothnessMap", 2D) = "white" {}
		_SmoothnessSelce("SmoothnessSelce", Range( 0 , 10)) = 0.6117647
		[NoScaleOffset]_NormalMap("NormalMap", 2D) = "white" {}
		[NoScaleOffset]_FlowSand_NormalMap("FlowSand_NormalMap", 2D) = "bump" {}
		_NormalMapScale("NormalMapScale", Float) = 1
		_uFlowSpeed_vFlowSpeed_UVScele_FlowSandNormalMapScale("uFlowSpeed_vFlowSpeed_UVScele_FlowSandNormalMapScale", Vector) = (0.1,0.1,10,1)
		[Toggle(_NOISE0_VORONOI1_ON)] _Noise0_Voronoi1("Noise0_Voronoi1", Float) = 1
		_KiraKira3var_NoiseScale_Pow_Intensity("KiraKira3var_NoiseScale_Pow_Intensity", Vector) = (10,910.13,290.2,0)
		_KirakiraThreshold_Pow("KirakiraThreshold_Pow", Vector) = (15,10,0,0)
		[HDR]_KiraColor("KiraColor", Color) = (4,3.905882,2.933333,0)
		[Toggle(_USEVERTEXOFFSET_ON)] _UseVertexoffset("UseVertexoffset", Float) = 1
		_VertexNoiseUVFlow("VertexNoiseUVFlow", Vector) = (0.1,0.1,0,0)
		[NoScaleOffset]_VertexOffsetMap("VertexOffsetMap", 2D) = "white" {}
		_VertexOffsetMapScale("VertexOffsetMapScale", Float) = 0.0005
		_VertexOffseUVScale("VertexOffseUVScale", Float) = 1
		[Toggle(_COVERSAND_ON)] _CoverSand("CoverSand", Float) = 1
		_CoverEdge_Pow("CoverEdge_Pow", Float) = 0.3
		_CoverScale("CoverScale", Range( 0 , 10)) = 0
		_BaseObj_Color("BaseObj_Color", Color) = (1,0.8156863,0.6039216,1)
		[NoScaleOffset]_BaseObjBaseColor("BaseObjBaseColor", 2D) = "white" {}
		[NoScaleOffset][Normal]_BaseObjNormalMap("BaseObjNormalMap", 2D) = "bump" {}
		_BaseObjNormalMapScale("BaseObjNormalMapScale", Range( 0 , 10)) = 1
		[NoScaleOffset]_BaseObjMetallicMap("BaseObjMetallicMap", 2D) = "bump" {}
		_BaseObjMetallicMapScale("BaseObjMetallicMapScale", Range( 0 , 10)) = 0.2
		[NoScaleOffset]_BaseObjSomoothnessMap("BaseObjSomoothnessMap", 2D) = "white" {}
		_BaseObjSomoothnessMapScale("BaseObjSomoothnessMapScale", Range( 0 , 10)) = 1
		[NoScaleOffset]_BaseObjEmissionMap("BaseObjEmissionMap", 2D) = "black" {}
		_BaseObjTilingAndOffset("BaseObjTilingAndOffset", Vector) = (10,10,0,0)
		[Toggle(_USEFRENELOUTLINE_ON)] _UseFrenelOutLine("UseFrenelOutLine", Float) = 1
		_FrenelOutLineScale("FrenelOutLineScale", Float) = 1.19
		_FrenelOutLinePow("FrenelOutLinePow", Float) = 18.46
		[ASEEnd][HDR]_FrenelOutLineColor("FrenelOutLineColor", Color) = (0.8773585,0.2973178,0.2690015,0)

		//_TransmissionShadow( "Transmission Shadow", Range( 0, 1 ) ) = 0.5
		//_TransStrength( "Trans Strength", Range( 0, 50 ) ) = 1
		//_TransNormal( "Trans Normal Distortion", Range( 0, 1 ) ) = 0.5
		//_TransScattering( "Trans Scattering", Range( 1, 50 ) ) = 2
		//_TransDirect( "Trans Direct", Range( 0, 1 ) ) = 0.9
		//_TransAmbient( "Trans Ambient", Range( 0, 1 ) ) = 0.1
		//_TransShadow( "Trans Shadow", Range( 0, 1 ) ) = 0.5
		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25
	}

	SubShader
	{
		LOD 0

		

		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
		Cull Back
		AlphaToMask Off
		HLSLINCLUDE
		#pragma target 2.0

		#pragma prefer_hlslcc gles
		#pragma exclude_renderers d3d11_9x 

		#ifndef ASE_TESS_FUNCS
		#define ASE_TESS_FUNCS
		float4 FixedTess( float tessValue )
		{
			return tessValue;
		}
		
		float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
		{
			float3 wpos = mul(o2w,vertex).xyz;
			float dist = distance (wpos, cameraPos);
			float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
			return f;
		}

		float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
		{
			float4 tess;
			tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
			tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
			tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
			tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
			return tess;
		}

		float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
		{
			float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
			float len = distance(wpos0, wpos1);
			float f = max(len * scParams.y / (edgeLen * dist), 1.0);
			return f;
		}

		float DistanceFromPlane (float3 pos, float4 plane)
		{
			float d = dot (float4(pos,1.0f), plane);
			return d;
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlane(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlane(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlane(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlane(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
			return !all (planeTest);
		}

		float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
		{
			float3 f;
			f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
			f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
			f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

			return CalcTriEdgeTessFactors (f);
		}

		float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;
			tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
			tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
			tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
			tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			return tess;
		}

		float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;

			if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
			{
				tess = 0.0f;
			}
			else
			{
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			}
			return tess;
		}
		#endif //ASE_TESS_FUNCS

		ENDHLSL

		
		Pass
		{
			
			Name "Forward"
			Tags { "LightMode"="UniversalForward" }
			
			Blend One Zero, One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA
			

			HLSLPROGRAM
			
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 999999

			
			#pragma multi_compile _ _SCREEN_SPACE_OCCLUSION
			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS
			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
			#pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS _ADDITIONAL_OFF
			#pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
			#pragma multi_compile _ _SHADOWS_SOFT
			#pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
			
			#pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
			#pragma multi_compile _ SHADOWS_SHADOWMASK

			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ LIGHTMAP_ON

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS_FORWARD

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/UnityInstancing.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			
			#if ASE_SRP_VERSION <= 70108
			#define REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR
			#endif

			#if defined(UNITY_INSTANCING_ENABLED) && defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL)
			    #define ENABLE_TERRAIN_PERPIXEL_NORMAL
			#endif

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
			#pragma shader_feature_local _USEVERTEXOFFSET_ON
			#pragma shader_feature_local _COVERSAND_ON
			#pragma shader_feature_local _USEFRENELOUTLINE_ON
			#pragma shader_feature_local _NOISE0_VORONOI1_ON
			float hash(float x) { return frac(x + 1.3215 * 1.8152); }              float hash3(float3 a) { return frac((hash(a.z * 42.8883) + hash(a.y * 36.9125) + hash(a.x * 65.4321)) * 291.1257); }              float3 rehash3(float x) { return float3(hash(((x + 0.5283) * 59.3829) * 274.3487), hash(((x + 0.8192) * 83.6621) * 345.3871), hash(((x + 0.2157f) * 36.6521f) * 458.3971f)); }              float sqr(float x) {return x*x;}             float fastdist(float3 a, float3 b) { return sqr(b.x - a.x) + sqr(b.y - a.y) + sqr(b.z - a.z); }              float2 Voronoi3D(float3 xyz)             {                 float x = xyz.x;                 float y = xyz.y;                 float z = xyz.z;                 float4 p[27];                 for (int _x = -1; _x < 2; _x++) for (int _y = -1; _y < 2; _y++) for(int _z = -1; _z < 2; _z++) {                     float3 _p = float3(floor(x), floor(y), floor(z)) + float3(_x, _y, _z);                     float h = hash3(_p);                     p[(_x + 1) + ((_y + 1) * 3) + ((_z + 1) * 3 * 3)] = float4((rehash3(h) + _p).xyz, h);                 }                 float m = 9999.9999, w = 0.0;                 for (int i = 0; i < 27; i++) {                     float d = fastdist(float3(x, y, z), p[i].xyz);                     if(d < m) { m = d; w = p[i].w; }                 }                 return float2(m, w);             }


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord : TEXCOORD0;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				float4 lightmapUVOrVertexSH : TEXCOORD0;
				half4 fogFactorAndVertexLight : TEXCOORD1;
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
				float4 shadowCoord : TEXCOORD2;
				#endif
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				float4 screenPos : TEXCOORD6;
				#endif
				float4 ase_texcoord7 : TEXCOORD7;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _KiraKira3var_NoiseScale_Pow_Intensity;
			float4 _BaseObj_Color;
			float4 _BaseObjTilingAndOffset;
			float4 _HeightColoration_LowColor;
			float4 _HeightColoration_HightColor;
			float4 _KiraColor;
			float4 _FrenelOutLineColor;
			float4 _uFlowSpeed_vFlowSpeed_UVScele_FlowSandNormalMapScale;
			float3 _HeightColoration_BaseHeight_Pow_Scale;
			float2 _VertexNoiseUVFlow;
			float2 _KirakiraThreshold_Pow;
			float _CoverScale;
			float _MetalicSelce;
			float _BaseObjMetallicMapScale;
			float _FrenelOutLinePow;
			float _FrenelOutLineScale;
			float _BaseObjNormalMapScale;
			float _NormalMapScale;
			float _BaseObjSomoothnessMapScale;
			float _HeightColoration_intensity;
			float _CoverEdge_Pow;
			float _VertexOffsetMapScale;
			float _VertexOffseUVScale;
			float _UVSelce;
			float _BaseObjEmissionMapScale;
			float _SmoothnessSelce;
			#ifdef _TRANSMISSION_ASE
				float _TransmissionShadow;
			#endif
			#ifdef _TRANSLUCENCY_ASE
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _VertexOffsetMap;
			sampler2D _BaseObjBaseColor;
			sampler2D _BaseColor;
			sampler2D _BaseObjNormalMap;
			sampler2D _NormalMap;
			sampler2D _FlowSand_NormalMap;
			sampler2D _BaseObjEmissionMap;
			sampler2D _BaseObjMetallicMap;
			sampler2D _MetallicMap;
			sampler2D _BaseObjSomoothnessMap;
			sampler2D _SmoothnessMap;


			float3 mod3D289( float3 x ) { return x - floor( x / 289.0 ) * 289.0; }
			float4 mod3D289( float4 x ) { return x - floor( x / 289.0 ) * 289.0; }
			float4 permute( float4 x ) { return mod3D289( ( x * 34.0 + 1.0 ) * x ); }
			float4 taylorInvSqrt( float4 r ) { return 1.79284291400159 - r * 0.85373472095314; }
			float snoise( float3 v )
			{
				const float2 C = float2( 1.0 / 6.0, 1.0 / 3.0 );
				float3 i = floor( v + dot( v, C.yyy ) );
				float3 x0 = v - i + dot( i, C.xxx );
				float3 g = step( x0.yzx, x0.xyz );
				float3 l = 1.0 - g;
				float3 i1 = min( g.xyz, l.zxy );
				float3 i2 = max( g.xyz, l.zxy );
				float3 x1 = x0 - i1 + C.xxx;
				float3 x2 = x0 - i2 + C.yyy;
				float3 x3 = x0 - 0.5;
				i = mod3D289( i);
				float4 p = permute( permute( permute( i.z + float4( 0.0, i1.z, i2.z, 1.0 ) ) + i.y + float4( 0.0, i1.y, i2.y, 1.0 ) ) + i.x + float4( 0.0, i1.x, i2.x, 1.0 ) );
				float4 j = p - 49.0 * floor( p / 49.0 );  // mod(p,7*7)
				float4 x_ = floor( j / 7.0 );
				float4 y_ = floor( j - 7.0 * x_ );  // mod(j,N)
				float4 x = ( x_ * 2.0 + 0.5 ) / 7.0 - 1.0;
				float4 y = ( y_ * 2.0 + 0.5 ) / 7.0 - 1.0;
				float4 h = 1.0 - abs( x ) - abs( y );
				float4 b0 = float4( x.xy, y.xy );
				float4 b1 = float4( x.zw, y.zw );
				float4 s0 = floor( b0 ) * 2.0 + 1.0;
				float4 s1 = floor( b1 ) * 2.0 + 1.0;
				float4 sh = -step( h, 0.0 );
				float4 a0 = b0.xzyw + s0.xzyw * sh.xxyy;
				float4 a1 = b1.xzyw + s1.xzyw * sh.zzww;
				float3 g0 = float3( a0.xy, h.x );
				float3 g1 = float3( a0.zw, h.y );
				float3 g2 = float3( a1.xy, h.z );
				float3 g3 = float3( a1.zw, h.w );
				float4 norm = taylorInvSqrt( float4( dot( g0, g0 ), dot( g1, g1 ), dot( g2, g2 ), dot( g3, g3 ) ) );
				g0 *= norm.x;
				g1 *= norm.y;
				g2 *= norm.z;
				g3 *= norm.w;
				float4 m = max( 0.6 - float4( dot( x0, x0 ), dot( x1, x1 ), dot( x2, x2 ), dot( x3, x3 ) ), 0.0 );
				m = m* m;
				m = m* m;
				float4 px = float4( dot( x0, g0 ), dot( x1, g1 ), dot( x2, g2 ), dot( x3, g3 ) );
				return 42.0 * dot( m, px);
			}
			
			float2 MyCustomExpression3_g12( float3 pos )
			{
				return Voronoi3D(pos);
			}
			

			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float3 normalizeResult186 = normalize( v.ase_normal );
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				float temp_output_187_0 = saturate( ase_worldNormal.y );
				float3 CoverOffset185 = ( normalizeResult186 * temp_output_187_0 * _CoverScale );
				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				float2 appendResult40 = (float2(ase_worldPos.x , ase_worldPos.z));
				float2 UVSelce43 = ( _UVSelce * appendResult40 );
				float4 appendResult163 = (float4(0.0 , 0.0 , ( tex2Dlod( _VertexOffsetMap, float4( ( ( _TimeParameters.x * _VertexNoiseUVFlow ) + ( UVSelce43 * _VertexOffseUVScale ) ), 0, 0.0) ).r * _VertexOffsetMapScale ) , 0.0));
				#ifdef _USEVERTEXOFFSET_ON
				float4 staticSwitch165 = appendResult163;
				#else
				float4 staticSwitch165 = float4( 0,0,0,0 );
				#endif
				float4 FlowSandOffset164 = staticSwitch165;
				float BaseMask184 = temp_output_187_0;
				#ifdef _COVERSAND_ON
				float staticSwitch220 = pow( BaseMask184 , _CoverEdge_Pow );
				#else
				float staticSwitch220 = 1.0;
				#endif
				float4 lerpResult209 = lerp( float4( CoverOffset185 , 0.0 ) , FlowSandOffset164 , staticSwitch220);
				
				o.ase_texcoord7.xy = v.texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord7.zw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = lerpResult209.xyz;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float3 positionVS = TransformWorldToView( positionWS );
				float4 positionCS = TransformWorldToHClip( positionWS );

				VertexNormalInputs normalInput = GetVertexNormalInputs( v.ase_normal, v.ase_tangent );

				o.tSpace0 = float4( normalInput.normalWS, positionWS.x);
				o.tSpace1 = float4( normalInput.tangentWS, positionWS.y);
				o.tSpace2 = float4( normalInput.bitangentWS, positionWS.z);

				OUTPUT_LIGHTMAP_UV( v.texcoord1, unity_LightmapST, o.lightmapUVOrVertexSH.xy );
				OUTPUT_SH( normalInput.normalWS.xyz, o.lightmapUVOrVertexSH.xyz );

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					o.lightmapUVOrVertexSH.zw = v.texcoord;
					o.lightmapUVOrVertexSH.xy = v.texcoord * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif

				half3 vertexLight = VertexLighting( positionWS, normalInput.normalWS );
				#ifdef ASE_FOG
					half fogFactor = ComputeFogFactor( positionCS.z );
				#else
					half fogFactor = 0;
				#endif
				o.fogFactorAndVertexLight = half4(fogFactor, vertexLight);
				
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
				VertexPositionInputs vertexInput = (VertexPositionInputs)0;
				vertexInput.positionWS = positionWS;
				vertexInput.positionCS = positionCS;
				o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				
				o.clipPos = positionCS;
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				o.screenPos = ComputeScreenPos(positionCS);
				#endif
				return o;
			}
			
			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_tangent = v.ase_tangent;
				o.texcoord = v.texcoord;
				o.texcoord1 = v.texcoord1;
				
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				o.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE)
				#define ASE_SV_DEPTH SV_DepthLessEqual  
			#else
				#define ASE_SV_DEPTH SV_Depth
			#endif

			half4 frag ( VertexOutput IN 
						#ifdef ASE_DEPTH_WRITE_ON
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						 ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(IN);

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float2 sampleCoords = (IN.lightmapUVOrVertexSH.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
					float3 WorldNormal = TransformObjectToWorldNormal(normalize(SAMPLE_TEXTURE2D(_TerrainNormalmapTexture, sampler_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
					float3 WorldTangent = -cross(GetObjectToWorldMatrix()._13_23_33, WorldNormal);
					float3 WorldBiTangent = cross(WorldNormal, -WorldTangent);
				#else
					float3 WorldNormal = normalize( IN.tSpace0.xyz );
					float3 WorldTangent = IN.tSpace1.xyz;
					float3 WorldBiTangent = IN.tSpace2.xyz;
				#endif
				float3 WorldPosition = float3(IN.tSpace0.w,IN.tSpace1.w,IN.tSpace2.w);
				float3 WorldViewDirection = _WorldSpaceCameraPos.xyz  - WorldPosition;
				float4 ShadowCoords = float4( 0, 0, 0, 0 );
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				float4 ScreenPos = IN.screenPos;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					ShadowCoords = IN.shadowCoord;
				#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
					ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
				#endif
	
				WorldViewDirection = SafeNormalize( WorldViewDirection );

				float2 appendResult239 = (float2(_BaseObjTilingAndOffset.x , _BaseObjTilingAndOffset.y));
				float2 appendResult240 = (float2(_BaseObjTilingAndOffset.z , _BaseObjTilingAndOffset.w));
				float2 texCoord238 = IN.ase_texcoord7.xy * appendResult239 + appendResult240;
				float2 BaseObjTilingAndOffset242 = texCoord238;
				float2 appendResult40 = (float2(WorldPosition.x , WorldPosition.z));
				float2 UVSelce43 = ( _UVSelce * appendResult40 );
				float4 tex2DNode38 = tex2D( _BaseColor, UVSelce43 );
				float temp_output_4_0 = ( WorldPosition.y - _HeightColoration_BaseHeight_Pow_Scale.x );
				float4 lerpResult9 = lerp( _HeightColoration_LowColor , _HeightColoration_HightColor , saturate( ( pow( temp_output_4_0 , _HeightColoration_BaseHeight_Pow_Scale.y ) * _HeightColoration_BaseHeight_Pow_Scale.z ) ));
				float4 lerpResult14 = lerp( tex2DNode38 , ( tex2DNode38 * lerpResult9 ) , _HeightColoration_intensity);
				float4 BaseColor15 = lerpResult14;
				float temp_output_187_0 = saturate( WorldNormal.y );
				float BaseMask184 = temp_output_187_0;
				#ifdef _COVERSAND_ON
				float staticSwitch220 = pow( BaseMask184 , _CoverEdge_Pow );
				#else
				float staticSwitch220 = 1.0;
				#endif
				float4 lerpResult204 = lerp( ( _BaseObj_Color * tex2D( _BaseObjBaseColor, BaseObjTilingAndOffset242 ) ) , BaseColor15 , staticSwitch220);
				
				float3 unpack221 = UnpackNormalScale( tex2D( _BaseObjNormalMap, BaseObjTilingAndOffset242 ), _BaseObjNormalMapScale );
				unpack221.z = lerp( 1, unpack221.z, saturate(_BaseObjNormalMapScale) );
				float3 unpack73 = UnpackNormalScale( tex2D( _NormalMap, UVSelce43 ), _NormalMapScale );
				unpack73.z = lerp( 1, unpack73.z, saturate(_NormalMapScale) );
				float2 appendResult67 = (float2(WorldPosition.x , WorldPosition.z));
				float2 appendResult66 = (float2(_uFlowSpeed_vFlowSpeed_UVScele_FlowSandNormalMapScale.x , _uFlowSpeed_vFlowSpeed_UVScele_FlowSandNormalMapScale.y));
				float3 unpack72 = UnpackNormalScale( tex2D( _FlowSand_NormalMap, ( ( appendResult67 * _uFlowSpeed_vFlowSpeed_UVScele_FlowSandNormalMapScale.z ) + ( _TimeParameters.x * appendResult66 ) ) ), _uFlowSpeed_vFlowSpeed_UVScele_FlowSandNormalMapScale.w );
				unpack72.z = lerp( 1, unpack72.z, saturate(_uFlowSpeed_vFlowSpeed_UVScele_FlowSandNormalMapScale.w) );
				float3 N80 = BlendNormal( unpack73 , unpack72 );
				float3 lerpResult208 = lerp( unpack221 , N80 , staticSwitch220);
				
				float fresnelNdotV222 = dot( WorldNormal, WorldViewDirection );
				float fresnelNode222 = ( 0.0 + _FrenelOutLineScale * pow( 1.0 - fresnelNdotV222, _FrenelOutLinePow ) );
				#ifdef _USEFRENELOUTLINE_ON
				float4 staticSwitch230 = ( step( 0.1 , fresnelNode222 ) * _FrenelOutLineColor );
				#else
				float4 staticSwitch230 = float4( 0,0,0,0 );
				#endif
				float3 temp_output_107_0 = ( ( -WorldViewDirection * 0.5 ) + WorldPosition );
				float simplePerlin3D91 = snoise( temp_output_107_0*_KiraKira3var_NoiseScale_Pow_Intensity.x );
				simplePerlin3D91 = simplePerlin3D91*0.5 + 0.5;
				float3 pos3_g12 = ( temp_output_107_0 * _KiraKira3var_NoiseScale_Pow_Intensity.x );
				float2 localMyCustomExpression3_g12 = MyCustomExpression3_g12( pos3_g12 );
				float2 break5_g12 = localMyCustomExpression3_g12;
				#ifdef _NOISE0_VORONOI1_ON
				float staticSwitch97 = ( pow( ( 1.0 - break5_g12.x ) , _KiraKira3var_NoiseScale_Pow_Intensity.y ) * _KiraKira3var_NoiseScale_Pow_Intensity.z );
				#else
				float staticSwitch97 = ( pow( simplePerlin3D91 , _KiraKira3var_NoiseScale_Pow_Intensity.y ) * _KiraKira3var_NoiseScale_Pow_Intensity.z );
				#endif
				float kirakira99 = max( staticSwitch97 , 0.0 );
				float3 break147 = ( fwidth( WorldPosition ) * _KirakiraThreshold_Pow.x );
				float DistanceAttenuation149 = saturate( pow( ( 1.0 - saturate( ( break147.x + break147.y + break147.z ) ) ) , _KirakiraThreshold_Pow.y ) );
				float3 normalizeResult6_g14 = normalize( ( SafeNormalize(_MainLightPosition.xyz) + WorldViewDirection ) );
				float3 normalizedWorldNormal = normalize( WorldNormal );
				float dotResult8_g14 = dot( normalizeResult6_g14 , normalizedWorldNormal );
				float2 _KiraKira_Pow_Scale = float2(10,1);
				float temp_output_116_0 = max( ( pow( saturate( dotResult8_g14 ) , _KiraKira_Pow_Scale.x ) * _KiraKira_Pow_Scale.y ) , 0.0 );
				float KiraKiraMask137 = temp_output_116_0;
				float4 temp_cast_1 = (0.0).xxxx;
				float4 OutKiraKira153 = ( staticSwitch230 + max( ( ( ( _KiraColor * kirakira99 ) * DistanceAttenuation149 ) * KiraKiraMask137 ) , temp_cast_1 ) );
				float4 lerpResult211 = lerp( ( tex2D( _BaseObjEmissionMap, BaseObjTilingAndOffset242 ) * _BaseObjEmissionMapScale ) , OutKiraKira153 , staticSwitch220);
				
				float4 Meralic56 = saturate( ( _MetalicSelce * tex2D( _MetallicMap, UVSelce43 ) ) );
				float4 lerpResult210 = lerp( ( tex2D( _BaseObjMetallicMap, BaseObjTilingAndOffset242 ) * _BaseObjMetallicMapScale ) , Meralic56 , staticSwitch220);
				
				float4 Somoothness55 = saturate( ( _SmoothnessSelce * tex2D( _SmoothnessMap, UVSelce43 ) ) );
				float4 lerpResult207 = lerp( ( tex2D( _BaseObjSomoothnessMap, BaseObjTilingAndOffset242 ) * _BaseObjSomoothnessMapScale ) , Somoothness55 , staticSwitch220);
				
				float3 Albedo = lerpResult204.rgb;
				float3 Normal = lerpResult208;
				float3 Emission = lerpResult211.rgb;
				float3 Specular = 0.5;
				float Metallic = lerpResult210.r;
				float Smoothness = lerpResult207.r;
				float Occlusion = 1;
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;
				float3 BakedGI = 0;
				float3 RefractionColor = 1;
				float RefractionIndex = 1;
				float3 Transmission = 1;
				float3 Translucency = 1;
				#ifdef ASE_DEPTH_WRITE_ON
				float DepthValue = 0;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				InputData inputData;
				inputData.positionWS = WorldPosition;
				inputData.viewDirectionWS = WorldViewDirection;
				inputData.shadowCoord = ShadowCoords;

				#ifdef _NORMALMAP
					#if _NORMAL_DROPOFF_TS
					inputData.normalWS = TransformTangentToWorld(Normal, half3x3( WorldTangent, WorldBiTangent, WorldNormal ));
					#elif _NORMAL_DROPOFF_OS
					inputData.normalWS = TransformObjectToWorldNormal(Normal);
					#elif _NORMAL_DROPOFF_WS
					inputData.normalWS = Normal;
					#endif
					inputData.normalWS = NormalizeNormalPerPixel(inputData.normalWS);
				#else
					inputData.normalWS = WorldNormal;
				#endif

				#ifdef ASE_FOG
					inputData.fogCoord = IN.fogFactorAndVertexLight.x;
				#endif

				inputData.vertexLighting = IN.fogFactorAndVertexLight.yzw;
				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float3 SH = SampleSH(inputData.normalWS.xyz);
				#else
					float3 SH = IN.lightmapUVOrVertexSH.xyz;
				#endif

				inputData.bakedGI = SAMPLE_GI( IN.lightmapUVOrVertexSH.xy, SH, inputData.normalWS );
				#ifdef _ASE_BAKEDGI
					inputData.bakedGI = BakedGI;
				#endif
				
				inputData.normalizedScreenSpaceUV = GetNormalizedScreenSpaceUV(IN.clipPos);
				inputData.shadowMask = SAMPLE_SHADOWMASK(IN.lightmapUVOrVertexSH.xy);

				half4 color = UniversalFragmentPBR(
					inputData, 
					Albedo, 
					Metallic, 
					Specular, 
					Smoothness, 
					Occlusion, 
					Emission, 
					Alpha);

				#ifdef _TRANSMISSION_ASE
				{
					float shadow = _TransmissionShadow;

					Light mainLight = GetMainLight( inputData.shadowCoord );
					float3 mainAtten = mainLight.color * mainLight.distanceAttenuation;
					mainAtten = lerp( mainAtten, mainAtten * mainLight.shadowAttenuation, shadow );
					half3 mainTransmission = max(0 , -dot(inputData.normalWS, mainLight.direction)) * mainAtten * Transmission;
					color.rgb += Albedo * mainTransmission;

					#ifdef _ADDITIONAL_LIGHTS
						int transPixelLightCount = GetAdditionalLightsCount();
						for (int i = 0; i < transPixelLightCount; ++i)
						{
							Light light = GetAdditionalLight(i, inputData.positionWS);
							float3 atten = light.color * light.distanceAttenuation;
							atten = lerp( atten, atten * light.shadowAttenuation, shadow );

							half3 transmission = max(0 , -dot(inputData.normalWS, light.direction)) * atten * Transmission;
							color.rgb += Albedo * transmission;
						}
					#endif
				}
				#endif

				#ifdef _TRANSLUCENCY_ASE
				{
					float shadow = _TransShadow;
					float normal = _TransNormal;
					float scattering = _TransScattering;
					float direct = _TransDirect;
					float ambient = _TransAmbient;
					float strength = _TransStrength;

					Light mainLight = GetMainLight( inputData.shadowCoord );
					float3 mainAtten = mainLight.color * mainLight.distanceAttenuation;
					mainAtten = lerp( mainAtten, mainAtten * mainLight.shadowAttenuation, shadow );

					half3 mainLightDir = mainLight.direction + inputData.normalWS * normal;
					half mainVdotL = pow( saturate( dot( inputData.viewDirectionWS, -mainLightDir ) ), scattering );
					half3 mainTranslucency = mainAtten * ( mainVdotL * direct + inputData.bakedGI * ambient ) * Translucency;
					color.rgb += Albedo * mainTranslucency * strength;

					#ifdef _ADDITIONAL_LIGHTS
						int transPixelLightCount = GetAdditionalLightsCount();
						for (int i = 0; i < transPixelLightCount; ++i)
						{
							Light light = GetAdditionalLight(i, inputData.positionWS);
							float3 atten = light.color * light.distanceAttenuation;
							atten = lerp( atten, atten * light.shadowAttenuation, shadow );

							half3 lightDir = light.direction + inputData.normalWS * normal;
							half VdotL = pow( saturate( dot( inputData.viewDirectionWS, -lightDir ) ), scattering );
							half3 translucency = atten * ( VdotL * direct + inputData.bakedGI * ambient ) * Translucency;
							color.rgb += Albedo * translucency * strength;
						}
					#endif
				}
				#endif

				#ifdef _REFRACTION_ASE
					float4 projScreenPos = ScreenPos / ScreenPos.w;
					float3 refractionOffset = ( RefractionIndex - 1.0 ) * mul( UNITY_MATRIX_V, float4( WorldNormal,0 ) ).xyz * ( 1.0 - dot( WorldNormal, WorldViewDirection ) );
					projScreenPos.xy += refractionOffset.xy;
					float3 refraction = SHADERGRAPH_SAMPLE_SCENE_COLOR( projScreenPos.xy ) * RefractionColor;
					color.rgb = lerp( refraction, color.rgb, color.a );
					color.a = 1;
				#endif

				#ifdef ASE_FINAL_COLOR_ALPHA_MULTIPLY
					color.rgb *= color.a;
				#endif

				#ifdef ASE_FOG
					#ifdef TERRAIN_SPLAT_ADDPASS
						color.rgb = MixFogColor(color.rgb, half3( 0, 0, 0 ), IN.fogFactorAndVertexLight.x );
					#else
						color.rgb = MixFog(color.rgb, IN.fogFactorAndVertexLight.x);
					#endif
				#endif

				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif

				return color;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }

			ZWrite On
			ZTest LEqual
			AlphaToMask Off

			HLSLPROGRAM
			
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 999999

			
			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS_SHADOWCASTER

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			#define ASE_NEEDS_VERT_NORMAL
			#pragma shader_feature_local _USEVERTEXOFFSET_ON
			#pragma shader_feature_local _COVERSAND_ON
			float hash(float x) { return frac(x + 1.3215 * 1.8152); }              float hash3(float3 a) { return frac((hash(a.z * 42.8883) + hash(a.y * 36.9125) + hash(a.x * 65.4321)) * 291.1257); }              float3 rehash3(float x) { return float3(hash(((x + 0.5283) * 59.3829) * 274.3487), hash(((x + 0.8192) * 83.6621) * 345.3871), hash(((x + 0.2157f) * 36.6521f) * 458.3971f)); }              float sqr(float x) {return x*x;}             float fastdist(float3 a, float3 b) { return sqr(b.x - a.x) + sqr(b.y - a.y) + sqr(b.z - a.z); }              float2 Voronoi3D(float3 xyz)             {                 float x = xyz.x;                 float y = xyz.y;                 float z = xyz.z;                 float4 p[27];                 for (int _x = -1; _x < 2; _x++) for (int _y = -1; _y < 2; _y++) for(int _z = -1; _z < 2; _z++) {                     float3 _p = float3(floor(x), floor(y), floor(z)) + float3(_x, _y, _z);                     float h = hash3(_p);                     p[(_x + 1) + ((_y + 1) * 3) + ((_z + 1) * 3 * 3)] = float4((rehash3(h) + _p).xyz, h);                 }                 float m = 9999.9999, w = 0.0;                 for (int i = 0; i < 27; i++) {                     float d = fastdist(float3(x, y, z), p[i].xyz);                     if(d < m) { m = d; w = p[i].w; }                 }                 return float2(m, w);             }


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _KiraKira3var_NoiseScale_Pow_Intensity;
			float4 _BaseObj_Color;
			float4 _BaseObjTilingAndOffset;
			float4 _HeightColoration_LowColor;
			float4 _HeightColoration_HightColor;
			float4 _KiraColor;
			float4 _FrenelOutLineColor;
			float4 _uFlowSpeed_vFlowSpeed_UVScele_FlowSandNormalMapScale;
			float3 _HeightColoration_BaseHeight_Pow_Scale;
			float2 _VertexNoiseUVFlow;
			float2 _KirakiraThreshold_Pow;
			float _CoverScale;
			float _MetalicSelce;
			float _BaseObjMetallicMapScale;
			float _FrenelOutLinePow;
			float _FrenelOutLineScale;
			float _BaseObjNormalMapScale;
			float _NormalMapScale;
			float _BaseObjSomoothnessMapScale;
			float _HeightColoration_intensity;
			float _CoverEdge_Pow;
			float _VertexOffsetMapScale;
			float _VertexOffseUVScale;
			float _UVSelce;
			float _BaseObjEmissionMapScale;
			float _SmoothnessSelce;
			#ifdef _TRANSMISSION_ASE
				float _TransmissionShadow;
			#endif
			#ifdef _TRANSLUCENCY_ASE
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _VertexOffsetMap;


			
			float3 _LightDirection;

			VertexOutput VertexFunction( VertexInput v )
			{
				VertexOutput o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				float3 normalizeResult186 = normalize( v.ase_normal );
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				float temp_output_187_0 = saturate( ase_worldNormal.y );
				float3 CoverOffset185 = ( normalizeResult186 * temp_output_187_0 * _CoverScale );
				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				float2 appendResult40 = (float2(ase_worldPos.x , ase_worldPos.z));
				float2 UVSelce43 = ( _UVSelce * appendResult40 );
				float4 appendResult163 = (float4(0.0 , 0.0 , ( tex2Dlod( _VertexOffsetMap, float4( ( ( _TimeParameters.x * _VertexNoiseUVFlow ) + ( UVSelce43 * _VertexOffseUVScale ) ), 0, 0.0) ).r * _VertexOffsetMapScale ) , 0.0));
				#ifdef _USEVERTEXOFFSET_ON
				float4 staticSwitch165 = appendResult163;
				#else
				float4 staticSwitch165 = float4( 0,0,0,0 );
				#endif
				float4 FlowSandOffset164 = staticSwitch165;
				float BaseMask184 = temp_output_187_0;
				#ifdef _COVERSAND_ON
				float staticSwitch220 = pow( BaseMask184 , _CoverEdge_Pow );
				#else
				float staticSwitch220 = 1.0;
				#endif
				float4 lerpResult209 = lerp( float4( CoverOffset185 , 0.0 ) , FlowSandOffset164 , staticSwitch220);
				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = lerpResult209.xyz;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif
				float3 normalWS = TransformObjectToWorldDir(v.ase_normal);

				float4 clipPos = TransformWorldToHClip( ApplyShadowBias( positionWS, normalWS, _LightDirection ) );

				#if UNITY_REVERSED_Z
					clipPos.z = min(clipPos.z, clipPos.w * UNITY_NEAR_CLIP_VALUE);
				#else
					clipPos.z = max(clipPos.z, clipPos.w * UNITY_NEAR_CLIP_VALUE);
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = clipPos;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				o.clipPos = clipPos;
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE)
				#define ASE_SV_DEPTH SV_DepthLessEqual  
			#else
				#define ASE_SV_DEPTH SV_Depth
			#endif

			half4 frag(	VertexOutput IN 
						#ifdef ASE_DEPTH_WRITE_ON
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						 ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );
				
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;
				#ifdef ASE_DEPTH_WRITE_ON
				float DepthValue = 0;
				#endif

				#ifdef _ALPHATEST_ON
					#ifdef _ALPHATEST_SHADOW_ON
						clip(Alpha - AlphaClipThresholdShadow);
					#else
						clip(Alpha - AlphaClipThreshold);
					#endif
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif
				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif
				return 0;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			ZWrite On
			ColorMask 0
			AlphaToMask Off

			HLSLPROGRAM
			
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 999999

			
			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS_DEPTHONLY

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			#define ASE_NEEDS_VERT_NORMAL
			#pragma shader_feature_local _USEVERTEXOFFSET_ON
			#pragma shader_feature_local _COVERSAND_ON
			float hash(float x) { return frac(x + 1.3215 * 1.8152); }              float hash3(float3 a) { return frac((hash(a.z * 42.8883) + hash(a.y * 36.9125) + hash(a.x * 65.4321)) * 291.1257); }              float3 rehash3(float x) { return float3(hash(((x + 0.5283) * 59.3829) * 274.3487), hash(((x + 0.8192) * 83.6621) * 345.3871), hash(((x + 0.2157f) * 36.6521f) * 458.3971f)); }              float sqr(float x) {return x*x;}             float fastdist(float3 a, float3 b) { return sqr(b.x - a.x) + sqr(b.y - a.y) + sqr(b.z - a.z); }              float2 Voronoi3D(float3 xyz)             {                 float x = xyz.x;                 float y = xyz.y;                 float z = xyz.z;                 float4 p[27];                 for (int _x = -1; _x < 2; _x++) for (int _y = -1; _y < 2; _y++) for(int _z = -1; _z < 2; _z++) {                     float3 _p = float3(floor(x), floor(y), floor(z)) + float3(_x, _y, _z);                     float h = hash3(_p);                     p[(_x + 1) + ((_y + 1) * 3) + ((_z + 1) * 3 * 3)] = float4((rehash3(h) + _p).xyz, h);                 }                 float m = 9999.9999, w = 0.0;                 for (int i = 0; i < 27; i++) {                     float d = fastdist(float3(x, y, z), p[i].xyz);                     if(d < m) { m = d; w = p[i].w; }                 }                 return float2(m, w);             }


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _KiraKira3var_NoiseScale_Pow_Intensity;
			float4 _BaseObj_Color;
			float4 _BaseObjTilingAndOffset;
			float4 _HeightColoration_LowColor;
			float4 _HeightColoration_HightColor;
			float4 _KiraColor;
			float4 _FrenelOutLineColor;
			float4 _uFlowSpeed_vFlowSpeed_UVScele_FlowSandNormalMapScale;
			float3 _HeightColoration_BaseHeight_Pow_Scale;
			float2 _VertexNoiseUVFlow;
			float2 _KirakiraThreshold_Pow;
			float _CoverScale;
			float _MetalicSelce;
			float _BaseObjMetallicMapScale;
			float _FrenelOutLinePow;
			float _FrenelOutLineScale;
			float _BaseObjNormalMapScale;
			float _NormalMapScale;
			float _BaseObjSomoothnessMapScale;
			float _HeightColoration_intensity;
			float _CoverEdge_Pow;
			float _VertexOffsetMapScale;
			float _VertexOffseUVScale;
			float _UVSelce;
			float _BaseObjEmissionMapScale;
			float _SmoothnessSelce;
			#ifdef _TRANSMISSION_ASE
				float _TransmissionShadow;
			#endif
			#ifdef _TRANSLUCENCY_ASE
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _VertexOffsetMap;


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float3 normalizeResult186 = normalize( v.ase_normal );
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				float temp_output_187_0 = saturate( ase_worldNormal.y );
				float3 CoverOffset185 = ( normalizeResult186 * temp_output_187_0 * _CoverScale );
				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				float2 appendResult40 = (float2(ase_worldPos.x , ase_worldPos.z));
				float2 UVSelce43 = ( _UVSelce * appendResult40 );
				float4 appendResult163 = (float4(0.0 , 0.0 , ( tex2Dlod( _VertexOffsetMap, float4( ( ( _TimeParameters.x * _VertexNoiseUVFlow ) + ( UVSelce43 * _VertexOffseUVScale ) ), 0, 0.0) ).r * _VertexOffsetMapScale ) , 0.0));
				#ifdef _USEVERTEXOFFSET_ON
				float4 staticSwitch165 = appendResult163;
				#else
				float4 staticSwitch165 = float4( 0,0,0,0 );
				#endif
				float4 FlowSandOffset164 = staticSwitch165;
				float BaseMask184 = temp_output_187_0;
				#ifdef _COVERSAND_ON
				float staticSwitch220 = pow( BaseMask184 , _CoverEdge_Pow );
				#else
				float staticSwitch220 = 1.0;
				#endif
				float4 lerpResult209 = lerp( float4( CoverOffset185 , 0.0 ) , FlowSandOffset164 , staticSwitch220);
				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = lerpResult209.xyz;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;
				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float4 positionCS = TransformWorldToHClip( positionWS );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = positionCS;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				o.clipPos = positionCS;
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE)
				#define ASE_SV_DEPTH SV_DepthLessEqual  
			#else
				#define ASE_SV_DEPTH SV_Depth
			#endif
			half4 frag(	VertexOutput IN 
						#ifdef ASE_DEPTH_WRITE_ON
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						 ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;
				#ifdef ASE_DEPTH_WRITE_ON
				float DepthValue = 0;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif
				#ifdef ASE_DEPTH_WRITE_ON
				outputDepth = DepthValue;
				#endif

				return 0;
			}
			ENDHLSL
		}
		
		
		Pass
		{
			
			Name "Meta"
			Tags { "LightMode"="Meta" }

			Cull Off

			HLSLPROGRAM
			
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 999999

			
			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS_META

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#pragma shader_feature_local _USEVERTEXOFFSET_ON
			#pragma shader_feature_local _COVERSAND_ON
			#pragma shader_feature_local _USEFRENELOUTLINE_ON
			#pragma shader_feature_local _NOISE0_VORONOI1_ON
			float hash(float x) { return frac(x + 1.3215 * 1.8152); }              float hash3(float3 a) { return frac((hash(a.z * 42.8883) + hash(a.y * 36.9125) + hash(a.x * 65.4321)) * 291.1257); }              float3 rehash3(float x) { return float3(hash(((x + 0.5283) * 59.3829) * 274.3487), hash(((x + 0.8192) * 83.6621) * 345.3871), hash(((x + 0.2157f) * 36.6521f) * 458.3971f)); }              float sqr(float x) {return x*x;}             float fastdist(float3 a, float3 b) { return sqr(b.x - a.x) + sqr(b.y - a.y) + sqr(b.z - a.z); }              float2 Voronoi3D(float3 xyz)             {                 float x = xyz.x;                 float y = xyz.y;                 float z = xyz.z;                 float4 p[27];                 for (int _x = -1; _x < 2; _x++) for (int _y = -1; _y < 2; _y++) for(int _z = -1; _z < 2; _z++) {                     float3 _p = float3(floor(x), floor(y), floor(z)) + float3(_x, _y, _z);                     float h = hash3(_p);                     p[(_x + 1) + ((_y + 1) * 3) + ((_z + 1) * 3 * 3)] = float4((rehash3(h) + _p).xyz, h);                 }                 float m = 9999.9999, w = 0.0;                 for (int i = 0; i < 27; i++) {                     float d = fastdist(float3(x, y, z), p[i].xyz);                     if(d < m) { m = d; w = p[i].w; }                 }                 return float2(m, w);             }


			#pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A

			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _KiraKira3var_NoiseScale_Pow_Intensity;
			float4 _BaseObj_Color;
			float4 _BaseObjTilingAndOffset;
			float4 _HeightColoration_LowColor;
			float4 _HeightColoration_HightColor;
			float4 _KiraColor;
			float4 _FrenelOutLineColor;
			float4 _uFlowSpeed_vFlowSpeed_UVScele_FlowSandNormalMapScale;
			float3 _HeightColoration_BaseHeight_Pow_Scale;
			float2 _VertexNoiseUVFlow;
			float2 _KirakiraThreshold_Pow;
			float _CoverScale;
			float _MetalicSelce;
			float _BaseObjMetallicMapScale;
			float _FrenelOutLinePow;
			float _FrenelOutLineScale;
			float _BaseObjNormalMapScale;
			float _NormalMapScale;
			float _BaseObjSomoothnessMapScale;
			float _HeightColoration_intensity;
			float _CoverEdge_Pow;
			float _VertexOffsetMapScale;
			float _VertexOffseUVScale;
			float _UVSelce;
			float _BaseObjEmissionMapScale;
			float _SmoothnessSelce;
			#ifdef _TRANSMISSION_ASE
				float _TransmissionShadow;
			#endif
			#ifdef _TRANSLUCENCY_ASE
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _VertexOffsetMap;
			sampler2D _BaseObjBaseColor;
			sampler2D _BaseColor;
			sampler2D _BaseObjEmissionMap;


			float3 mod3D289( float3 x ) { return x - floor( x / 289.0 ) * 289.0; }
			float4 mod3D289( float4 x ) { return x - floor( x / 289.0 ) * 289.0; }
			float4 permute( float4 x ) { return mod3D289( ( x * 34.0 + 1.0 ) * x ); }
			float4 taylorInvSqrt( float4 r ) { return 1.79284291400159 - r * 0.85373472095314; }
			float snoise( float3 v )
			{
				const float2 C = float2( 1.0 / 6.0, 1.0 / 3.0 );
				float3 i = floor( v + dot( v, C.yyy ) );
				float3 x0 = v - i + dot( i, C.xxx );
				float3 g = step( x0.yzx, x0.xyz );
				float3 l = 1.0 - g;
				float3 i1 = min( g.xyz, l.zxy );
				float3 i2 = max( g.xyz, l.zxy );
				float3 x1 = x0 - i1 + C.xxx;
				float3 x2 = x0 - i2 + C.yyy;
				float3 x3 = x0 - 0.5;
				i = mod3D289( i);
				float4 p = permute( permute( permute( i.z + float4( 0.0, i1.z, i2.z, 1.0 ) ) + i.y + float4( 0.0, i1.y, i2.y, 1.0 ) ) + i.x + float4( 0.0, i1.x, i2.x, 1.0 ) );
				float4 j = p - 49.0 * floor( p / 49.0 );  // mod(p,7*7)
				float4 x_ = floor( j / 7.0 );
				float4 y_ = floor( j - 7.0 * x_ );  // mod(j,N)
				float4 x = ( x_ * 2.0 + 0.5 ) / 7.0 - 1.0;
				float4 y = ( y_ * 2.0 + 0.5 ) / 7.0 - 1.0;
				float4 h = 1.0 - abs( x ) - abs( y );
				float4 b0 = float4( x.xy, y.xy );
				float4 b1 = float4( x.zw, y.zw );
				float4 s0 = floor( b0 ) * 2.0 + 1.0;
				float4 s1 = floor( b1 ) * 2.0 + 1.0;
				float4 sh = -step( h, 0.0 );
				float4 a0 = b0.xzyw + s0.xzyw * sh.xxyy;
				float4 a1 = b1.xzyw + s1.xzyw * sh.zzww;
				float3 g0 = float3( a0.xy, h.x );
				float3 g1 = float3( a0.zw, h.y );
				float3 g2 = float3( a1.xy, h.z );
				float3 g3 = float3( a1.zw, h.w );
				float4 norm = taylorInvSqrt( float4( dot( g0, g0 ), dot( g1, g1 ), dot( g2, g2 ), dot( g3, g3 ) ) );
				g0 *= norm.x;
				g1 *= norm.y;
				g2 *= norm.z;
				g3 *= norm.w;
				float4 m = max( 0.6 - float4( dot( x0, x0 ), dot( x1, x1 ), dot( x2, x2 ), dot( x3, x3 ) ), 0.0 );
				m = m* m;
				m = m* m;
				float4 px = float4( dot( x0, g0 ), dot( x1, g1 ), dot( x2, g2 ), dot( x3, g3 ) );
				return 42.0 * dot( m, px);
			}
			
			float2 MyCustomExpression3_g12( float3 pos )
			{
				return Voronoi3D(pos);
			}
			

			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float3 normalizeResult186 = normalize( v.ase_normal );
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				float temp_output_187_0 = saturate( ase_worldNormal.y );
				float3 CoverOffset185 = ( normalizeResult186 * temp_output_187_0 * _CoverScale );
				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				float2 appendResult40 = (float2(ase_worldPos.x , ase_worldPos.z));
				float2 UVSelce43 = ( _UVSelce * appendResult40 );
				float4 appendResult163 = (float4(0.0 , 0.0 , ( tex2Dlod( _VertexOffsetMap, float4( ( ( _TimeParameters.x * _VertexNoiseUVFlow ) + ( UVSelce43 * _VertexOffseUVScale ) ), 0, 0.0) ).r * _VertexOffsetMapScale ) , 0.0));
				#ifdef _USEVERTEXOFFSET_ON
				float4 staticSwitch165 = appendResult163;
				#else
				float4 staticSwitch165 = float4( 0,0,0,0 );
				#endif
				float4 FlowSandOffset164 = staticSwitch165;
				float BaseMask184 = temp_output_187_0;
				#ifdef _COVERSAND_ON
				float staticSwitch220 = pow( BaseMask184 , _CoverEdge_Pow );
				#else
				float staticSwitch220 = 1.0;
				#endif
				float4 lerpResult209 = lerp( float4( CoverOffset185 , 0.0 ) , FlowSandOffset164 , staticSwitch220);
				
				o.ase_texcoord3.xyz = ase_worldNormal;
				
				o.ase_texcoord2.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord2.zw = 0;
				o.ase_texcoord3.w = 0;
				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = lerpResult209.xyz;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif

				o.clipPos = MetaVertexPosition( v.vertex, v.texcoord1.xy, v.texcoord1.xy, unity_LightmapST, unity_DynamicLightmapST );
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = o.clipPos;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.texcoord1 = v.texcoord1;
				o.texcoord2 = v.texcoord2;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				o.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 appendResult239 = (float2(_BaseObjTilingAndOffset.x , _BaseObjTilingAndOffset.y));
				float2 appendResult240 = (float2(_BaseObjTilingAndOffset.z , _BaseObjTilingAndOffset.w));
				float2 texCoord238 = IN.ase_texcoord2.xy * appendResult239 + appendResult240;
				float2 BaseObjTilingAndOffset242 = texCoord238;
				float2 appendResult40 = (float2(WorldPosition.x , WorldPosition.z));
				float2 UVSelce43 = ( _UVSelce * appendResult40 );
				float4 tex2DNode38 = tex2D( _BaseColor, UVSelce43 );
				float temp_output_4_0 = ( WorldPosition.y - _HeightColoration_BaseHeight_Pow_Scale.x );
				float4 lerpResult9 = lerp( _HeightColoration_LowColor , _HeightColoration_HightColor , saturate( ( pow( temp_output_4_0 , _HeightColoration_BaseHeight_Pow_Scale.y ) * _HeightColoration_BaseHeight_Pow_Scale.z ) ));
				float4 lerpResult14 = lerp( tex2DNode38 , ( tex2DNode38 * lerpResult9 ) , _HeightColoration_intensity);
				float4 BaseColor15 = lerpResult14;
				float3 ase_worldNormal = IN.ase_texcoord3.xyz;
				float temp_output_187_0 = saturate( ase_worldNormal.y );
				float BaseMask184 = temp_output_187_0;
				#ifdef _COVERSAND_ON
				float staticSwitch220 = pow( BaseMask184 , _CoverEdge_Pow );
				#else
				float staticSwitch220 = 1.0;
				#endif
				float4 lerpResult204 = lerp( ( _BaseObj_Color * tex2D( _BaseObjBaseColor, BaseObjTilingAndOffset242 ) ) , BaseColor15 , staticSwitch220);
				
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - WorldPosition );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float fresnelNdotV222 = dot( ase_worldNormal, ase_worldViewDir );
				float fresnelNode222 = ( 0.0 + _FrenelOutLineScale * pow( 1.0 - fresnelNdotV222, _FrenelOutLinePow ) );
				#ifdef _USEFRENELOUTLINE_ON
				float4 staticSwitch230 = ( step( 0.1 , fresnelNode222 ) * _FrenelOutLineColor );
				#else
				float4 staticSwitch230 = float4( 0,0,0,0 );
				#endif
				ase_worldViewDir = SafeNormalize( ase_worldViewDir );
				float3 temp_output_107_0 = ( ( -ase_worldViewDir * 0.5 ) + WorldPosition );
				float simplePerlin3D91 = snoise( temp_output_107_0*_KiraKira3var_NoiseScale_Pow_Intensity.x );
				simplePerlin3D91 = simplePerlin3D91*0.5 + 0.5;
				float3 pos3_g12 = ( temp_output_107_0 * _KiraKira3var_NoiseScale_Pow_Intensity.x );
				float2 localMyCustomExpression3_g12 = MyCustomExpression3_g12( pos3_g12 );
				float2 break5_g12 = localMyCustomExpression3_g12;
				#ifdef _NOISE0_VORONOI1_ON
				float staticSwitch97 = ( pow( ( 1.0 - break5_g12.x ) , _KiraKira3var_NoiseScale_Pow_Intensity.y ) * _KiraKira3var_NoiseScale_Pow_Intensity.z );
				#else
				float staticSwitch97 = ( pow( simplePerlin3D91 , _KiraKira3var_NoiseScale_Pow_Intensity.y ) * _KiraKira3var_NoiseScale_Pow_Intensity.z );
				#endif
				float kirakira99 = max( staticSwitch97 , 0.0 );
				float3 break147 = ( fwidth( WorldPosition ) * _KirakiraThreshold_Pow.x );
				float DistanceAttenuation149 = saturate( pow( ( 1.0 - saturate( ( break147.x + break147.y + break147.z ) ) ) , _KirakiraThreshold_Pow.y ) );
				float3 normalizeResult6_g14 = normalize( ( SafeNormalize(_MainLightPosition.xyz) + ase_worldViewDir ) );
				float3 normalizedWorldNormal = normalize( ase_worldNormal );
				float dotResult8_g14 = dot( normalizeResult6_g14 , normalizedWorldNormal );
				float2 _KiraKira_Pow_Scale = float2(10,1);
				float temp_output_116_0 = max( ( pow( saturate( dotResult8_g14 ) , _KiraKira_Pow_Scale.x ) * _KiraKira_Pow_Scale.y ) , 0.0 );
				float KiraKiraMask137 = temp_output_116_0;
				float4 temp_cast_1 = (0.0).xxxx;
				float4 OutKiraKira153 = ( staticSwitch230 + max( ( ( ( _KiraColor * kirakira99 ) * DistanceAttenuation149 ) * KiraKiraMask137 ) , temp_cast_1 ) );
				float4 lerpResult211 = lerp( ( tex2D( _BaseObjEmissionMap, BaseObjTilingAndOffset242 ) * _BaseObjEmissionMapScale ) , OutKiraKira153 , staticSwitch220);
				
				
				float3 Albedo = lerpResult204.rgb;
				float3 Emission = lerpResult211.rgb;
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				MetaInput metaInput = (MetaInput)0;
				metaInput.Albedo = Albedo;
				metaInput.Emission = Emission;
				
				return MetaFragment(metaInput);
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "Universal2D"
			Tags { "LightMode"="Universal2D" }

			Blend One Zero, One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA

			HLSLPROGRAM
			
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 999999

			
			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS_2D

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/UnityInstancing.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#pragma shader_feature_local _USEVERTEXOFFSET_ON
			#pragma shader_feature_local _COVERSAND_ON
			float hash(float x) { return frac(x + 1.3215 * 1.8152); }              float hash3(float3 a) { return frac((hash(a.z * 42.8883) + hash(a.y * 36.9125) + hash(a.x * 65.4321)) * 291.1257); }              float3 rehash3(float x) { return float3(hash(((x + 0.5283) * 59.3829) * 274.3487), hash(((x + 0.8192) * 83.6621) * 345.3871), hash(((x + 0.2157f) * 36.6521f) * 458.3971f)); }              float sqr(float x) {return x*x;}             float fastdist(float3 a, float3 b) { return sqr(b.x - a.x) + sqr(b.y - a.y) + sqr(b.z - a.z); }              float2 Voronoi3D(float3 xyz)             {                 float x = xyz.x;                 float y = xyz.y;                 float z = xyz.z;                 float4 p[27];                 for (int _x = -1; _x < 2; _x++) for (int _y = -1; _y < 2; _y++) for(int _z = -1; _z < 2; _z++) {                     float3 _p = float3(floor(x), floor(y), floor(z)) + float3(_x, _y, _z);                     float h = hash3(_p);                     p[(_x + 1) + ((_y + 1) * 3) + ((_z + 1) * 3 * 3)] = float4((rehash3(h) + _p).xyz, h);                 }                 float m = 9999.9999, w = 0.0;                 for (int i = 0; i < 27; i++) {                     float d = fastdist(float3(x, y, z), p[i].xyz);                     if(d < m) { m = d; w = p[i].w; }                 }                 return float2(m, w);             }


			#pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A

			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _KiraKira3var_NoiseScale_Pow_Intensity;
			float4 _BaseObj_Color;
			float4 _BaseObjTilingAndOffset;
			float4 _HeightColoration_LowColor;
			float4 _HeightColoration_HightColor;
			float4 _KiraColor;
			float4 _FrenelOutLineColor;
			float4 _uFlowSpeed_vFlowSpeed_UVScele_FlowSandNormalMapScale;
			float3 _HeightColoration_BaseHeight_Pow_Scale;
			float2 _VertexNoiseUVFlow;
			float2 _KirakiraThreshold_Pow;
			float _CoverScale;
			float _MetalicSelce;
			float _BaseObjMetallicMapScale;
			float _FrenelOutLinePow;
			float _FrenelOutLineScale;
			float _BaseObjNormalMapScale;
			float _NormalMapScale;
			float _BaseObjSomoothnessMapScale;
			float _HeightColoration_intensity;
			float _CoverEdge_Pow;
			float _VertexOffsetMapScale;
			float _VertexOffseUVScale;
			float _UVSelce;
			float _BaseObjEmissionMapScale;
			float _SmoothnessSelce;
			#ifdef _TRANSMISSION_ASE
				float _TransmissionShadow;
			#endif
			#ifdef _TRANSLUCENCY_ASE
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _VertexOffsetMap;
			sampler2D _BaseObjBaseColor;
			sampler2D _BaseColor;


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				float3 normalizeResult186 = normalize( v.ase_normal );
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				float temp_output_187_0 = saturate( ase_worldNormal.y );
				float3 CoverOffset185 = ( normalizeResult186 * temp_output_187_0 * _CoverScale );
				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				float2 appendResult40 = (float2(ase_worldPos.x , ase_worldPos.z));
				float2 UVSelce43 = ( _UVSelce * appendResult40 );
				float4 appendResult163 = (float4(0.0 , 0.0 , ( tex2Dlod( _VertexOffsetMap, float4( ( ( _TimeParameters.x * _VertexNoiseUVFlow ) + ( UVSelce43 * _VertexOffseUVScale ) ), 0, 0.0) ).r * _VertexOffsetMapScale ) , 0.0));
				#ifdef _USEVERTEXOFFSET_ON
				float4 staticSwitch165 = appendResult163;
				#else
				float4 staticSwitch165 = float4( 0,0,0,0 );
				#endif
				float4 FlowSandOffset164 = staticSwitch165;
				float BaseMask184 = temp_output_187_0;
				#ifdef _COVERSAND_ON
				float staticSwitch220 = pow( BaseMask184 , _CoverEdge_Pow );
				#else
				float staticSwitch220 = 1.0;
				#endif
				float4 lerpResult209 = lerp( float4( CoverOffset185 , 0.0 ) , FlowSandOffset164 , staticSwitch220);
				
				o.ase_texcoord3.xyz = ase_worldNormal;
				
				o.ase_texcoord2.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord2.zw = 0;
				o.ase_texcoord3.w = 0;
				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = lerpResult209.xyz;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float4 positionCS = TransformWorldToHClip( positionWS );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = positionCS;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.clipPos = positionCS;
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 appendResult239 = (float2(_BaseObjTilingAndOffset.x , _BaseObjTilingAndOffset.y));
				float2 appendResult240 = (float2(_BaseObjTilingAndOffset.z , _BaseObjTilingAndOffset.w));
				float2 texCoord238 = IN.ase_texcoord2.xy * appendResult239 + appendResult240;
				float2 BaseObjTilingAndOffset242 = texCoord238;
				float2 appendResult40 = (float2(WorldPosition.x , WorldPosition.z));
				float2 UVSelce43 = ( _UVSelce * appendResult40 );
				float4 tex2DNode38 = tex2D( _BaseColor, UVSelce43 );
				float temp_output_4_0 = ( WorldPosition.y - _HeightColoration_BaseHeight_Pow_Scale.x );
				float4 lerpResult9 = lerp( _HeightColoration_LowColor , _HeightColoration_HightColor , saturate( ( pow( temp_output_4_0 , _HeightColoration_BaseHeight_Pow_Scale.y ) * _HeightColoration_BaseHeight_Pow_Scale.z ) ));
				float4 lerpResult14 = lerp( tex2DNode38 , ( tex2DNode38 * lerpResult9 ) , _HeightColoration_intensity);
				float4 BaseColor15 = lerpResult14;
				float3 ase_worldNormal = IN.ase_texcoord3.xyz;
				float temp_output_187_0 = saturate( ase_worldNormal.y );
				float BaseMask184 = temp_output_187_0;
				#ifdef _COVERSAND_ON
				float staticSwitch220 = pow( BaseMask184 , _CoverEdge_Pow );
				#else
				float staticSwitch220 = 1.0;
				#endif
				float4 lerpResult204 = lerp( ( _BaseObj_Color * tex2D( _BaseObjBaseColor, BaseObjTilingAndOffset242 ) ) , BaseColor15 , staticSwitch220);
				
				
				float3 Albedo = lerpResult204.rgb;
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;

				half4 color = half4( Albedo, Alpha );

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				return color;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthNormals"
			Tags { "LightMode"="DepthNormals" }

			ZWrite On
			Blend One Zero
            ZTest LEqual
            ZWrite On

			HLSLPROGRAM
			
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 999999

			
			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS_DEPTHNORMALSONLY

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			#define ASE_NEEDS_VERT_NORMAL
			#pragma shader_feature_local _USEVERTEXOFFSET_ON
			#pragma shader_feature_local _COVERSAND_ON
			float hash(float x) { return frac(x + 1.3215 * 1.8152); }              float hash3(float3 a) { return frac((hash(a.z * 42.8883) + hash(a.y * 36.9125) + hash(a.x * 65.4321)) * 291.1257); }              float3 rehash3(float x) { return float3(hash(((x + 0.5283) * 59.3829) * 274.3487), hash(((x + 0.8192) * 83.6621) * 345.3871), hash(((x + 0.2157f) * 36.6521f) * 458.3971f)); }              float sqr(float x) {return x*x;}             float fastdist(float3 a, float3 b) { return sqr(b.x - a.x) + sqr(b.y - a.y) + sqr(b.z - a.z); }              float2 Voronoi3D(float3 xyz)             {                 float x = xyz.x;                 float y = xyz.y;                 float z = xyz.z;                 float4 p[27];                 for (int _x = -1; _x < 2; _x++) for (int _y = -1; _y < 2; _y++) for(int _z = -1; _z < 2; _z++) {                     float3 _p = float3(floor(x), floor(y), floor(z)) + float3(_x, _y, _z);                     float h = hash3(_p);                     p[(_x + 1) + ((_y + 1) * 3) + ((_z + 1) * 3 * 3)] = float4((rehash3(h) + _p).xyz, h);                 }                 float m = 9999.9999, w = 0.0;                 for (int i = 0; i < 27; i++) {                     float d = fastdist(float3(x, y, z), p[i].xyz);                     if(d < m) { m = d; w = p[i].w; }                 }                 return float2(m, w);             }


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				float3 worldNormal : TEXCOORD2;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _KiraKira3var_NoiseScale_Pow_Intensity;
			float4 _BaseObj_Color;
			float4 _BaseObjTilingAndOffset;
			float4 _HeightColoration_LowColor;
			float4 _HeightColoration_HightColor;
			float4 _KiraColor;
			float4 _FrenelOutLineColor;
			float4 _uFlowSpeed_vFlowSpeed_UVScele_FlowSandNormalMapScale;
			float3 _HeightColoration_BaseHeight_Pow_Scale;
			float2 _VertexNoiseUVFlow;
			float2 _KirakiraThreshold_Pow;
			float _CoverScale;
			float _MetalicSelce;
			float _BaseObjMetallicMapScale;
			float _FrenelOutLinePow;
			float _FrenelOutLineScale;
			float _BaseObjNormalMapScale;
			float _NormalMapScale;
			float _BaseObjSomoothnessMapScale;
			float _HeightColoration_intensity;
			float _CoverEdge_Pow;
			float _VertexOffsetMapScale;
			float _VertexOffseUVScale;
			float _UVSelce;
			float _BaseObjEmissionMapScale;
			float _SmoothnessSelce;
			#ifdef _TRANSMISSION_ASE
				float _TransmissionShadow;
			#endif
			#ifdef _TRANSLUCENCY_ASE
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _VertexOffsetMap;


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float3 normalizeResult186 = normalize( v.ase_normal );
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				float temp_output_187_0 = saturate( ase_worldNormal.y );
				float3 CoverOffset185 = ( normalizeResult186 * temp_output_187_0 * _CoverScale );
				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				float2 appendResult40 = (float2(ase_worldPos.x , ase_worldPos.z));
				float2 UVSelce43 = ( _UVSelce * appendResult40 );
				float4 appendResult163 = (float4(0.0 , 0.0 , ( tex2Dlod( _VertexOffsetMap, float4( ( ( _TimeParameters.x * _VertexNoiseUVFlow ) + ( UVSelce43 * _VertexOffseUVScale ) ), 0, 0.0) ).r * _VertexOffsetMapScale ) , 0.0));
				#ifdef _USEVERTEXOFFSET_ON
				float4 staticSwitch165 = appendResult163;
				#else
				float4 staticSwitch165 = float4( 0,0,0,0 );
				#endif
				float4 FlowSandOffset164 = staticSwitch165;
				float BaseMask184 = temp_output_187_0;
				#ifdef _COVERSAND_ON
				float staticSwitch220 = pow( BaseMask184 , _CoverEdge_Pow );
				#else
				float staticSwitch220 = 1.0;
				#endif
				float4 lerpResult209 = lerp( float4( CoverOffset185 , 0.0 ) , FlowSandOffset164 , staticSwitch220);
				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = lerpResult209.xyz;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;
				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float3 normalWS = TransformObjectToWorldNormal( v.ase_normal );
				float4 positionCS = TransformWorldToHClip( positionWS );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif

				o.worldNormal = normalWS;

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = positionCS;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				o.clipPos = positionCS;
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE)
				#define ASE_SV_DEPTH SV_DepthLessEqual  
			#else
				#define ASE_SV_DEPTH SV_Depth
			#endif
			half4 frag(	VertexOutput IN 
						#ifdef ASE_DEPTH_WRITE_ON
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						 ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;
				#ifdef ASE_DEPTH_WRITE_ON
				float DepthValue = 0;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif
				
				#ifdef ASE_DEPTH_WRITE_ON
				outputDepth = DepthValue;
				#endif
				
				return float4(PackNormalOctRectEncode(TransformWorldToViewDir(IN.worldNormal, true)), 0.0, 0.0);
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "GBuffer"
			Tags { "LightMode"="UniversalGBuffer" }
			
			Blend One Zero, One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA
			

			HLSLPROGRAM
			
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 999999

			
			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS
			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
			#pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
			#pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
			#pragma multi_compile _ _SHADOWS_SOFT
			#pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
			#pragma multi_compile _ _GBUFFER_NORMALS_OCT
			
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ LIGHTMAP_ON

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_GBUFFER

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/UnityInstancing.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"

			#if ASE_SRP_VERSION <= 70108
			#define REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR
			#endif

			#if defined(UNITY_INSTANCING_ENABLED) && defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL)
			    #define ENABLE_TERRAIN_PERPIXEL_NORMAL
			#endif

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
			#pragma shader_feature_local _USEVERTEXOFFSET_ON
			#pragma shader_feature_local _COVERSAND_ON
			#pragma shader_feature_local _USEFRENELOUTLINE_ON
			#pragma shader_feature_local _NOISE0_VORONOI1_ON
			float hash(float x) { return frac(x + 1.3215 * 1.8152); }              float hash3(float3 a) { return frac((hash(a.z * 42.8883) + hash(a.y * 36.9125) + hash(a.x * 65.4321)) * 291.1257); }              float3 rehash3(float x) { return float3(hash(((x + 0.5283) * 59.3829) * 274.3487), hash(((x + 0.8192) * 83.6621) * 345.3871), hash(((x + 0.2157f) * 36.6521f) * 458.3971f)); }              float sqr(float x) {return x*x;}             float fastdist(float3 a, float3 b) { return sqr(b.x - a.x) + sqr(b.y - a.y) + sqr(b.z - a.z); }              float2 Voronoi3D(float3 xyz)             {                 float x = xyz.x;                 float y = xyz.y;                 float z = xyz.z;                 float4 p[27];                 for (int _x = -1; _x < 2; _x++) for (int _y = -1; _y < 2; _y++) for(int _z = -1; _z < 2; _z++) {                     float3 _p = float3(floor(x), floor(y), floor(z)) + float3(_x, _y, _z);                     float h = hash3(_p);                     p[(_x + 1) + ((_y + 1) * 3) + ((_z + 1) * 3 * 3)] = float4((rehash3(h) + _p).xyz, h);                 }                 float m = 9999.9999, w = 0.0;                 for (int i = 0; i < 27; i++) {                     float d = fastdist(float3(x, y, z), p[i].xyz);                     if(d < m) { m = d; w = p[i].w; }                 }                 return float2(m, w);             }


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord : TEXCOORD0;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				float4 lightmapUVOrVertexSH : TEXCOORD0;
				half4 fogFactorAndVertexLight : TEXCOORD1;
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
				float4 shadowCoord : TEXCOORD2;
				#endif
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				float4 screenPos : TEXCOORD6;
				#endif
				float4 ase_texcoord7 : TEXCOORD7;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _KiraKira3var_NoiseScale_Pow_Intensity;
			float4 _BaseObj_Color;
			float4 _BaseObjTilingAndOffset;
			float4 _HeightColoration_LowColor;
			float4 _HeightColoration_HightColor;
			float4 _KiraColor;
			float4 _FrenelOutLineColor;
			float4 _uFlowSpeed_vFlowSpeed_UVScele_FlowSandNormalMapScale;
			float3 _HeightColoration_BaseHeight_Pow_Scale;
			float2 _VertexNoiseUVFlow;
			float2 _KirakiraThreshold_Pow;
			float _CoverScale;
			float _MetalicSelce;
			float _BaseObjMetallicMapScale;
			float _FrenelOutLinePow;
			float _FrenelOutLineScale;
			float _BaseObjNormalMapScale;
			float _NormalMapScale;
			float _BaseObjSomoothnessMapScale;
			float _HeightColoration_intensity;
			float _CoverEdge_Pow;
			float _VertexOffsetMapScale;
			float _VertexOffseUVScale;
			float _UVSelce;
			float _BaseObjEmissionMapScale;
			float _SmoothnessSelce;
			#ifdef _TRANSMISSION_ASE
				float _TransmissionShadow;
			#endif
			#ifdef _TRANSLUCENCY_ASE
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _VertexOffsetMap;
			sampler2D _BaseObjBaseColor;
			sampler2D _BaseColor;
			sampler2D _BaseObjNormalMap;
			sampler2D _NormalMap;
			sampler2D _FlowSand_NormalMap;
			sampler2D _BaseObjEmissionMap;
			sampler2D _BaseObjMetallicMap;
			sampler2D _MetallicMap;
			sampler2D _BaseObjSomoothnessMap;
			sampler2D _SmoothnessMap;


			float3 mod3D289( float3 x ) { return x - floor( x / 289.0 ) * 289.0; }
			float4 mod3D289( float4 x ) { return x - floor( x / 289.0 ) * 289.0; }
			float4 permute( float4 x ) { return mod3D289( ( x * 34.0 + 1.0 ) * x ); }
			float4 taylorInvSqrt( float4 r ) { return 1.79284291400159 - r * 0.85373472095314; }
			float snoise( float3 v )
			{
				const float2 C = float2( 1.0 / 6.0, 1.0 / 3.0 );
				float3 i = floor( v + dot( v, C.yyy ) );
				float3 x0 = v - i + dot( i, C.xxx );
				float3 g = step( x0.yzx, x0.xyz );
				float3 l = 1.0 - g;
				float3 i1 = min( g.xyz, l.zxy );
				float3 i2 = max( g.xyz, l.zxy );
				float3 x1 = x0 - i1 + C.xxx;
				float3 x2 = x0 - i2 + C.yyy;
				float3 x3 = x0 - 0.5;
				i = mod3D289( i);
				float4 p = permute( permute( permute( i.z + float4( 0.0, i1.z, i2.z, 1.0 ) ) + i.y + float4( 0.0, i1.y, i2.y, 1.0 ) ) + i.x + float4( 0.0, i1.x, i2.x, 1.0 ) );
				float4 j = p - 49.0 * floor( p / 49.0 );  // mod(p,7*7)
				float4 x_ = floor( j / 7.0 );
				float4 y_ = floor( j - 7.0 * x_ );  // mod(j,N)
				float4 x = ( x_ * 2.0 + 0.5 ) / 7.0 - 1.0;
				float4 y = ( y_ * 2.0 + 0.5 ) / 7.0 - 1.0;
				float4 h = 1.0 - abs( x ) - abs( y );
				float4 b0 = float4( x.xy, y.xy );
				float4 b1 = float4( x.zw, y.zw );
				float4 s0 = floor( b0 ) * 2.0 + 1.0;
				float4 s1 = floor( b1 ) * 2.0 + 1.0;
				float4 sh = -step( h, 0.0 );
				float4 a0 = b0.xzyw + s0.xzyw * sh.xxyy;
				float4 a1 = b1.xzyw + s1.xzyw * sh.zzww;
				float3 g0 = float3( a0.xy, h.x );
				float3 g1 = float3( a0.zw, h.y );
				float3 g2 = float3( a1.xy, h.z );
				float3 g3 = float3( a1.zw, h.w );
				float4 norm = taylorInvSqrt( float4( dot( g0, g0 ), dot( g1, g1 ), dot( g2, g2 ), dot( g3, g3 ) ) );
				g0 *= norm.x;
				g1 *= norm.y;
				g2 *= norm.z;
				g3 *= norm.w;
				float4 m = max( 0.6 - float4( dot( x0, x0 ), dot( x1, x1 ), dot( x2, x2 ), dot( x3, x3 ) ), 0.0 );
				m = m* m;
				m = m* m;
				float4 px = float4( dot( x0, g0 ), dot( x1, g1 ), dot( x2, g2 ), dot( x3, g3 ) );
				return 42.0 * dot( m, px);
			}
			
			float2 MyCustomExpression3_g12( float3 pos )
			{
				return Voronoi3D(pos);
			}
			

			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float3 normalizeResult186 = normalize( v.ase_normal );
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				float temp_output_187_0 = saturate( ase_worldNormal.y );
				float3 CoverOffset185 = ( normalizeResult186 * temp_output_187_0 * _CoverScale );
				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				float2 appendResult40 = (float2(ase_worldPos.x , ase_worldPos.z));
				float2 UVSelce43 = ( _UVSelce * appendResult40 );
				float4 appendResult163 = (float4(0.0 , 0.0 , ( tex2Dlod( _VertexOffsetMap, float4( ( ( _TimeParameters.x * _VertexNoiseUVFlow ) + ( UVSelce43 * _VertexOffseUVScale ) ), 0, 0.0) ).r * _VertexOffsetMapScale ) , 0.0));
				#ifdef _USEVERTEXOFFSET_ON
				float4 staticSwitch165 = appendResult163;
				#else
				float4 staticSwitch165 = float4( 0,0,0,0 );
				#endif
				float4 FlowSandOffset164 = staticSwitch165;
				float BaseMask184 = temp_output_187_0;
				#ifdef _COVERSAND_ON
				float staticSwitch220 = pow( BaseMask184 , _CoverEdge_Pow );
				#else
				float staticSwitch220 = 1.0;
				#endif
				float4 lerpResult209 = lerp( float4( CoverOffset185 , 0.0 ) , FlowSandOffset164 , staticSwitch220);
				
				o.ase_texcoord7.xy = v.texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord7.zw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = lerpResult209.xyz;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float3 positionVS = TransformWorldToView( positionWS );
				float4 positionCS = TransformWorldToHClip( positionWS );

				VertexNormalInputs normalInput = GetVertexNormalInputs( v.ase_normal, v.ase_tangent );

				o.tSpace0 = float4( normalInput.normalWS, positionWS.x);
				o.tSpace1 = float4( normalInput.tangentWS, positionWS.y);
				o.tSpace2 = float4( normalInput.bitangentWS, positionWS.z);

				OUTPUT_LIGHTMAP_UV( v.texcoord1, unity_LightmapST, o.lightmapUVOrVertexSH.xy );
				OUTPUT_SH( normalInput.normalWS.xyz, o.lightmapUVOrVertexSH.xyz );

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					o.lightmapUVOrVertexSH.zw = v.texcoord;
					o.lightmapUVOrVertexSH.xy = v.texcoord * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif

				half3 vertexLight = VertexLighting( positionWS, normalInput.normalWS );
				#ifdef ASE_FOG
					half fogFactor = ComputeFogFactor( positionCS.z );
				#else
					half fogFactor = 0;
				#endif
				o.fogFactorAndVertexLight = half4(fogFactor, vertexLight);
				
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
				VertexPositionInputs vertexInput = (VertexPositionInputs)0;
				vertexInput.positionWS = positionWS;
				vertexInput.positionCS = positionCS;
				o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				
				o.clipPos = positionCS;
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				o.screenPos = ComputeScreenPos(positionCS);
				#endif
				return o;
			}
			
			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_tangent = v.ase_tangent;
				o.texcoord = v.texcoord;
				o.texcoord1 = v.texcoord1;
				
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				o.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE)
				#define ASE_SV_DEPTH SV_DepthLessEqual  
			#else
				#define ASE_SV_DEPTH SV_Depth
			#endif
			FragmentOutput frag ( VertexOutput IN 
								#ifdef ASE_DEPTH_WRITE_ON
								,out float outputDepth : ASE_SV_DEPTH
								#endif
								 )
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(IN);

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float2 sampleCoords = (IN.lightmapUVOrVertexSH.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
					float3 WorldNormal = TransformObjectToWorldNormal(normalize(SAMPLE_TEXTURE2D(_TerrainNormalmapTexture, sampler_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
					float3 WorldTangent = -cross(GetObjectToWorldMatrix()._13_23_33, WorldNormal);
					float3 WorldBiTangent = cross(WorldNormal, -WorldTangent);
				#else
					float3 WorldNormal = normalize( IN.tSpace0.xyz );
					float3 WorldTangent = IN.tSpace1.xyz;
					float3 WorldBiTangent = IN.tSpace2.xyz;
				#endif
				float3 WorldPosition = float3(IN.tSpace0.w,IN.tSpace1.w,IN.tSpace2.w);
				float3 WorldViewDirection = _WorldSpaceCameraPos.xyz  - WorldPosition;
				float4 ShadowCoords = float4( 0, 0, 0, 0 );
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				float4 ScreenPos = IN.screenPos;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					ShadowCoords = IN.shadowCoord;
				#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
					ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
				#endif
	
				WorldViewDirection = SafeNormalize( WorldViewDirection );

				float2 appendResult239 = (float2(_BaseObjTilingAndOffset.x , _BaseObjTilingAndOffset.y));
				float2 appendResult240 = (float2(_BaseObjTilingAndOffset.z , _BaseObjTilingAndOffset.w));
				float2 texCoord238 = IN.ase_texcoord7.xy * appendResult239 + appendResult240;
				float2 BaseObjTilingAndOffset242 = texCoord238;
				float2 appendResult40 = (float2(WorldPosition.x , WorldPosition.z));
				float2 UVSelce43 = ( _UVSelce * appendResult40 );
				float4 tex2DNode38 = tex2D( _BaseColor, UVSelce43 );
				float temp_output_4_0 = ( WorldPosition.y - _HeightColoration_BaseHeight_Pow_Scale.x );
				float4 lerpResult9 = lerp( _HeightColoration_LowColor , _HeightColoration_HightColor , saturate( ( pow( temp_output_4_0 , _HeightColoration_BaseHeight_Pow_Scale.y ) * _HeightColoration_BaseHeight_Pow_Scale.z ) ));
				float4 lerpResult14 = lerp( tex2DNode38 , ( tex2DNode38 * lerpResult9 ) , _HeightColoration_intensity);
				float4 BaseColor15 = lerpResult14;
				float temp_output_187_0 = saturate( WorldNormal.y );
				float BaseMask184 = temp_output_187_0;
				#ifdef _COVERSAND_ON
				float staticSwitch220 = pow( BaseMask184 , _CoverEdge_Pow );
				#else
				float staticSwitch220 = 1.0;
				#endif
				float4 lerpResult204 = lerp( ( _BaseObj_Color * tex2D( _BaseObjBaseColor, BaseObjTilingAndOffset242 ) ) , BaseColor15 , staticSwitch220);
				
				float3 unpack221 = UnpackNormalScale( tex2D( _BaseObjNormalMap, BaseObjTilingAndOffset242 ), _BaseObjNormalMapScale );
				unpack221.z = lerp( 1, unpack221.z, saturate(_BaseObjNormalMapScale) );
				float3 unpack73 = UnpackNormalScale( tex2D( _NormalMap, UVSelce43 ), _NormalMapScale );
				unpack73.z = lerp( 1, unpack73.z, saturate(_NormalMapScale) );
				float2 appendResult67 = (float2(WorldPosition.x , WorldPosition.z));
				float2 appendResult66 = (float2(_uFlowSpeed_vFlowSpeed_UVScele_FlowSandNormalMapScale.x , _uFlowSpeed_vFlowSpeed_UVScele_FlowSandNormalMapScale.y));
				float3 unpack72 = UnpackNormalScale( tex2D( _FlowSand_NormalMap, ( ( appendResult67 * _uFlowSpeed_vFlowSpeed_UVScele_FlowSandNormalMapScale.z ) + ( _TimeParameters.x * appendResult66 ) ) ), _uFlowSpeed_vFlowSpeed_UVScele_FlowSandNormalMapScale.w );
				unpack72.z = lerp( 1, unpack72.z, saturate(_uFlowSpeed_vFlowSpeed_UVScele_FlowSandNormalMapScale.w) );
				float3 N80 = BlendNormal( unpack73 , unpack72 );
				float3 lerpResult208 = lerp( unpack221 , N80 , staticSwitch220);
				
				float fresnelNdotV222 = dot( WorldNormal, WorldViewDirection );
				float fresnelNode222 = ( 0.0 + _FrenelOutLineScale * pow( 1.0 - fresnelNdotV222, _FrenelOutLinePow ) );
				#ifdef _USEFRENELOUTLINE_ON
				float4 staticSwitch230 = ( step( 0.1 , fresnelNode222 ) * _FrenelOutLineColor );
				#else
				float4 staticSwitch230 = float4( 0,0,0,0 );
				#endif
				float3 temp_output_107_0 = ( ( -WorldViewDirection * 0.5 ) + WorldPosition );
				float simplePerlin3D91 = snoise( temp_output_107_0*_KiraKira3var_NoiseScale_Pow_Intensity.x );
				simplePerlin3D91 = simplePerlin3D91*0.5 + 0.5;
				float3 pos3_g12 = ( temp_output_107_0 * _KiraKira3var_NoiseScale_Pow_Intensity.x );
				float2 localMyCustomExpression3_g12 = MyCustomExpression3_g12( pos3_g12 );
				float2 break5_g12 = localMyCustomExpression3_g12;
				#ifdef _NOISE0_VORONOI1_ON
				float staticSwitch97 = ( pow( ( 1.0 - break5_g12.x ) , _KiraKira3var_NoiseScale_Pow_Intensity.y ) * _KiraKira3var_NoiseScale_Pow_Intensity.z );
				#else
				float staticSwitch97 = ( pow( simplePerlin3D91 , _KiraKira3var_NoiseScale_Pow_Intensity.y ) * _KiraKira3var_NoiseScale_Pow_Intensity.z );
				#endif
				float kirakira99 = max( staticSwitch97 , 0.0 );
				float3 break147 = ( fwidth( WorldPosition ) * _KirakiraThreshold_Pow.x );
				float DistanceAttenuation149 = saturate( pow( ( 1.0 - saturate( ( break147.x + break147.y + break147.z ) ) ) , _KirakiraThreshold_Pow.y ) );
				float3 normalizeResult6_g14 = normalize( ( SafeNormalize(_MainLightPosition.xyz) + WorldViewDirection ) );
				float3 normalizedWorldNormal = normalize( WorldNormal );
				float dotResult8_g14 = dot( normalizeResult6_g14 , normalizedWorldNormal );
				float2 _KiraKira_Pow_Scale = float2(10,1);
				float temp_output_116_0 = max( ( pow( saturate( dotResult8_g14 ) , _KiraKira_Pow_Scale.x ) * _KiraKira_Pow_Scale.y ) , 0.0 );
				float KiraKiraMask137 = temp_output_116_0;
				float4 temp_cast_1 = (0.0).xxxx;
				float4 OutKiraKira153 = ( staticSwitch230 + max( ( ( ( _KiraColor * kirakira99 ) * DistanceAttenuation149 ) * KiraKiraMask137 ) , temp_cast_1 ) );
				float4 lerpResult211 = lerp( ( tex2D( _BaseObjEmissionMap, BaseObjTilingAndOffset242 ) * _BaseObjEmissionMapScale ) , OutKiraKira153 , staticSwitch220);
				
				float4 Meralic56 = saturate( ( _MetalicSelce * tex2D( _MetallicMap, UVSelce43 ) ) );
				float4 lerpResult210 = lerp( ( tex2D( _BaseObjMetallicMap, BaseObjTilingAndOffset242 ) * _BaseObjMetallicMapScale ) , Meralic56 , staticSwitch220);
				
				float4 Somoothness55 = saturate( ( _SmoothnessSelce * tex2D( _SmoothnessMap, UVSelce43 ) ) );
				float4 lerpResult207 = lerp( ( tex2D( _BaseObjSomoothnessMap, BaseObjTilingAndOffset242 ) * _BaseObjSomoothnessMapScale ) , Somoothness55 , staticSwitch220);
				
				float3 Albedo = lerpResult204.rgb;
				float3 Normal = lerpResult208;
				float3 Emission = lerpResult211.rgb;
				float3 Specular = 0.5;
				float Metallic = lerpResult210.r;
				float Smoothness = lerpResult207.r;
				float Occlusion = 1;
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;
				float3 BakedGI = 0;
				float3 RefractionColor = 1;
				float RefractionIndex = 1;
				float3 Transmission = 1;
				float3 Translucency = 1;
				#ifdef ASE_DEPTH_WRITE_ON
				float DepthValue = 0;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				InputData inputData;
				inputData.positionWS = WorldPosition;
				inputData.viewDirectionWS = WorldViewDirection;
				inputData.shadowCoord = ShadowCoords;

				#ifdef _NORMALMAP
					#if _NORMAL_DROPOFF_TS
					inputData.normalWS = TransformTangentToWorld(Normal, half3x3( WorldTangent, WorldBiTangent, WorldNormal ));
					#elif _NORMAL_DROPOFF_OS
					inputData.normalWS = TransformObjectToWorldNormal(Normal);
					#elif _NORMAL_DROPOFF_WS
					inputData.normalWS = Normal;
					#endif
					inputData.normalWS = NormalizeNormalPerPixel(inputData.normalWS);
				#else
					inputData.normalWS = WorldNormal;
				#endif

				#ifdef ASE_FOG
					inputData.fogCoord = IN.fogFactorAndVertexLight.x;
				#endif

				inputData.vertexLighting = IN.fogFactorAndVertexLight.yzw;
				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float3 SH = SampleSH(inputData.normalWS.xyz);
				#else
					float3 SH = IN.lightmapUVOrVertexSH.xyz;
				#endif

				inputData.bakedGI = SAMPLE_GI( IN.lightmapUVOrVertexSH.xy, SH, inputData.normalWS );
				#ifdef _ASE_BAKEDGI
					inputData.bakedGI = BakedGI;
				#endif

				BRDFData brdfData;
				InitializeBRDFData( Albedo, Metallic, Specular, Smoothness, Alpha, brdfData);
				half4 color;
				color.rgb = GlobalIllumination( brdfData, inputData.bakedGI, Occlusion, inputData.normalWS, inputData.viewDirectionWS);
				color.a = Alpha;

				#ifdef _TRANSMISSION_ASE
				{
					float shadow = _TransmissionShadow;
				
					Light mainLight = GetMainLight( inputData.shadowCoord );
					float3 mainAtten = mainLight.color * mainLight.distanceAttenuation;
					mainAtten = lerp( mainAtten, mainAtten * mainLight.shadowAttenuation, shadow );
					half3 mainTransmission = max(0 , -dot(inputData.normalWS, mainLight.direction)) * mainAtten * Transmission;
					color.rgb += Albedo * mainTransmission;
				
					#ifdef _ADDITIONAL_LIGHTS
						int transPixelLightCount = GetAdditionalLightsCount();
						for (int i = 0; i < transPixelLightCount; ++i)
						{
							Light light = GetAdditionalLight(i, inputData.positionWS);
							float3 atten = light.color * light.distanceAttenuation;
							atten = lerp( atten, atten * light.shadowAttenuation, shadow );
				
							half3 transmission = max(0 , -dot(inputData.normalWS, light.direction)) * atten * Transmission;
							color.rgb += Albedo * transmission;
						}
					#endif
				}
				#endif
				
				#ifdef _TRANSLUCENCY_ASE
				{
					float shadow = _TransShadow;
					float normal = _TransNormal;
					float scattering = _TransScattering;
					float direct = _TransDirect;
					float ambient = _TransAmbient;
					float strength = _TransStrength;
				
					Light mainLight = GetMainLight( inputData.shadowCoord );
					float3 mainAtten = mainLight.color * mainLight.distanceAttenuation;
					mainAtten = lerp( mainAtten, mainAtten * mainLight.shadowAttenuation, shadow );
				
					half3 mainLightDir = mainLight.direction + inputData.normalWS * normal;
					half mainVdotL = pow( saturate( dot( inputData.viewDirectionWS, -mainLightDir ) ), scattering );
					half3 mainTranslucency = mainAtten * ( mainVdotL * direct + inputData.bakedGI * ambient ) * Translucency;
					color.rgb += Albedo * mainTranslucency * strength;
				
					#ifdef _ADDITIONAL_LIGHTS
						int transPixelLightCount = GetAdditionalLightsCount();
						for (int i = 0; i < transPixelLightCount; ++i)
						{
							Light light = GetAdditionalLight(i, inputData.positionWS);
							float3 atten = light.color * light.distanceAttenuation;
							atten = lerp( atten, atten * light.shadowAttenuation, shadow );
				
							half3 lightDir = light.direction + inputData.normalWS * normal;
							half VdotL = pow( saturate( dot( inputData.viewDirectionWS, -lightDir ) ), scattering );
							half3 translucency = atten * ( VdotL * direct + inputData.bakedGI * ambient ) * Translucency;
							color.rgb += Albedo * translucency * strength;
						}
					#endif
				}
				#endif
				
				#ifdef _REFRACTION_ASE
					float4 projScreenPos = ScreenPos / ScreenPos.w;
					float3 refractionOffset = ( RefractionIndex - 1.0 ) * mul( UNITY_MATRIX_V, float4( WorldNormal, 0 ) ).xyz * ( 1.0 - dot( WorldNormal, WorldViewDirection ) );
					projScreenPos.xy += refractionOffset.xy;
					float3 refraction = SHADERGRAPH_SAMPLE_SCENE_COLOR( projScreenPos.xy ) * RefractionColor;
					color.rgb = lerp( refraction, color.rgb, color.a );
					color.a = 1;
				#endif
				
				#ifdef ASE_FINAL_COLOR_ALPHA_MULTIPLY
					color.rgb *= color.a;
				#endif
				
				#ifdef ASE_FOG
					#ifdef TERRAIN_SPLAT_ADDPASS
						color.rgb = MixFogColor(color.rgb, half3( 0, 0, 0 ), IN.fogFactorAndVertexLight.x );
					#else
						color.rgb = MixFog(color.rgb, IN.fogFactorAndVertexLight.x);
					#endif
				#endif
				
				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif
				
				return BRDFDataToGbuffer(brdfData, inputData, Smoothness, Emission + color.rgb);
			}

			ENDHLSL
		}
		
	}
	/*ase_lod*/
	CustomEditor "UnityEditor.ShaderGraph.PBRMasterGUI"
	Fallback "Hidden/InternalErrorShader"
	
}
/*ASEBEGIN
Version=18912
2275;916;2272;1349;2942.39;2183.523;1.435845;True;False
Node;AmplifyShaderEditor.CommentaryNode;82;-2085.219,1117.517;Inherit;False;1996.224;643.3057;KiraKiraGenerator 地上的闪光;27;99;97;107;106;105;104;103;102;101;100;98;96;95;94;93;92;91;90;89;88;87;86;85;84;83;136;135;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;85;-2035.219,1190.843;Inherit;False;World;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;83;-1825.868,1327.287;Inherit;False;Constant;_Float1;Float 1;9;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;84;-1811.986,1237.497;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector4Node;102;-1754.098,1420.608;Inherit;False;Property;_KiraKira3var_NoiseScale_Pow_Intensity;KiraKira3var_NoiseScale_Pow_Intensity;16;0;Create;True;0;0;0;False;0;False;10,910.13,290.2,0;14,5000,51.75,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;86;-1675.345,1254.866;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;106;-2040.868,1417.287;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;138;-2076.714,2137.039;Inherit;False;1451.215;462.5194;KirakiraThreshold;11;149;148;147;146;145;144;143;142;141;140;139;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;107;-1522.868,1255.287;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;140;-2040.863,2206.454;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WireNode;104;-1463.052,1555.961;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;103;-1364.942,1639.118;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FWidthOpNode;144;-1792.143,2235.497;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector2Node;143;-1933.858,2447.228;Inherit;False;Property;_KirakiraThreshold_Pow;KirakiraThreshold_Pow;17;0;Create;True;0;0;0;False;0;False;15,10;5,60;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;145;-1658.661,2409.507;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;93;-1459.052,1433.961;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;88;-1164.844,1531.514;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;105;-1225.809,1638.42;Inherit;False;Voronoi3D;-1;;12;bd76284cd66b6a3469d5043bfd7c1b9b;0;1;2;FLOAT3;0,0,0;False;2;FLOAT;0;FLOAT;4
Node;AmplifyShaderEditor.WireNode;90;-1091.052,1457.961;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;98;-1052.544,1635.801;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;92;-1165.844,1554.514;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;44;-2061.624,-1485.028;Inherit;False;508.6357;541.068;UvSelce;5;39;40;41;42;43;;1,1,1,1;0;0
Node;AmplifyShaderEditor.BreakToComponentsNode;147;-1501.099,2265.064;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.WireNode;94;-944.9419,1582.118;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;91;-1276.879,1167.517;Inherit;True;Simplex3D;True;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;100;-883.9435,1545.168;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;101;-944.9419,1618.118;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;142;-1395.168,2265.386;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;39;-2011.624,-1126.96;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PowerNode;89;-990.537,1235.46;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;96;-1096.052,1490.961;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;40;-1828.76,-1101.66;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;146;-1279.863,2261.423;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;87;-746.8468,1612.54;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-2009.296,-1241.125;Inherit;False;Property;_UVSelce;UVSelce;0;0;Create;True;0;0;0;False;0;False;1;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;95;-770.5369,1223.46;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;97;-578.6687,1219.975;Inherit;False;Property;_Noise0_Voronoi1;Noise0_Voronoi1;15;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;-1722.296,-1238.125;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;135;-503.8639,1521.682;Inherit;False;Constant;_Float0;Float 0;16;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;148;-1149.672,2263.016;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;108;-2077.3,1805.732;Inherit;False;924.3831;293.9656;KiraKiraMask;4;110;116;112;137;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;162;-2078.597,3167.077;Inherit;False;1948.643;695.7994;顶点偏移流动沙;13;174;169;178;172;166;180;175;176;168;171;164;165;163;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;43;-1785.988,-1435.028;Inherit;False;UVSelce;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;1;-2063.259,-910.3117;Inherit;False;1693.544;1100.217;固有色/基础色/根据高度上色;16;16;15;14;13;12;10;9;8;7;6;5;4;3;2;38;45;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PowerNode;141;-1004.159,2260.464;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;136;-350.5012,1342.241;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;180;-1965.977,3602.212;Inherit;False;43;UVSelce;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;112;-1953.862,1868.61;Inherit;False;Constant;_KiraKira_Pow_Scale;KiraKira_Pow_Scale;11;0;Create;True;0;0;0;False;0;False;10,1;10,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector3Node;3;-2047.613,-116.7781;Inherit;False;Property;_HeightColoration_BaseHeight_Pow_Scale;HeightColoration_BaseHeight_Pow_Scale;5;0;Create;True;0;0;0;False;0;False;0,1,1;0,0.8,0.23;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldPosInputsNode;2;-1933.014,-318.8848;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector2Node;168;-2024.183,3329.281;Inherit;False;Property;_VertexNoiseUVFlow;VertexNoiseUVFlow;20;0;Create;True;0;0;0;False;0;False;0.1,0.1;0.1,0.1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SaturateNode;139;-851.0574,2268.143;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;150;-2073.839,2641.33;Inherit;False;2340.405;514.1333;Kirakira;19;222;153;225;155;230;159;154;229;156;151;228;223;152;157;224;160;158;251;252;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;63;-2072.411,256.5835;Inherit;False;1688.746;822.6382;法线/流动法线;14;79;72;73;74;71;81;70;69;66;67;68;65;64;80;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;171;-2000.629,3714.609;Inherit;False;Property;_VertexOffseUVScale;VertexOffseUVScale;23;0;Create;True;0;0;0;False;0;False;1;0.01;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;166;-2002.783,3248.32;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;99;-286.377,1224.821;Inherit;False;kirakira;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;224;-1238.325,2701.422;Inherit;False;Property;_FrenelOutLineScale;FrenelOutLineScale;38;0;Create;True;0;0;0;False;0;False;1.19;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;149;-713.8252,2252.613;Inherit;False;DistanceAttenuation;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;4;-1738.557,-216.3596;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;65;-2054.243,862.5634;Inherit;False;Property;_uFlowSpeed_vFlowSpeed_UVScele_FlowSandNormalMapScale;uFlowSpeed_vFlowSpeed_UVScele_FlowSandNormalMapScale;14;0;Create;True;0;0;0;False;0;False;0.1,0.1,10,1;0.94,0.28,0.1,0.1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;116;-1695.178,1860.225;Inherit;False;BlinPhongSpcular;-1;;14;b68a7be45a1b57946bbc715cf04de998;0;2;1;FLOAT;100;False;12;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;64;-1933.786,541.9184;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;160;-1985.839,2881.075;Inherit;False;99;kirakira;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;241;-2105.119,6328.484;Inherit;False;699.468;301;Comment;4;238;239;237;240;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;158;-2012.323,2711.33;Inherit;False;Property;_KiraColor;KiraColor;18;1;[HDR];Create;True;0;0;0;False;0;False;4,3.905882,2.933333,0;4,3.905882,2.933333,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;175;-1803.183,3234.281;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;223;-1235.325,2778.422;Inherit;False;Property;_FrenelOutLinePow;FrenelOutLinePow;39;0;Create;True;0;0;0;False;0;False;18.46;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;176;-1763.729,3642.91;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;67;-1744.586,597.2184;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;66;-1707.701,889.6284;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;252;-601.7256,2852.738;Inherit;False;Constant;_Float3;Float 3;41;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;237;-2055.119,6398.537;Inherit;False;Property;_BaseObjTilingAndOffset;BaseObjTilingAndOffset;36;0;Create;True;0;0;0;False;0;False;10,10,0,0;10,10,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;5;-1531.255,-181.6072;Inherit;False;PowerScale;-1;;16;5ba70760a40e0a6499195a0590fd2e74;0;3;1;FLOAT;1;False;2;FLOAT;1;False;3;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;181;-2069.632,3918.92;Inherit;False;684.1921;562.9539;积沙突起;8;185;182;183;184;186;188;187;189;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;152;-1794.313,2701.536;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;157;-2003.839,2978.075;Inherit;False;149;DistanceAttenuation;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;172;-1547.583,3272.58;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;137;-1457.169,1943.341;Inherit;False;KiraKiraMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;68;-1943.604,782.7224;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;46;-1447.283,-1663.755;Inherit;False;1075.608;727.0458;金属度和粗糙度;11;56;55;54;53;52;51;50;49;48;47;62;;1,1,1,1;0;0
Node;AmplifyShaderEditor.FresnelNode;222;-1012.489,2693.162;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;45;-2040.466,-799.6775;Inherit;False;43;UVSelce;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldNormalVector;189;-2019.632,4130.507;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ColorNode;8;-1733.495,-444.2719;Inherit;False;Property;_HeightColoration_HightColor;HeightColoration_HightColor;3;0;Create;True;0;0;0;False;0;False;0.8000001,0.5568628,0.2745098,1;1,0.8130435,0.5707546,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;239;-1788.651,6392.484;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;178;-1377.093,3228.227;Inherit;True;Property;_VertexOffsetMap;VertexOffsetMap;21;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;56fc026eb79effe4b85400592e33d639;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;169;-1353.424,3434.6;Inherit;False;Property;_VertexOffsetMapScale;VertexOffsetMapScale;22;0;Create;True;0;0;0;False;0;False;0.0005;0.001;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;6;-1328.384,-183.4816;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;228;-1236.206,2859.472;Inherit;False;Property;_FrenelOutLineColor;FrenelOutLineColor;40;1;[HDR];Create;True;0;0;0;False;0;False;0.8773585,0.2973178,0.2690015,0;0.8773585,0.2973178,0.2690015,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;-1585.629,609.1614;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;151;-1694.423,2857.426;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;62;-1365.832,-1441.578;Inherit;False;43;UVSelce;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StepOpNode;251;-472.7256,2787.738;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;156;-1993.804,3062.112;Inherit;False;137;KiraKiraMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;240;-1796.651,6494.484;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;7;-1730.395,-614.6719;Inherit;False;Property;_HeightColoration_LowColor;HeightColoration_LowColor;2;0;Create;True;0;0;0;False;0;False;0.7019608,0.3764706,0,1;0.8962264,0.7087243,0.5876201,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;-1576.436,781.5984;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;187;-1790.718,4174.623;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;74;-1540.675,401.5334;Inherit;False;Property;_NormalMapScale;NormalMapScale;13;0;Create;True;0;0;0;False;0;False;1;0.18;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-1131.291,-1609.501;Inherit;False;Property;_MetalicSelce;MetalicSelce;8;0;Create;True;0;0;0;False;0;False;0.6117647;2.18;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;174;-1032.302,3267.228;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;188;-2016.491,3968.92;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;9;-1159.57,-399.1193;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;159;-1456.052,2855.488;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-2047.509,49.33026;Inherit;False;Property;_HeightColoration_intensity;HeightColoration_intensity;4;0;Create;True;0;0;0;False;0;False;0.3412706;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;81;-1536.799,326.6177;Inherit;False;43;UVSelce;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;71;-1432.381,694.2394;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;238;-1653.651,6378.484;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;154;-1611.218,3052.629;Inherit;False;Constant;_0;0;16;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;49;-1128.751,-1176.755;Inherit;True;Property;_SmoothnessMap;SmoothnessMap;9;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;47;-1131.857,-1491.451;Inherit;True;Property;_MetallicMap;MetallicMap;6;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;229;-247.3366,2836.872;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;38;-1740.567,-821.8088;Inherit;True;Property;_BaseColor;BaseColor;1;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;50;-1115.651,-1272.875;Inherit;False;Property;_SmoothnessSelce;SmoothnessSelce;10;0;Create;True;0;0;0;False;0;False;0.6117647;1.12;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;183;-2014.525,4276.539;Inherit;False;Property;_CoverScale;CoverScale;26;0;Create;True;0;0;0;False;0;False;0;0.5;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;242;-1382.27,6417.299;Inherit;False;BaseObjTilingAndOffset;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;184;-1620.439,4374.873;Inherit;False;BaseMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;72;-1307.956,679.3845;Inherit;True;Property;_FlowSand_NormalMap;FlowSand_NormalMap;12;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;8c0c1e342b3e10440a41ce156991a0fa;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;163;-793.6937,3232.757;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;73;-1309.168,319.8254;Inherit;True;Property;_NormalMap;NormalMap;11;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;b2471b4fc11bd254886447d2dac15a59;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMaxOpNode;155;-1384.749,3032.106;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;190;-2084.743,4531.946;Inherit;False;1611.474;1754.672;浮沙;37;209;198;197;192;195;196;219;213;206;218;212;236;217;214;200;203;193;215;194;207;210;220;202;216;221;191;204;211;205;201;208;244;246;234;247;243;245;;1,1,1,1;0;0
Node;AmplifyShaderEditor.NormalizeNode;186;-1805,3975.92;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;230;-109.7454,2838.422;Inherit;False;Property;_UseFrenelOutLine;UseFrenelOutLine;37;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;-829.0652,-1515.022;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-817.5527,-1268.842;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-1032.532,-682.7728;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;12;-1082.401,-191.9706;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;247;-2023.574,4651.514;Inherit;False;242;BaseObjTilingAndOffset;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;54;-677.8879,-1267.96;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;243;-1965.566,5819.662;Inherit;False;242;BaseObjTilingAndOffset;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;165;-619.9365,3216.577;Inherit;False;Property;_UseVertexoffset;UseVertexoffset;19;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;196;-1580.299,6125.203;Inherit;False;184;BaseMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;182;-1606.718,4177.623;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;195;-1592.299,6207.203;Inherit;False;Property;_CoverEdge_Pow;CoverEdge_Pow;25;0;Create;True;0;0;0;False;0;False;0.3;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;225;-96.7258,3009.615;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendNormalsNode;79;-837.1389,327.0504;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;14;-821.2577,-781.3442;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;245;-2000.174,5252.114;Inherit;False;242;BaseObjTilingAndOffset;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;244;-1984.566,5514.662;Inherit;False;242;BaseObjTilingAndOffset;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;53;-689.7833,-1511.854;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;164;-369.6447,3218.735;Inherit;False;FlowSandOffset;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;215;-1689.139,5249.068;Inherit;True;Property;_BaseObjEmissionMap;BaseObjEmissionMap;35;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;1;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;217;-1712.714,5491.504;Inherit;True;Property;_BaseObjMetallicMap;BaseObjMetallicMap;31;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;1;True;bump;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;212;-1414.531,5186.306;Inherit;False;Property;_BaseObjEmissionMapScale;BaseObjEmissionMapScale;7;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;218;-1399.495,6056.924;Inherit;False;Constant;_Float6;Float 6;23;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;213;-1699.113,5796.588;Inherit;True;Property;_BaseObjSomoothnessMap;BaseObjSomoothnessMap;33;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;219;-1671.885,5063.349;Inherit;False;Property;_BaseObjNormalMapScale;BaseObjNormalMapScale;30;0;Create;True;0;0;0;False;0;False;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;55;-537.4989,-1271.934;Inherit;False;Somoothness;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;185;-1602.758,4018.814;Inherit;False;CoverOffset;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;193;-1429.165,5767.893;Inherit;False;Property;_BaseObjSomoothnessMapScale;BaseObjSomoothnessMapScale;34;0;Create;True;0;0;0;False;0;False;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;246;-2018.374,4921.914;Inherit;False;242;BaseObjTilingAndOffset;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;15;-606.1708,-788.5585;Inherit;False;BaseColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;197;-1399.299,6142.203;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;80;-636.7238,320.3705;Inherit;False;N;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;56;-544.0917,-1517.48;Inherit;False;Meralic;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;234;-1275.207,4537.263;Inherit;False;Property;_BaseObj_Color;BaseObj_Color;27;0;Create;True;0;0;0;False;0;False;1,0.8156863,0.6039216,1;0.5788245,0.6415094,0.2995728,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;198;-1435.466,5460.394;Inherit;False;Property;_BaseObjMetallicMapScale;BaseObjMetallicMapScale;32;0;Create;True;0;0;0;False;0;False;0.2;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;153;62.30205,3012.91;Inherit;False;OutKiraKira;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;214;-1708.266,4596.309;Inherit;True;Property;_BaseObjBaseColor;BaseObjBaseColor;28;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;07a31385368d61244903510ac01690eb;6c37fbaff7ae54c4db6631ca9e643dd6;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;1;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;192;-1338.974,5014.739;Inherit;False;80;N;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;206;-1377.076,5314.723;Inherit;False;153;OutKiraKira;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;200;-1405.818,5602.121;Inherit;False;56;Meralic;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;236;-1004.99,4676.983;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;194;-1408.4,5890.366;Inherit;False;55;Somoothness;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;203;-1183.318,5501.013;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;202;-1161.421,5229.828;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;216;-1136.135,5766.13;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;221;-1688.103,4875.768;Inherit;True;Property;_BaseObjNormalMap;BaseObjNormalMap;29;2;[NoScaleOffset];[Normal];Create;True;0;0;0;False;0;False;-1;None;None;True;1;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;191;-859.8647,5713.457;Inherit;False;185;CoverOffset;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;205;-877.2108,5802.584;Inherit;False;164;FlowSandOffset;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;201;-1656.521,4783.708;Inherit;False;15;BaseColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;220;-1215.271,6057.282;Inherit;False;Property;_CoverSand;CoverSand;24;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;210;-673.8031,5325.637;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;208;-674.6931,5076.188;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;204;-670.5349,4945.598;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;207;-670.823,5448.563;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;110;-1460.923,1848.096;Inherit;False;BlinPhong;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;209;-660.7599,5780.879;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;211;-676.4701,5201.534;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;16;-1395.597,-300.0115;Inherit;False;Height;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;259;-373.9335,5203.927;Float;False;True;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;2;AliceSohiSabaku;94348b07e5e8bab40bd6c8a1e3df54cd;True;Forward;0;1;Forward;18;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;False;True;1;1;False;-1;0;False;-1;1;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;LightMode=UniversalForward;False;False;0;Hidden/InternalErrorShader;0;0;Standard;38;Workflow;1;Surface;0;  Refraction Model;0;  Blend;0;Two Sided;1;Fragment Normal Space,InvertActionOnDeselection;0;Transmission;0;  Transmission Shadow;0.5,False,-1;Translucency;0;  Translucency Strength;1,False,-1;  Normal Distortion;0.5,False,-1;  Scattering;2,False,-1;  Direct;0.9,False,-1;  Ambient;0.1,False,-1;  Shadow;0.5,False,-1;Cast Shadows;1;  Use Shadow Threshold;0;Receive Shadows;1;GPU Instancing;1;LOD CrossFade;1;Built-in Fog;1;_FinalColorxAlpha;0;Meta Pass;1;Override Baked GI;0;Extra Pre Pass;0;DOTS Instancing;0;Tessellation;0;  Phong;0;  Strength;0.5,False,-1;  Type;0;  Tess;16,False,-1;  Min;10,False,-1;  Max;25,False,-1;  Edge Length;16,False,-1;  Max Displacement;25,False,-1;Write Depth;0;  Early Z;0;Vertex Position,InvertActionOnDeselection;1;0;8;False;True;True;True;True;True;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;264;-27.51991,5228.139;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;DepthNormals;0;6;DepthNormals;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;False;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;-1;True;3;False;-1;False;True;1;LightMode=DepthNormals;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;258;-27.51991,5228.139;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ExtraPrePass;0;0;ExtraPrePass;5;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;False;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;0;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;260;-27.51991,5228.139;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;-1;True;3;False;-1;False;True;1;LightMode=ShadowCaster;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;261;-27.51991,5228.139;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;DepthOnly;0;3;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;False;False;True;False;False;False;False;0;False;-1;False;False;False;False;False;False;False;False;False;True;1;False;-1;False;False;True;1;LightMode=DepthOnly;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;262;-27.51991,5228.139;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Meta;0;4;Meta;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;263;-27.51991,5228.139;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Universal2D;0;5;Universal2D;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;False;True;1;1;False;-1;0;False;-1;1;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;False;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;LightMode=Universal2D;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;265;-27.51991,5228.139;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;GBuffer;0;7;GBuffer;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;False;True;1;1;False;-1;0;False;-1;1;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;LightMode=UniversalGBuffer;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.CommentaryNode;161;-2205.11,1131.342;Inherit;False;113.219;2020.968;Kirakira;0;;1,1,1,1;0;0
WireConnection;84;0;85;0
WireConnection;86;0;84;0
WireConnection;86;1;83;0
WireConnection;107;0;86;0
WireConnection;107;1;106;0
WireConnection;104;0;102;1
WireConnection;103;0;107;0
WireConnection;103;1;104;0
WireConnection;144;0;140;0
WireConnection;145;0;144;0
WireConnection;145;1;143;1
WireConnection;93;0;102;1
WireConnection;88;0;102;2
WireConnection;105;2;103;0
WireConnection;90;0;102;2
WireConnection;98;0;105;0
WireConnection;92;0;102;3
WireConnection;147;0;145;0
WireConnection;94;0;88;0
WireConnection;91;0;107;0
WireConnection;91;1;93;0
WireConnection;100;0;98;0
WireConnection;100;1;94;0
WireConnection;101;0;92;0
WireConnection;142;0;147;0
WireConnection;142;1;147;1
WireConnection;142;2;147;2
WireConnection;89;0;91;0
WireConnection;89;1;90;0
WireConnection;96;0;102;3
WireConnection;40;0;39;1
WireConnection;40;1;39;3
WireConnection;146;0;142;0
WireConnection;87;0;100;0
WireConnection;87;1;101;0
WireConnection;95;0;89;0
WireConnection;95;1;96;0
WireConnection;97;1;95;0
WireConnection;97;0;87;0
WireConnection;42;0;41;0
WireConnection;42;1;40;0
WireConnection;148;0;146;0
WireConnection;43;0;42;0
WireConnection;141;0;148;0
WireConnection;141;1;143;2
WireConnection;136;0;97;0
WireConnection;136;1;135;0
WireConnection;139;0;141;0
WireConnection;99;0;136;0
WireConnection;149;0;139;0
WireConnection;4;0;2;2
WireConnection;4;1;3;1
WireConnection;116;1;112;1
WireConnection;116;12;112;2
WireConnection;175;0;166;0
WireConnection;175;1;168;0
WireConnection;176;0;180;0
WireConnection;176;1;171;0
WireConnection;67;0;64;1
WireConnection;67;1;64;3
WireConnection;66;0;65;1
WireConnection;66;1;65;2
WireConnection;5;1;4;0
WireConnection;5;2;3;2
WireConnection;5;3;3;3
WireConnection;152;0;158;0
WireConnection;152;1;160;0
WireConnection;172;0;175;0
WireConnection;172;1;176;0
WireConnection;137;0;116;0
WireConnection;222;2;224;0
WireConnection;222;3;223;0
WireConnection;239;0;237;1
WireConnection;239;1;237;2
WireConnection;178;1;172;0
WireConnection;6;0;5;0
WireConnection;69;0;67;0
WireConnection;69;1;65;3
WireConnection;151;0;152;0
WireConnection;151;1;157;0
WireConnection;251;0;252;0
WireConnection;251;1;222;0
WireConnection;240;0;237;3
WireConnection;240;1;237;4
WireConnection;70;0;68;0
WireConnection;70;1;66;0
WireConnection;187;0;189;2
WireConnection;174;0;178;1
WireConnection;174;1;169;0
WireConnection;9;0;7;0
WireConnection;9;1;8;0
WireConnection;9;2;6;0
WireConnection;159;0;151;0
WireConnection;159;1;156;0
WireConnection;71;0;69;0
WireConnection;71;1;70;0
WireConnection;238;0;239;0
WireConnection;238;1;240;0
WireConnection;49;1;62;0
WireConnection;47;1;62;0
WireConnection;229;0;251;0
WireConnection;229;1;228;0
WireConnection;38;1;45;0
WireConnection;242;0;238;0
WireConnection;184;0;187;0
WireConnection;72;1;71;0
WireConnection;72;5;65;4
WireConnection;163;2;174;0
WireConnection;73;1;81;0
WireConnection;73;5;74;0
WireConnection;155;0;159;0
WireConnection;155;1;154;0
WireConnection;186;0;188;0
WireConnection;230;0;229;0
WireConnection;52;0;48;0
WireConnection;52;1;47;0
WireConnection;51;0;50;0
WireConnection;51;1;49;0
WireConnection;13;0;38;0
WireConnection;13;1;9;0
WireConnection;12;0;10;0
WireConnection;54;0;51;0
WireConnection;165;0;163;0
WireConnection;182;0;186;0
WireConnection;182;1;187;0
WireConnection;182;2;183;0
WireConnection;225;0;230;0
WireConnection;225;1;155;0
WireConnection;79;0;73;0
WireConnection;79;1;72;0
WireConnection;14;0;38;0
WireConnection;14;1;13;0
WireConnection;14;2;12;0
WireConnection;53;0;52;0
WireConnection;164;0;165;0
WireConnection;215;1;245;0
WireConnection;217;1;244;0
WireConnection;213;1;243;0
WireConnection;55;0;54;0
WireConnection;185;0;182;0
WireConnection;15;0;14;0
WireConnection;197;0;196;0
WireConnection;197;1;195;0
WireConnection;80;0;79;0
WireConnection;56;0;53;0
WireConnection;153;0;225;0
WireConnection;214;1;247;0
WireConnection;236;0;234;0
WireConnection;236;1;214;0
WireConnection;203;0;217;0
WireConnection;203;1;198;0
WireConnection;202;0;215;0
WireConnection;202;1;212;0
WireConnection;216;0;213;0
WireConnection;216;1;193;0
WireConnection;221;1;246;0
WireConnection;221;5;219;0
WireConnection;220;1;218;0
WireConnection;220;0;197;0
WireConnection;210;0;203;0
WireConnection;210;1;200;0
WireConnection;210;2;220;0
WireConnection;208;0;221;0
WireConnection;208;1;192;0
WireConnection;208;2;220;0
WireConnection;204;0;236;0
WireConnection;204;1;201;0
WireConnection;204;2;220;0
WireConnection;207;0;216;0
WireConnection;207;1;194;0
WireConnection;207;2;220;0
WireConnection;110;0;116;0
WireConnection;209;0;191;0
WireConnection;209;1;205;0
WireConnection;209;2;220;0
WireConnection;211;0;202;0
WireConnection;211;1;206;0
WireConnection;211;2;220;0
WireConnection;16;0;4;0
WireConnection;259;0;204;0
WireConnection;259;1;208;0
WireConnection;259;2;211;0
WireConnection;259;3;210;0
WireConnection;259;4;207;0
WireConnection;259;8;209;0
ASEEND*/
//CHKSM=AF4F73AF02B1D7753289EBBB80B6097F9D02AE76