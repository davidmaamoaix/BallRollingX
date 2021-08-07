using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ImageEffect: IEffect {

    protected Material Material { get; private set; }

    public ImageEffect(Material material) {
        Material = material;
    }

    public virtual bool ApplyEffect(RenderTexture from, RenderTexture to) {
        Graphics.Blit(from, to, Material);

        return false;
    }
}

public interface IEffect {

    /*
     * Returns whether the effect should be removed from the manager after
     * this frame.
     */
    public abstract bool ApplyEffect(RenderTexture from, RenderTexture to);
}
