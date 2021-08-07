using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GlitchImageEffect: ImageEffect {

    private Transform _player;

    public GlitchImageEffect(Transform player, Material mat): base(mat) {
        _player = player;
    }

    override public bool ApplyEffect(RenderTexture from, RenderTexture to) {
        Graphics.Blit(from, to, Material);

        return false;
    }
}
