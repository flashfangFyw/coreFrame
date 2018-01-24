using UnityEngine;
//using UnityEditor;
using System.Collections;
using ffDevelopmentSpace;

public class myCustomHologramControlForPlaneStyle2: MonoBehaviour {

    public Material materialShield;
    public Material standardControlMaterial;
    //public float brightnessCollision = 5.0f;
    //public float fadingGlow = 1.0f;
    //public float armor = 100;
    public Vector4 speedOffset = new Vector4(0, 0, 0, 0);
    public float fadeSpeedOnOff = 1.0f;
    public float hologramAnimatoinSpeed = 1f;
    public float meshOffset = 0.01f;
    public Material targetMaterial;

    private float mTime;
    [HideInInspector]
    public int i = 0;
    private bool offsetFlag=false;
    private Vector4 offset = new Vector4(0, 0, 0, 0);
    private float camDistance;
    private Color alphaColorOnBaseMaterial;

    #region unity function

   void Start()
    {
        alphaColorOnBaseMaterial = Color.white;
        //alphaColorOnBaseMaterial.a = 0.0f;
        SetVerticesStartAndEnd();
        CreatHologram();
        //ChangeMaterial();
    }

    void Update()
    {
        if(offsetFlag)
        {
            offset.x += Time.deltaTime * speedOffset.x;
            offset.y += Time.deltaTime * speedOffset.y;
            offset.z += Time.deltaTime * speedOffset.z;
            offset.w += Time.deltaTime * speedOffset.w;
            mR.materials[index].SetTextureOffset("_MainTex", new Vector2(offset.x, offset.y));
            mR.materials[index].SetTextureOffset("_NormalMap", new Vector2(offset.z, offset.w));
        }
        if (hologramShow)
        {
            mTime += Time.deltaTime * hologramAnimatoinSpeed;
            mR.materials[index].SetFloat("_EffectTime", Mathf.Lerp(minValue, maxValue, mTime));
            //Debug.Log("time="+ mTime);
            if (mTime >= 1)
            {
                mTime = 0;
                Debug.Log("reset time=" + mTime);
                //HideHologram();
                hologramShow = false;
                HideMaterial();
            }
        }
        if (hologramHide == true)
        {
            mTime += Time.deltaTime * hologramAnimatoinSpeed;
            mR.materials[index].SetFloat("_EffectTime", Mathf.Lerp(maxValue, minValue, mTime));
            //Debug.Log("time=" + mTime);
            if (mTime >= 1)
            {
                mTime = 0;
                hologramHide = false;
                DestroyHologram();
            }
        }
        if(standardShaderShow)
        {
            //mTime += Time.deltaTime * hologramAnimatoinSpeed;
            alphaColorOnBaseMaterial.a += Time.deltaTime * fadeSpeedOnOff;
            mR.materials[0].SetColor("_Color", alphaColorOnBaseMaterial);
            //Debug.Log("time=" + mTime);
            if (alphaColorOnBaseMaterial.a >= 1)
            {
                //Debug.Log("reset _Color=" + alphaColorOnBaseMaterial);
                standardShaderShow = false;
                HideHologram();
            }
        }
        if(standardShaderHide)
        {
            alphaColorOnBaseMaterial.a -= Time.deltaTime * fadeSpeedOnOff;
            mR.materials[0].SetColor("_Color", alphaColorOnBaseMaterial);
            //Debug.Log("time=" + mTime
            if (alphaColorOnBaseMaterial.a <= 0)
            {
                Debug.Log("reset _Color=" + alphaColorOnBaseMaterial);
                ChangeMaterial();
                ShowMaterial();
            }
        }
    }
    #endregion
    #region public function
    private MeshRenderer mR;
    private int index;
    private bool hologramShow = false;
    private bool hologramHide = false;
    public void CreatHologram()
    {
        Debug.Log("CreatHologram");
        mR = gameObject.GetComponent<MeshRenderer>();
        Material[] materialsUnderRender = mR.materials;
        Material[] newMaterialList = new Material[materialsUnderRender.Length + 1];
        int i = 0;
        foreach (Material material in materialsUnderRender)
        {
            if (i >= 0)
            {
                ShaderUtil.SetupMaterialWithBlendMode(material, ShaderUtil.BlendMode.Fade);
                material.SetColor("_Color", alphaColorOnBaseMaterial);
                
                
            }
            newMaterialList[i] = material;
            i++;
        }
        newMaterialList[i] = materialShield;
        mR.materials = newMaterialList;
        newMaterialList[i].SetFloat("_EffectTime", minValue);
        newMaterialList[i].SetFloat("_Size", (maxValue-minValue)/2);
        newMaterialList[i].SetFloat("_MeshOffset", meshOffset);
        maxValue += (maxValue - minValue) / 5;
        index = i;
        mTime = 0;
        ShowHologram();
        setOffset();
        //Debug.Log("=====================" );
    }

