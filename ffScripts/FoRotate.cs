using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FoRotate : RotationUtil
{
    protected Quaternion quaternionAngles;
    protected int rotateState = 1;
    void Awake()
    {
        quaternionAngles = transform.localRotation;
        //Debug.Log("ag=================="+ quaternionAngles);
    }
    void Update()
    {
        UpdateRotate();
    }
    //public void StartRotate(TipInteractable tip)
    //{
    //    stopFlag =1;
    //    TI = tip;
    //}
    public void StopRotate()
    {
        rotateState = 2;
    }
    protected override void UpdateRotate()
    {
        if(rotateState==1)
        {
            transform.Rotate(0, ySpeed * Time.deltaTime, 0);
            //float lerp = Mathf.Lerp(transform.localRotation.eulerAngles.y, quaternionAngles.eulerAngles.y+360, Time.deltaTime /ySpeed );
            //Debug.Log("lerp==================" + transform.localRotation.eulerAngles.y + "============" + quaternionAngles.eulerAngles.y + "=============" + lerp);
            //transform.Rotate(0, lerp - transform.localRotation.eulerAngles.y, 0);
            //Debug.Log("localRotation==================" + transform.localRotation.eulerAngles.y);
            if (360-transform.localRotation.eulerAngles.y <=1)
            {
                rotateState = 0;
                EndRotate();
            }
        }
        else if (rotateState == 2)
        {
            float lerp = Mathf.Lerp(transform.localRotation.eulerAngles.y, quaternionAngles.eulerAngles.y , Time.deltaTime);
            //Debug.Log("lerp==================" + transform.localRotation.eulerAngles.y+"============" + quaternionAngles.eulerAngles.y+"============="+lerp);
            transform.Rotate(0, lerp-transform.localRotation.eulerAngles.y, 0);
            if (Mathf.Abs( transform.localRotation.eulerAngles.y - quaternionAngles.eulerAngles.y )< 1) rotateState = 0;
        }
        else
        {
            //transform.localRotation= quaternionAngles;
        }
    }
    //private TipInteractable TI;
    protected void EndRotate()
    {
        //if (TI) TI.HideTip();
        transform.localRotation = quaternionAngles;
    }
}
