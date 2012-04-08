var Effect, EngineEffect,
  __hasProp = Object.prototype.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

Effect = (function(_super) {

  __extends(Effect, _super);

  function Effect() {
    this.life = 90 * 5;
  }

  Effect.prototype.step = function() {
    return this.life--;
  };

  Effect.prototype.draw = function(ctx) {
    if (explosion[90 - Math.floor(this.life / 5)] != null) {
      ctx.save();
      ctx.translate(this.x, 768 - this.y);
      ctx.translate(-64 / 2, -48 / 2);
      ctx.drawImage(explosion[90 - Math.floor(this.life / 5)], 0, 0, 64, 48, 0, 0, 64, 48);
      return ctx.restore();
    }
  };

  return Effect;

})(Entity);

EngineEffect = (function(_super) {

  __extends(EngineEffect, _super);

  function EngineEffect() {
    EngineEffect.__super__.constructor.apply(this, arguments);
    this.sprite = spriteManager.sprites["exhaust"];
    this.life = 18;
    this.superLife = 18;
  }

  EngineEffect.prototype.step = function() {
    this.superLife -= 0.3;
    this.life = Math.round(this.superLife);
    this.frame = 18 - this.life;
    return EngineEffect.__super__.step.apply(this, arguments);
  };

  return EngineEffect;

})(Entity);