    public void DestroyHologram()
    {
        Debug.Log("DestroyHologram");
        setOffset(false);
        MeshRenderer mR = gameObject.GetComponent<MeshRenderer>();
        Material[] materialsUnderRender = mR.materials;
        Material[] newMaterialList = new Material[materialsUnderRender.Length - 1];
        int i = 0;
        
        foreach (Material material in materialsUnderRender)
        {
            if (i < newMaterialList.Length)
            {
                ShaderUtil.SetupMaterialWithBlendMode(material, ShaderUtil.BlendMode.Opaque);
                newMaterialList[i] = material;
            }
            i++;
        }
        mR.materials = newMaterialList;
    }
    private bool standardShaderShow = false;
    private bool standardShaderHide = false;
    public void CreateStandardControlShader()
    {
        Debug.Log("CreateStandardControlShader");
        mR = gameObject.GetComponent<MeshRenderer>();
        Material[] materialsUnderRender = mR.materials;
        Material[] newMaterialList = new Material[materialsUnderRender.Length + 1];
        int i = 0;
        foreach (Material material in materialsUnderRender)
        {
            newMaterialList[i] = material;
            i++;
        }
        newMaterialList[i] = standardControlMaterial;
        mR.materials = newMaterialList;
        newMaterialList[0].SetFloat("_EffectTime", minValue);
        index = i;
        mTime = 0;
        standardShaderShow = true;
        Debug.Log("=====================");
    }
    public void ChangeMaterial()
    {
        if (targetMaterial == null) return;
        //if()
        Debug.Log("ChangeMaterial");
        Color c = Color.white;
        c.a = 0.0f;
        ShaderUtil.SetupMaterialWithBlendMode(targetMaterial, ShaderUtil.BlendMode.Fade);
        targetMaterial.SetColor("_Color", c);
        Debug.Log(" mR.materials[0]=" + mR.materials[0].name);
        Debug.Log(" targetMaterial=" + targetMaterial.name);
        Material[] materialsUnderRender = mR.materials;
        materialsUnderRender[0] = targetMaterial;
        //mR.materials[0] = Resources.Load("floor - style002", typeof(Material)) as Material;
        //mR.sharedMaterials[0]= Instantiate(targetMaterial);
        mR.materials = materialsUnderRender;
        Debug.Log(" mR.materials[0]=" + mR.materials[0].name);
    }
    public void ShowHologram()
    {
        hologramShow = true;
        hologramHide = false;
    }
    public void HideHologram()
    {
        hologramShow = false;
        hologramHide = true;
    }
    public void ShowMaterial()
    {
        standardShaderShow = true;
        standardShaderHide = false;
    }
    public void HideMaterial()
    {
        standardShaderShow = false;
        standardShaderHide = true;
    }
    public void setOffset(bool flag=true)
    {
        offsetFlag = flag;
    }
    #endregion

    #region private function
    private float minValue=0;
    private float maxValue=0;
    private void SetVerticesStartAndEnd()
    {
        Mesh mesh = gameObject.GetComponent<MeshFilter>().mesh;
        Vector3[] vertices = mesh.vertices;
        int i = 0;
        Vector3 vertPos;
        foreach (Vector3 vertice in vertices)
        {
            //Debug.Log("I==" + i);
            vertPos = transform.TransformPoint(vertice);
            if (vertPos.x < minValue) minValue = vertPos.x;
            if(vertPos.x > maxValue) maxValue = vertPos.x;
            i++;
        }
        //Debug.Log("minValue="+ minValue);
        //Debug.Log("maxValue=" + maxValue);
    }
    #endregion
}
