using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

public class MenuBallController: MonoBehaviour {

    private const float MAX_BLOOM = 25;

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
    [SerializeField]
    private Material _rowMat;
    [SerializeField]
    private Material _glitchMat;
    [SerializeField]
    private GameObject _camera;
    [SerializeField]
    private Vector2 _rollRange;

    private Bloom _bloom;
    private float _bloomIntensity;
    private float _maxDist = 0;
      
    void Start() {
        PostProcessVolume volume = _camera.GetComponent<PostProcessVolume>();
        _bloom = volume.profile.GetSetting<Bloom>();
        _bloomIntensity = _bloom.intensity;

        EffectController.Ins.AddEffect(
            new ImageEffect(_glitchMat)
        );
        EffectController.Ins.AddEffect(
            new ImageEffect(_rowMat)
        );
    }

    void Update() {
        UpdateMovement();
        UpdateRotation();
        UpdateGround();
        UpdateImageEffect();
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

    private void UpdateImageEffect() {
        float dist = transform.position.z - _rollRange.x;
        float scaled = dist / (_rollRange.y - _rollRange.x);
        _bloom.intensity.value = Mathf.Lerp(_bloomIntensity, MAX_BLOOM, scaled);
    }
}
