using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public interface IEffect {

    /*
     * Returns whether the effect should be removed from the manager after
     * this frame.
     */
    public abstract bool ApplyEffect(RenderTexture from, RenderTexture to);
}
