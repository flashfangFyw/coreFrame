using UnityEngine;
using System.Collections;

public class LevelControl : MonoBehaviour {

    public GameObject child;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
    public void toggle(bool flag)
    {
        if (child) child.SetActive(flag);
    }
}
