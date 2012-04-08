var TextEffect,
  __hasProp = Object.prototype.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

TextEffect = (function(_super) {

  __extends(TextEffect, _super);

  function TextEffect(text) {
    this.text = text;
    this.life = 90;
  }

  TextEffect.prototype.step = function() {
    return this.life--;
  };

  TextEffect.prototype.draw = function(ctx) {
    ctx.save();
    ctx.font = 'bold 16px sans-serif';
    ctx.translate(this.x, 768 - this.y);
    ctx.fillStyle = "red";
    ctx.globalAlpha = 0.75;
    ctx.fillText(this.text, 0, 0);
    return ctx.restore();
  };

  return TextEffect;

})(Effect);
