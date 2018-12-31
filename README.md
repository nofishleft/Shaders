# Shaders

## CylinderCut
![Image Could Not Load](https://i.imgur.com/wHxvDDa.png)
#### Properties
Property | Description | Default Value
:--- | :---: | ---:
Cylinder Center | Center of the cutting area | `0,0,0,0`
Cylinder Radius | Radius of the cutting area | `10`

## RectCut
![Image Could Not Load](https://i.imgur.com/9QI5su3.png)
#### Properties
Property | Description | Default Value
:--- | :---: | ---:
Rectangle X Min | Lower X boundary | `-5`
Rectangle X Max | Upper X boundary | `5`
Rectangle Z Min | Lower Z boundary | `-5`
Rectangle Z Max | Upper Z boundary | `5`

## TriCut
![Image Could Not Load](https://i.imgur.com/xs8h44Y.png)

#### Properties
Property | Description | Default Value
:--- | :---: | ---:
Triangle Point 1 | A point of the cutting area | `0,0,1,0`
Triangle Point 2 | A point of the cutting area | `-1,0,-1,0`
Triangle Point 3 | A point of the cutting area | `1,0,-1,0`

## CapsuleCut
[![Image Could Not Load](https://i.imgur.com/VFw68Dd.png)](https://www.youtube.com/watch?v=JzCDN72v2R8)

[Demo](https://www.youtube.com/watch?v=JzCDN72v2R8)

This was designed to be used to stop objects from blocking the cameras view of the player, e.g. overhead terrain. Both of the materials below should be added to the same object.

`TransparentMaterial.mat/CapsuleClear.shader` are used to render transparency. These can be ignored if you simply want it to be 100% transparent.

`CullingMaterial.mat/CapsuleCull.shader` are used to disable rendering of this material in areas that are in between the camera  and the player. This is required.

#### Material/Shader Properties

##### TransparentMaterial.mat/CapsuleClear.shader
Property | Description | Default Value
:--- | :---: | ---:
Transparency | The transparency of the materials between the camera and the player | `0.511`

#### Script Properties
Property | Description | Default Value
:--- | :---: | ---:
Transparent Material | Material to render if semi-transparency is required | TransparentMaterial.mat
Culling Material | Radius of the cutting area | CullingMaterial.mat
CameraPos | Transform of Camera | ...
Player | Transform of Player | ...

##### Base Capsule Detection
```glsl
CGPROGRAM
	#pragma surface surf Standard fullforwardshadows
	#pragma target 3.0

		sampler2D _MainTex;
		struct Input {
			float3 worldPos;
			float2 uv_MainTex;
			float4 color : COLOR;
		};

		float3 _P1;
		float3 _P2;

		float _Radius;

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;

		float squaredDistance(float3 a)
		{
			return a.x * a.x + a.y * a.y + a.z * a.z;
		}
    
		void surf(Input IN, inout SurfaceOutputStandard o) {
			if (dot(IN.worldPos - _P1, _P2 - _P1) >= 0 && dot(IN.worldPos - _P2, _P1 - _P2) >= 0 && squaredDistance(cross(IN.worldPos - _P1, _P2 - _P1)) <= _Radius * squaredDistance(_P2 - _P1)) {
				//Inside Capsule
				discard;
			} else {
				// Outside Capsule
				fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
				o.Albedo = c.rgb;
				o.Albedo *= IN.color.rgb;
				// Metallic and smoothness come from slider variables
				o.Metallic = _Metallic;
				o.Smoothness = _Glossiness;
				o.Alpha = c.a;
			}
		}
ENDCG
```
