using System.Collections;
using System.Collections.Generic;
using UnityEngine;
/// <summary>
/// ������ת����
/// 3������Ϊ 3���������ת�ٶ�
/// 3��״̬Ϊ   ��ת��3���׶�
/// </summary>
public class RotationUtil : MonoBehaviour {

    public float xSpeed;
    public float ySpeed;
    public float zSpeed;

	protected enum   RotateState:int 
	{
		StartRotate=0,
		RotateToEnd=1,
		StopRotate=2,
	}
    // Use this for initialization
    void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
        UpdateRotate();
    }
    protected virtual void UpdateRotate()
    {
        transform.Rotate(xSpeed * Time.deltaTime, ySpeed * Time.deltaTime, zSpeed * Time.deltaTime);
    }
}
