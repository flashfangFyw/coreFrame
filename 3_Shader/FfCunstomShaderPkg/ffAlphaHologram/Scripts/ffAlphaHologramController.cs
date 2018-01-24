using UnityEngine;
using System.Collections;
using System.Collections.Generic;

/* 
    Author:     fyw
    CreateDate: 20170117 
    Desc:       基于surfaceShader的着色器控制器
*/
namespace ffDevelopmentSpace

{
    public class ffAlphaHologramController : ShaderController, IShaderController
    {

        #region public property

        public GameObject target;
        public Vector4 speedOffset = new Vector4(0, 0, 0, 0);
        public float hologramSpeedOn = 0.1f;
        public float fadeSpeedOn = 1.0f;
        public float hologramSpeedOff = 1.0f;
        public Material hologramMaterial;
        public float meshOffset = 1.0f;
        [HideInInspector]
        public bool finishFlag = false;
        #endregion

        #region private property
        private float mTime;
        private bool offsetFlag = false;
        private bool hologramTopFlag = false;
        //private bool hologramBottomFlag = false;
        private bool fadeFlag = false;
        private bool fadeOffFlag = false;
        private Vector4 offset = new Vector4(0, 0, 0, 0);
        private float camDistance;
        private float minValue = 0;
        private float maxValue = 0;
        private Dictionary<GameObject, Material[]> materialDic;
        private List<Material> hologamMaterials = new List<Material>();
        private List<Material> fadeMaterials = new List<Material>();
        private GameObject clone;
        private Color alphaColor = Color.white;
        private Color hologramColor = Color.white;
        protected int m_queues = 3000;

        #endregion

        #region unity function
        void OnEnable()
        {
        }
        void Start()
        {
            hologramColor = hologramMaterial.GetColor("_Color");
            //SaveMaterials();
            //SetVerticesStartAndEnd();
            //RefreshShader();
        }
        void Update()
        {
            if (offsetFlag)
            {
                RefreshShader();
            }
            if (hologramTopFlag)
            {
                UpdateHologramShow();
            }
            if (fadeFlag)
            {
                UpdateFadeIn();
                //UpdateHolograBottomShow();
            }
            /*if (fadeOffFlag)
            {
                UpdateFadeOff();
            }*/

        }
        private void LateUpdate()
        {
        }
        void OnDisable()
        {
        }
        void OnDestroy()
        {
        }

        #endregion

        #region public function
        public void PlayAnimation()
        {
            target.SetActive(true);
            mTime = 0.5f;
            finishFlag = false;
            CloneGameObject();
            ChangeHologam();
            SetVerticesStartAndEnd();
            RefreshShader();
            hologramTopFlag = true;
        }
        /**
        public void StopAnimation()
        {
            hologramTopFlag = false;
            offsetFlag = false;
        }*/
        /**
        public void ShowShader()
        {
            CloneGameObject();
            SetChildActive(false);
            ChangeHologam();
            SetVerticesStartAndEnd();
            RefreshShader();
            if (hologamMaterials == null) return;
            for (int i = 0; i < hologamMaterials.Count; i++)
            {
                hologamMaterials[i].SetFloat("_EffectTime", maxValue);
            }
            offsetFlag = true;
        }
        
        */

        public void ResetShader()
        {
            SetChildActive(true);
            SetMaterialsBlendMode(target, ShaderUtil.BlendMode.Opaque);
            if (clone) Destroy(clone.gameObject);
        }
        #endregion

