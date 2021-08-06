using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BallController: MonoBehaviour {

    [SerializeField]
    private float _rotationSpeed;
    
    void Start() {
        
    }

    void Update() {
        UpdateRotation();
    }

    private void UpdateRotation() {
        transform.Rotate(Vector3.up, _rotationSpeed, Space.World);
    }
}
