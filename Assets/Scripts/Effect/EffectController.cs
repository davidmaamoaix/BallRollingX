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
        _effects.RemoveAll(i => i.ApplyEffect(from, to));
    }
}
