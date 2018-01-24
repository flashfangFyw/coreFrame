using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ArFoRotate : FoRotate {

    public GameObject mainBody;
	public bool faceToPlayer=false;
	public bool lockX;
    public bool lockY;
    public bool lockZ;
	
    //private Camera player;
    private Vector3 lookAtPosition = Vector3.zero;

	// Use this for initialization
	void Start () {
        //player = Camera.main;
	}
	void OnEnabled()
	{
		//LookToPlayer();
		//quaternionAngles = transform.localRotation;
		//rotateState = (int)RotateState.StartRotate;
	}
	// Update is called once per frame
	void Update () {
		UpdateRotate();
        //if (Application.isPlaying)
        //{
        //    ToLookAt();

        //    transform.LookAt(lookAtPosition);
        //}
	}
	public void LookToPlayer()
	{
		if(!faceToPlayer) return;
        quaternionAngles = transform.localRotation;
        //if (mainBody) mainBody.transform.localPosition =Vector3.down * 50;
        rotateState = (int)RotateState.StartRotate;
		if (Application.isPlaying)
        {
            ToLookAt();

            transform.LookAt(lookAtPosition);
            if (mainBody) mainBody.BroadcastMessage("StartShow");
        }
	}
	public void RotateToEnd()
	{
		rotateState = (int)RotateState.RotateToEnd;
		transform.localRotation = quaternionAngles;
	}
	private void ToLookAt()
    {
        if (Camera.main==null || Camera.main.transform == null ) return;
        if (!lockX) lookAtPosition.x = Camera.main.transform.position.x;
        else lookAtPosition.x = transform.position.x;
        if (!lockY) lookAtPosition.y = Camera.main.transform.position.y;
        else lookAtPosition.y = transform.position.y;
        if (!lockZ) lookAtPosition.z = Camera.main.transform.position.z;
        else lookAtPosition.z = transform.position.z;
    }
	 protected override void UpdateRotate()
    {
        if(rotateState==(int)RotateState.StartRotate)
        {
            transform.Rotate(0, ySpeed * Time.deltaTime, 0);
            if (360-transform.localRotation.eulerAngles.y <=1 &&Time.deltaTime>2)
            {
              RotateToEnd();
            }
        }
        else if (rotateState == (int)RotateState.RotateToEnd)
        {
            float lerp = Mathf.Lerp(transform.localRotation.eulerAngles.y, quaternionAngles.eulerAngles.y , Time.deltaTime);
            //Debug.Log("lerp==================" + transform.localRotation.eulerAngles.y+"============" + quaternionAngles.eulerAngles.y+"============="+lerp);
            transform.Rotate(0, lerp-transform.localRotation.eulerAngles.y, 0);
            if (Mathf.Abs( transform.localRotation.eulerAngles.y - quaternionAngles.eulerAngles.y )< 1) 
			{
				rotateState = (int)RotateState.StopRotate;
			}
        }
        else
        {
            //transform.localRotation= quaternionAngles;
        }
    }
    private void UpdateLocation()
    {
        
    }
}
