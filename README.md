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

###### TransparentMaterial.mat/CapsuleClear.shader
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
