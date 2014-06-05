using UnityEngine;
using System.Collections;

public class Rotator : MonoBehaviour {

	public float speed = 100;
	
	// Update is called once per frame
	void Update () {
		transform.rotation = Quaternion.AngleAxis(speed*Time.time, Vector3.up);
	}
}