        #region private function
        //获取顶点最大，最小值
        private void SetVerticesStartAndEnd()
        {
            minValue = 0;
            maxValue = 0;
            MeshFilter[] filterList = clone.GetComponentsInChildren<MeshFilter>();
            foreach (MeshFilter filter in filterList)
            {
                Mesh mesh = filter.mesh;
                Vector3[] vertices = mesh.vertices;
                int i = 0;
                Vector3 vertPos;
                foreach (Vector3 vertice in vertices)
                {
                    //Debug.Log("I==" + i);
                    vertPos = filter.transform.TransformPoint(vertice);
                    if (vertPos.y < minValue) minValue = vertPos.y;
                    if (vertPos.y > maxValue) maxValue = vertPos.y;
                    i++;
                }
            }
            SkinnedMeshRenderer[] skinMeshRendererList = clone.GetComponentsInChildren<SkinnedMeshRenderer>();
            foreach (SkinnedMeshRenderer skinMeshRenderer in skinMeshRendererList)
            {
                Mesh mesh = skinMeshRenderer.sharedMesh;
                Vector3[] vertices = mesh.vertices;
                int j = 0;
                Vector3 vertPos;
                foreach (Vector3 vertice in vertices)
                {
                    //Debug.Log("I==" + i);
                    vertPos = transform.TransformPoint(vertice);
                    if (vertPos.y < minValue) minValue = vertPos.y;
                    if (vertPos.y > maxValue) maxValue = vertPos.y;
                    j++;
                }
            }
            float disValue = (maxValue - minValue) / 50;
            maxValue += disValue;
            minValue -= disValue;

            if (hologamMaterials == null) return;
            for (int i = 0; i < hologamMaterials.Count; i++)
            {
                hologamMaterials[i].SetFloat("_EffectTime", minValue);
                hologamMaterials[i].SetFloat("_BottomValue", minValue);
            }
            Debug.Log("====================maxValue==" + maxValue + "     minValue==" + minValue);
        }
        /// <summary>
        /// 储存Materials
        /// </summary>
        private void SaveMaterials()
        {
            MeshFilter[] filterList = target.GetComponentsInChildren<MeshFilter>();
            SkinnedMeshRenderer[] skinMeshRendererList = target.GetComponentsInChildren<SkinnedMeshRenderer>();
            if (filterList.Length > 0 || skinMeshRendererList.Length > 0) materialDic = new Dictionary<GameObject, Material[]>();
            foreach (MeshFilter filter in filterList)
            {
                Material[] materials = filter.gameObject.GetComponent<Renderer>().materials;
                materialDic[filter.gameObject] = materials;
            }
            foreach (SkinnedMeshRenderer skinMeshRenderer in skinMeshRendererList)
            {
                Material[] materials = skinMeshRenderer.gameObject.GetComponent<Renderer>().materials;
                materialDic[skinMeshRenderer.gameObject] = materials;
            }
        }
        /// <summary>
        /// 获取materials
        /// </summary>
        private void GetMaterials()
        {
            if (materialDic == null) return;
            MeshFilter[] filterList = target.GetComponentsInChildren<MeshFilter>();
            foreach (MeshFilter filter in filterList)
            {
                Material[] materials = filter.gameObject.GetComponent<Renderer>().materials;
                if (materialDic[filter.gameObject] != null)
                {
                    filter.gameObject.GetComponent<Renderer>().materials = materialDic[filter.gameObject];
                }
            }
            SkinnedMeshRenderer[] skinMeshRendererList = target.GetComponentsInChildren<SkinnedMeshRenderer>();
            foreach (SkinnedMeshRenderer skinMeshRenderer in skinMeshRendererList)
            {
                Material[] materials = skinMeshRenderer.gameObject.GetComponent<Renderer>().materials;
                if (materialDic[skinMeshRenderer.gameObject] != null)
                {
                    skinMeshRenderer.gameObject.GetComponent<Renderer>().materials = materialDic[skinMeshRenderer.gameObject];
                }
            }
        }

