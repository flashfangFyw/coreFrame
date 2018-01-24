using UnityEngine;
using System.Collections;

public class interaction : MonoBehaviour
{

    public GameObject[] childrenList;
    public Material materialShield;
    //public float brightnessCollision = 5.0f;
    public float fadingGlow = 1.0f;
    //public float armor = 100;
    public float speedOnOff = 10.0f;
    public Vector4 speedOffset = new Vector4(0, 0, 0, 0);

    [HideInInspector]
    public float mTime;
    [HideInInspector]
    public Color shieldColor;
    [HideInInspector]
    public bool hit = false;
    [HideInInspector]
    public bool hit2 = false;
    [HideInInspector]
    public MeshRenderer[] meshRenderList;
    [HideInInspector]
    public int i = 0;

    private float shieldA = 0.0f;
    private GameObject sp;
    private bool activ = false;
    private Vector4 offset = new Vector4(0, 0, 0, 0);
    private Vector3 startPoint;
    private float camDistance;
    private Color alphaColorOnBaseMaterial;

    #region unity function
    // Use this for initialization
    void Start()
    {
        alphaColorOnBaseMaterial = Color.white;
        alphaColorOnBaseMaterial.a = 0.0f;
        Transform obj = this.transform.Find("StartPoint");
        if (obj)
        {
            //startPoint = transform.InverseTransformPoint(obj.position);
            startPoint = obj.position;
        }

        CreateForceField();
        PointHit(startPoint);
    }

    // Update is called once per frame
    void Update()
    {
        //if (activ == false) { CreateForceField(); }
        //if (shieldColor.a < shieldA)
        //{
        //    if (meshRenderList != null)
        //    {
        //        foreach (MeshRenderer tMesh in meshRenderList)
        //        {
        //            tMesh.materials[i].SetVector("_Color", shieldColor);
        //        }
        //    }
        //    shieldColor.a += Time.deltaTime * speedOnOff;
        //}
        //else if (shieldColor.a > shieldA)
        //{
        //    shieldColor.a = shieldA;
        //    if (meshRenderList != null)
        //    {
        //        foreach (MeshRenderer tMesh in meshRenderList)
        //        {
        //            tMesh.materials[i].SetVector("_Color", shieldColor);
        //        }
        //    }
        //}
        camDistance = Vector3.Distance(Camera.main.transform.position, this.transform.position);
        if (meshRenderList != null)
        {
            offset.x += Time.deltaTime * speedOffset.x;
            offset.y += Time.deltaTime * speedOffset.y;
            offset.z += Time.deltaTime * speedOffset.z;
            offset.w += Time.deltaTime * speedOffset.w;
            foreach (MeshRenderer tMesh in meshRenderList)
            {
                //Debug.Log("name is  =" + tMesh.materials[i].name);
                tMesh.materials[i].SetTextureOffset("_MainTex", new Vector2(offset.x, offset.y));
                tMesh.materials[i].SetTextureOffset("_NormalMap", new Vector2(offset.z, offset.w));
                tMesh.materials[i].SetFloat("_CamDistance", camDistance);
            }
        }
        if (hit == true && mTime < 0.9f)
        {
            if (meshRenderList != null)
            {
                foreach (MeshRenderer tMesh in meshRenderList)
                {
                    tMesh.materials[i].SetVector("_Color", shieldColor);
                }
            }
            hit = false;
        }
        //Debug.Log("mTime=" + mTime);
        if (hit2 == true)
        {
            if (mTime < 0.0f)
            {
                mTime = 0.0f;
                if (meshRenderList != null)
                {
                    foreach (MeshRenderer tMesh in meshRenderList)
                    {
                        tMesh.materials[i].SetFloat("_EffectTime", mTime);
                    }
                }
                hit2 = false;
                DestroyForceField();
            }
            else
            {
                mTime -= Time.deltaTime * fadingGlow;
                if (meshRenderList != null)
                {
                    foreach (MeshRenderer tMesh in meshRenderList)
                    {
                        tMesh.materials[i].SetFloat("_EffectTime", mTime);
                        //Debug.Log("mTime=" + mTime);
                    }
                }
            }
        }
    }
    #endregion
    #region public function
    public void CreateForceField()
    {
        meshRenderList = new MeshRenderer[childrenList.Length];
        int j = 0;
        foreach (GameObject childGameObject in childrenList)
        {
            meshRenderList[j] = childGameObject.GetComponent<MeshRenderer>();
            Material[] materialsUnderRender = meshRenderList[j].materials;
            Material[] newMaterialList = new Material[materialsUnderRender.Length + 1];
            i = 0;
            foreach (Material material in materialsUnderRender)
            {
               if(i>0) material.SetColor("_Color", alphaColorOnBaseMaterial);
                newMaterialList[i] = material;
                i++;
            }
            newMaterialList[i] = materialShield;
            meshRenderList[j].materials = newMaterialList;
            j++;
        }
        return;

        mTime = 0.0f;
        foreach (MeshRenderer tMesh in meshRenderList)
        {
            shieldColor = tMesh.materials[i].GetVector("_Color");
        }
        shieldA = shieldColor.a;
        shieldColor.a = 0.0f;
        foreach (MeshRenderer tMesh in meshRenderList)
        {
            tMesh.materials[i].SetVector("_Color", shieldColor);
        }
        hit = false;
        hit2 = false;
        activ = true;
    }

    public void DestroyForceField()
    {
        Debug.Log("DestroyForceField");
            int j = 0;
            foreach (GameObject tUnderShield in childrenList)
            {
                Material[] m = meshRenderList[j].materials;
                Material[] m2 = new Material[m.Length - 1];
                i = 0;
                foreach (Material tM in m)
                {
                    if (i < m2.Length) { m2[i] = tM; }
                    i++;
                }
                meshRenderList[j].materials = m2;
                j++;
            }
            meshRenderList = null;
        mTime = 0.0f;
        shieldA = 0.0f;
        shieldColor = new Color(0, 0, 0, 0);
        hit = false;
        hit2 = false;
        activ = false;
    }
    #endregion
    void OnCollisionEnter(Collision collision)
    {
        foreach (ContactPoint contact in collision.contacts)
        {
            PointHit(contact.point);
            
        }
       
    }
    #region private function
    public void PointHit(Vector3 point)
    {
        if (meshRenderList != null)
        {
            //foreach (MeshRenderer tMesh in meshRenderList)
            //{
            //    tMesh.materials[i].SetVector("_Color", new Vector4(shieldColor.r,
            //                                                                    shieldColor.g,
            //                                                                    shieldColor.b,
            //                                                                    shieldColor.a + brightnessCollision));
            //}
            foreach (MeshRenderer tMesh in meshRenderList)
            {
                tMesh.materials[i].SetVector("_Position", transform.InverseTransformPoint(point));
                //Debug.Log("point=" + transform.InverseTransformPoint(point));
            }
        }
        //mTime = 1.0f;
        //hit = true;
        //hit2 = true;
    }
    #endregion
}
