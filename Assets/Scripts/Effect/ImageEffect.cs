using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public abstract class ImageEffect: IEffect {

    protected Material Material { get; private set; }

    public ImageEffect(Material material) {
        Material = material;
    }

    public abstract bool ApplyEffect(RenderTexture from, RenderTexture to);
}
