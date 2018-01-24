using UnityEngine;
using System.Collections;

public class AlhpaShow : MonoBehaviour
{
    public Material material;

    private Material[] materialList;

    private float speedOff = 0.5f;
    private float alphaV = 1;
    private Color alphaColor;
    // Use this for initialization
    void Start ()
    {
        materialList = GetComponent<MeshRenderer>().materials;
        alphaColor = Color.white;
        alphaColor.a = 0.0f;
        for(int i=1;i< materialList.Length;i++)
        {
            Material material = materialList[i];
            material.SetColor("_Color", alphaColor);
        }
    }
	
	// Update is called once per frame
	void Update ()
    {
        if (alphaColor.a < 1.0f)
        {
            alphaColor.a += Time.deltaTime * speedOff;
            for (int i = 1; i < materialList.Length; i++)
            {
                Material material = materialList[i];
                material.SetColor("_Color", alphaColor);
            }
        }
    }
}
