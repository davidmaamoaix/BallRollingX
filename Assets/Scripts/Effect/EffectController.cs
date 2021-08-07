using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EffectController {

    public static EffectController Ins {
        get;
        private set;
    } = new EffectController();

    private List<IEffect> _effects = new List<IEffect>();
    
    public void AddEffect(IEffect effect) {
        _effects.Add(effect);
    }

    /*
     * Apply all effects to the given texture. Remove any depleted effects.
     */
    public void ApplyEffects(RenderTexture from, RenderTexture to) {
        RenderTexture a = RenderTexture.GetTemporary(from.width, from.height);
        RenderTexture b = RenderTexture.GetTemporary(from.width, from.height);
        bool targetB = true;

        Graphics.CopyTexture(from, a);

        _effects.RemoveAll(e => {
            targetB = !targetB;
            return targetB ? e.ApplyEffect(b, a) : e.ApplyEffect(a, b);
        });

        // since 'targetB' refers to the next copy, this is inverted
        if (!targetB) Graphics.Blit(b, to);
        else Graphics.Blit(a, to);

        RenderTexture.ReleaseTemporary(a);
        RenderTexture.ReleaseTemporary(b);
    }
}