        private void ChangeHologam()
        {
            hologamMaterials = new List<Material>();
            MeshFilter[] filterList = clone.GetComponentsInChildren<MeshFilter>();
            foreach (MeshFilter filter in filterList)
            {
                Material[] materials = filter.gameObject.GetComponent<Renderer>().materials;
                Material[] newMaterials = new Material[materials.Length];
                int i = 0;
                foreach (Material material in materials)
                {
                    Texture text = material.GetTexture("_MainTex");
                    Material mat = Instantiate(hologramMaterial);
                    if (meshOffset != 0 && mat.HasProperty("_MeshOffset"))
                    {
                        if (mat.GetFloat("_MeshOffset") != meshOffset)
                        {
                            mat.SetFloat("_MeshOffset", meshOffset);
                        }
                    }
                    mat.SetTexture("_MainTex", text);
                    newMaterials[i] = mat;
                    //Debug.Log("Texture name is "+ text.name);
                    hologamMaterials.Add(newMaterials[i]);
                    i++;
                }
                filter.gameObject.GetComponent<Renderer>().materials = newMaterials;
            }
            SkinnedMeshRenderer[] skinMeshRendererList = clone.GetComponentsInChildren<SkinnedMeshRenderer>();
            foreach (SkinnedMeshRenderer skinMeshRenderer in skinMeshRendererList)
            {
                Material[] materials = skinMeshRenderer.gameObject.GetComponent<Renderer>().materials;
                Material[] newMaterials = new Material[materials.Length];
                int j = 0;
                foreach (Material material in materials)
                {
                    Texture text = material.GetTexture("_MainTex");
                    Material mat = Instantiate(hologramMaterial);
                    if (meshOffset != 0 && mat.HasProperty("_MeshOffset"))
                    {
                        if (mat.GetFloat("_MeshOffset") != meshOffset)
                        {
                            mat.SetFloat("_MeshOffset", meshOffset);
                        }
                    }
                    mat.SetTexture("_MainTex", text);
                    newMaterials[j] = mat;
                    hologamMaterials.Add(newMaterials[j]);
                    j++;
                }
                skinMeshRenderer.gameObject.GetComponent<Renderer>().materials = newMaterials;
            }
        }
        private Vector3 m_startPoint;
        private Vector3 m_endPoint;
        public GameObject TargetCamera;
        private void RefreshShader()
        {
            //camDistance = Vector3.Distance(Camera.main.transform.position, this.transform.position);
            camDistance = Vector3.Distance(TargetCamera.transform.position, this.transform.position);
            offset.x += Time.deltaTime * speedOffset.x;
            offset.y += Time.deltaTime * speedOffset.y;
            offset.z += Time.deltaTime * speedOffset.z;
            offset.w += Time.deltaTime * speedOffset.w;
            if (hologamMaterials == null) return;
            for (int i = 0; i < hologamMaterials.Count; i++)
            {
                hologamMaterials[i].SetTextureOffset("_HologramTex", new Vector2(offset.x, offset.y));
                hologamMaterials[i].SetTextureOffset("_NormalMap", new Vector2(offset.z, offset.w));
                hologamMaterials[i].SetFloat("_CamDistance", camDistance);
            }
        }
        private void UpdateHologramShow()
        {
            mTime += Time.deltaTime * hologramSpeedOn;

            float value = Mathf.Lerp(minValue, maxValue, mTime);
            if (hologamMaterials != null)
            {
                for (int i = 0; i < hologamMaterials.Count; i++)
                {
                    hologamMaterials[i].SetFloat("_EffectTime", value);
                }
            }

            if (mTime >= 1)
            {
                mTime = 0;
                Debug.Log("end HologramShow");
                hologramTopFlag = false;
                //SetChildActive(true);
                if (clone) Destroy(clone.gameObject);
                target.SetActive(false);
                fadeFlag = true;
            }
        }
        private void UpdateHolograBottomShow()
        {
            mTime += Time.deltaTime * hologramSpeedOn;
            float value = Mathf.Lerp(minValue, maxValue, mTime);
            if (hologamMaterials != null)
            {
                for (int i = 0; i < hologamMaterials.Count; i++)
                {
                    hologamMaterials[i].SetFloat("_BottomValue", value);
                }
            }
            //Debug.Log("time=" + mTime);
            if (mTime >= 1)
            {
                mTime = 0;
                Debug.Log("end HologramShow");
                //SetChildActive(true);
            }
        }
        private void UpdateFadeIn()
        {
            if (fadeSpeedOn != 0)
            {
                mTime += Time.deltaTime * fadeSpeedOn;
                float value = Mathf.Lerp(minValue, maxValue, mTime);
                if (hologamMaterials != null)
                {
                    for (int i = 0; i < hologamMaterials.Count; i++)
                    {
                        hologamMaterials[i].SetFloat("_BottomValue", value);
                    }
                }
            }
            else
            {
                mTime = 1;
            }

            if (mTime >= 1)
            {
                mTime = 0;
                Debug.Log("end FadeIn show");
                fadeFlag = false;
                SetMaterialsBlendMode(gameObject, ShaderUtil.BlendMode.Opaque);
                fadeOffFlag = true;
            }
            /**
            for (int i = 0; i < hologamMaterials.Count; i++)
            {
                hologamMaterials[i].SetFloat("_BottomValue", 1);
            }
            mTime = 0;
            Debug.Log("end FadeIn show");
            fadeFlag = false;
            SetMaterialsBlendMode(gameObject, ShaderUtil.BlendMode.Opaque);
            fadeOffFlag = true;*/
        }
        private void UpdateFadeOff()
        {
            mTime += Time.deltaTime * hologramSpeedOff;
            //====================
            hologramColor.a = Mathf.Lerp(1f, 0, mTime);
            if (hologamMaterials != null)
            {
                for (int i = 0; i < hologamMaterials.Count; i++)
                {
                    hologamMaterials[i].SetColor("_Color", hologramColor);
                }
            }
            //=====================
            if (mTime >= 1)
            {
                mTime = 0;
                Debug.Log("end FadeOff show");
                fadeOffFlag = false;
                //GetMaterials();
                if (clone) Destroy(clone.gameObject);
                finishFlag = true;
            }
        }
        /// <summary>
        /// 克隆对象
        /// </summary>
        private void CloneGameObject()
        {

            clone = Instantiate(target, target.transform.parent, false);
            //clone = Instantiate(gameObject, gameObject.transform.position, gameObject.transform.rotation);
            //clone.transform.SetParent(transform.parent);
            Destroy(clone.GetComponent<ffAlphaHologramController>());
            //gameObject.SetActive(false);
            //alphaColor.a = 0;
            //=============
            MeshFilter[] filterList = target.GetComponentsInChildren<MeshFilter>();
            SkinnedMeshRenderer[] skinMeshRendererList = target.GetComponentsInChildren<SkinnedMeshRenderer>();
            foreach (MeshFilter filter in filterList)
            {
                Material[] materials = filter.gameObject.GetComponent<Renderer>().materials;
                Material[] newMaterials = new Material[materials.Length];
                for (int i = 0; i < materials.Length; i++)
                {
                    Material material = materials[i];
                    //ShaderUtil.SetupMaterialWithBlendMode(material, ShaderUtil.BlendMode.Transparent);
                    material.SetColor("_Color", alphaColor);
                    fadeMaterials.Add(material);
                }
                //filter.gameObject.GetComponent<Renderer>().materials = newMaterials;
            }
            foreach (SkinnedMeshRenderer skinMeshRenderer in skinMeshRendererList)
            {
                Material[] materials = skinMeshRenderer.gameObject.GetComponent<Renderer>().materials;
                Material[] newMaterials = new Material[materials.Length];
                for (int i = 0; i < materials.Length; i++)
                {
                    Material material = materials[i];
                    //ShaderUtil.SetupMaterialWithBlendMode(material, ShaderUtil.BlendMode.Fade);
                    material.SetColor("_Color", alphaColor);
                    //newMaterials[i] = material;
                    fadeMaterials.Add(material);
                }
                //skinMeshRenderer.gameObject.GetComponent<Renderer>().materials = newMaterials;
            }
        }
        private void SetMaterialsBlendMode(GameObject target, ShaderUtil.BlendMode blendMode)
        {
            MeshFilter[] filterList = target.GetComponentsInChildren<MeshFilter>();
            SkinnedMeshRenderer[] skinMeshRendererList = target.GetComponentsInChildren<SkinnedMeshRenderer>();
            foreach (MeshFilter filter in filterList)
            {
                Material[] materials = filter.gameObject.GetComponent<Renderer>().materials;
                //Material[] newMaterials = new Material[materials.Length];
                for (int i = 0; i < materials.Length; i++)
                {
                    Material material = materials[i];
                    //Debug.Log("renderQueue=" + material.renderQueue);
                    ShaderUtil.SetupMaterialWithBlendMode(material, blendMode);
                    //material.SetColor("_Color", alphaColor);
                    //newMaterials[i] = material;
                    //fadeMaterials.Add(material);
                }
                //filter.gameObject.GetComponent<Renderer>().materials = newMaterials;
            }
            foreach (SkinnedMeshRenderer skinMeshRenderer in skinMeshRendererList)
            {
                Material[] materials = skinMeshRenderer.gameObject.GetComponent<Renderer>().materials;
                //Material[] newMaterials = new Material[materials.Length];
                for (int i = 0; i < materials.Length; i++)
                {
                    Material material = materials[i];
                    ShaderUtil.SetupMaterialWithBlendMode(material, blendMode);
                    //newMaterials[i] = material;
                    //fadeMaterials.Add(material);
                }
                //skinMeshRenderer.gameObject.GetComponent<Renderer>().materials = newMaterials;
            }
        }
        /// <summary>
        /// 设置所有子节点
        /// </summary>
        private void SetChildActive(bool flag)
        {
            Transform go = target.transform;
            if (go == null) return;
            int n = go.childCount;
            for (int i = n - 1; i >= 0; i--)
            {
                go.GetChild(i).gameObject.SetActive(flag);
            }
        }
        #endregion

        #region event function
        #endregion
    }
}
