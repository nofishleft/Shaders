using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PositionUpdater : MonoBehaviour
{
    public Material TransparentMaterial = null;
    public Material CullingMaterial = null;
    public Transform CameraPos;

    public Transform player;

    private void LateUpdate()
    {       
        TransparentMaterial.SetVector("_P1", CameraPos.position);
        TransparentMaterial.SetVector("_P2", player.position);
        CullingMaterial.SetVector("_P1", CameraPos.position);
        CullingMaterial.SetVector("_P2", player.position);
    }
}
