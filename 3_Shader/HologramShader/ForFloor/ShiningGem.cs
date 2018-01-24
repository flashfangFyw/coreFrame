using UnityEngine;
using System.Collections;

public class ShiningGem : MonoBehaviour {

    public Vector2 speedOffset = new Vector2(0, 0);


    private bool cermaMove = false;
    private Vector2 offset = new Vector2(0, 0);
    #region unity function
    // Use this for initialization
    void Start () {
        initData();
    }
	
	// Update is called once per frame
	void Update () {
        checkCameraMove();
        if (cermaMove)
        {
            offset.x += Time.deltaTime * speedOffset.x;
            offset.y += Time.deltaTime * speedOffset.y;
            shineMat.SetTextureOffset("_NoiseMap", new Vector2(offset.x, offset.y));
            //Debug.Log("is  move");
        }
       
    }
    #endregion
    #region public function
    private MeshRenderer mR;
    private Material shineMat;
    private void initData()
    {
        mR = gameObject.GetComponent<MeshRenderer>();
        if (mR == null) return;
        Material[] materialsUnderRender = mR.materials;
        int i = 0;
        foreach (Material material in materialsUnderRender)
        {
            if (material.shader.name== "Shader Forge/shaderTest003")
            {
                shineMat = material;
                break;
            }
            i++;
        }
        //======================
        postionValue.x = Mathf.Floor(Camera.main.transform.position.x*100)/100;
        postionValue.y = Mathf.Floor(Camera.main.transform.position.y*100)/100;
        postionValue.z = Mathf.Floor(Camera.main.transform.position.z*100)/100;
        //postionValue.x = Camera.main.transform.position.x;
        //postionValue.y = Camera.main.transform.position.y;
        //postionValue.z = Camera.main.transform.position.z;

        //cameraPosition = Camera.main.transform.position;
        cameraPosition = postionValue;
        //rotationValue.x = Mathf.Round(Camera.main.transform.rotation.x);
        //rotationValue.y = Mathf.Round(Camera.main.transform.rotation.y);
        //rotationValue.z = Mathf.Round(Camera.main.transform.rotation.z);
        //rotationValue.w = Mathf.Round(Camera.main.transform.rotation.w);
        //cameraRotation = rotationValue;
    }
    private Vector3 cameraPosition;
    private Vector3 postionValue = new Vector3();
    //private Quaternion cameraRotation;
    //private Quaternion rotationValue=new Quaternion();
    private void checkCameraMove()
    {
        if (Camera.main == null) return;
        //rotationValue.x = Mathf.Round(Camera.main.transform.rotation.x);
        //rotationValue.y = Mathf.Round(Camera.main.transform.rotation.y);
        //rotationValue.z = Mathf.Round(Camera.main.transform.rotation.z);
        //rotationValue.w = Mathf.Round(Camera.main.transform.rotation.w);
        postionValue.x = Mathf.Floor(Camera.main.transform.position.x * 100) / 100;
        postionValue.y = Mathf.Floor(Camera.main.transform.position.y * 100) / 100;
        postionValue.z = Mathf.Floor(Camera.main.transform.position.z * 100) / 100;
        //postionValue.x = Camera.main.transform.position.x;
        //postionValue.y = Camera.main.transform.position.y;
        //postionValue.z = Camera.main.transform.position.z;


        //cermaMove = (Camera.main.transform.position != cameraPosition && rotationValue != cameraRotation);
        cermaMove = (postionValue != cameraPosition);
        cameraPosition = postionValue;
        //cameraRotation = rotationValue;
    }
    #endregion
}
