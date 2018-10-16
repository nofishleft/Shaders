Shader "nz.Rishaan/TriCut" {
	Properties{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_V1("Triangle Point 1", Vector) = (0,0,1,0)
		_V2("Triangle Point 2", Vector) = (-1,0,-1,0)
		_V3("Triangle Point 3", Vector) = (1,0,-1,0)
		_RectXMin("Rectangle X Min", Float) = -5
		_RectXMax("Rectangle X Max", Float) = 5
		_RectZMin("Rectangle Z Min", Float) = -5
		_RectZMax("Rectangle Z Max", Float) = 5
		_Glossiness("Smoothness", Range(0,1)) = 0.5
		_Metallic("Metallic", Range(0,1)) = 0.0
	}
		SubShader{
		Tags{ "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
#pragma target 3.0

		sampler2D _MainTex;

	struct Input {
		float3 worldPos;
		float2 uv_MainTex;
	};

	float4 _V1;
	float4 _V2;
	float4 _V3;

	float _RectXMin;
	float _RectXMax;
	float _RectZMin;
	float _RectZMax;

	half _Glossiness;
	half _Metallic;
	fixed4 _Color;

	// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
	// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
	// #pragma instancing_options assumeuniformscaling
	UNITY_INSTANCING_BUFFER_START(Props)
		// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		bool inside(float3 p, float4 v1, float4 v2, float4 v3)
	{
		float3 p0 = v1.xyz;
		float3 p1 = v2.xyz;
		float3 p2 = v3.xyz;
		float s = p0.z * p2.x - p0.x * p2.z + (p2.z - p0.z) * p.x + (p0.x - p2.x) * p.z;
		float t = p0.x * p1.z - p0.z * p1.x + (p0.z - p1.z) * p.x + (p1.x - p0.x) * p.z;

		if ((s < 0) != (t < 0))
			return false;

		float A = -p1.z * p2.x + p0.z * (p2.x - p1.x) + p0.x * (p1.z - p2.z) + p1.x * p2.z;
		if (A < 0.0)
		{
			s = -s;
			t = -t;
			A = -A;
		}
		return s > 0 && t > 0 && (s + t) <= A;
	}

		void surf(Input IN, inout SurfaceOutputStandard o) {
		//float squaredDistance = squaredHorizontalDistance(_RectCenter.xyz, IN.worldPos);
		//if (IN.worldPos.x > _RectXMax || IN.worldPos.x < _RectXMin || IN.worldPos.z > _RectZMax || IN.worldPos.z < _RectZMin)
		if (inside(IN.worldPos, _V1, _V2, _V3))
		{
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
			
		}
		else {
			discard;
		}
	}
	ENDCG
	}
			FallBack "Diffuse"
}
