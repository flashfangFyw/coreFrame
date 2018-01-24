using UnityEngine;
using System.Collections;
using System;

/* 
    Author:     fyw 
    CreateDate: 2016-11-07 10:35:14 
    Desc:       注释 
*/

public class matBloom : MonoBehaviour 
{
    [Serializable]
    public struct Settings
    {
        [SerializeField]
        [Tooltip("Filters out pixels under this level of brightness.")]
        public float threshold;

        public float thresholdGamma
        {
            set { threshold = value; }
            get { return Mathf.Max(0.0f, threshold); }
        }

        public float thresholdLinear
        {
            set { threshold = Mathf.LinearToGammaSpace(value); }
            get { return Mathf.GammaToLinearSpace(thresholdGamma); }
        }

        [SerializeField, Range(0, 1)]
        [Tooltip("Makes transition between under/over-threshold gradual.")]
        public float softKnee;

        [SerializeField, Range(1, 7)]
        [Tooltip("Changes extent of veiling effects in a screen resolution-independent fashion.")]
        public float radius;

        [SerializeField]
        [Tooltip("Blend factor of the result image.")]
        public float intensity;

        [SerializeField]
        [Tooltip("Controls filter quality and buffer resolution.")]
        public bool highQuality;

        [SerializeField]
        [Tooltip("Reduces flashing noise with an additional filter.")]
        public bool antiFlicker;

        public static Settings defaultSettings
        {
            get
            {
                var settings = new Settings
                {
                    threshold = 0.9f,
                    softKnee = 0.5f,
                    radius = 2.0f,
                    intensity = 0.7f,
                    highQuality = true,
                    antiFlicker = false
                };
                return settings;
            }
        }
    }
    #region public property
    [SerializeField]
    public Settings settings = Settings.defaultSettings;

    public Vector2 speedOffset = new Vector2(0, 0);
    #endregion
    #region private property
    private Vector2 offset = new Vector2(0, 0);
    private MeshRenderer mR;
    private Material shineMat;
    #endregion

    #region unity function
    void OnEnable()
    {
    }
    void Start () 
	{
        initData();
    }   
	void Update () 
	{
        initData();
    }
    void OnDisable()
    {
    }
    void OnDestroy()
    {
    }
    #endregion

    #region public function
    #endregion
    #region private function
    private void initData()
    {
        mR = gameObject.GetComponent<MeshRenderer>();
        if (mR == null) return;
        Material[] materialsUnderRender = mR.materials;
        int i = 0;
        foreach (Material material in materialsUnderRender)
        {
            if (material.shader.name == "Shader Forge/floorDimandShader")
            {
                shineMat = material;
                break;
            }
            i++;
        }
        if(shineMat)
        {
            var useRGBM = Application.isMobilePlatform;
            // blur buffer format
            var rtFormat = useRGBM ? RenderTextureFormat.Default : RenderTextureFormat.DefaultHDR;

            //// determine the iteration count
            //var logh = Mathf.Log(th, 2) + settings.radius - 8;
            //var logh_i = (int)logh;
            //var iterations = Mathf.Clamp(logh_i, 1, kMaxIterations);

            // update the shader properties
            var threshold = settings.thresholdLinear;
            shineMat.SetFloat("_Threshold", threshold);

            var knee = threshold * settings.softKnee + 1e-5f;
            var curve = new Vector3(threshold - knee, knee * 2, 0.25f / knee);
            shineMat.SetVector("_Curve", curve);

            var pfo = !settings.highQuality && settings.antiFlicker;
            shineMat.SetFloat("_PrefilterOffs", pfo ? -0.5f : 0.0f);

            shineMat.SetFloat("_SampleScale", 0.5f);// + logh - logh_i);
            shineMat.SetFloat("_Intensity", Mathf.Max(0.0f, settings.intensity));


            //===============
            offset.x += Time.deltaTime * speedOffset.x;
            offset.y += Time.deltaTime * speedOffset.y;
            shineMat.SetTextureOffset("_NoiseMap", new Vector2(offset.x, offset.y));
        }
        //======================
    }
    #endregion

    #region event function
    #endregion
}
