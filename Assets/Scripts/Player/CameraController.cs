using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraController: MonoBehaviour {

    [SerializeField]
    private Transform _player;

    private float _diff;

    void Start() {
        _diff = transform.position.z - _player.position.z;
    }

    void LateUpdate() {
        Vector3 pos = transform.position;
        pos.z = _player.position.z + _diff;
        transform.position = pos;
    }
}
