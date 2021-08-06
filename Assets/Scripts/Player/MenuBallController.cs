using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MenuBallController: MonoBehaviour {

    [SerializeField]
    private float _rotationSpeed = 0.25F;
    [SerializeField]
    private float _moveSpeed = 5;
    [SerializeField]
    private CharacterController _controller;
    [SerializeField]
    private float _buildOffset = 0;
    [SerializeField]
    private float _groundEnd = 50;
    [SerializeField]
    private MeshRenderer _ground;

    private float _maxDist = 0;
      
    void Start() {
        
    }

    void Update() {
        UpdateMovement();
        UpdateRotation();
        UpdateGround();
    }

    private void UpdateMovement() {
        float moveX = Input.GetAxis("Horizontal");
        float moveZ = Input.GetAxis("Vertical");

        Vector3 move = new Vector3(moveX, 0, moveZ) * Time.deltaTime;
        move *= _moveSpeed;

        _controller.Move(move);
    }

    private void UpdateGround() {
        if (transform.position.z > _maxDist) {
            _maxDist = transform.position.z;

            float percentage = (_maxDist + _buildOffset) / _groundEnd;
            _ground.material.SetFloat("_Percentage", percentage);
        }
    }

    private void UpdateRotation() {
        transform.Rotate(Vector3.up, _rotationSpeed, Space.World);
    }
}
