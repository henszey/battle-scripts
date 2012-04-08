var Bullet,
  __hasProp = Object.prototype.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

Bullet = (function(_super) {

  __extends(Bullet, _super);

  function Bullet() {
    this.life = 500;
    Bullet.__super__.constructor.apply(this, arguments);
  }

  Bullet.prototype.step = function() {
    this.life--;
    return Bullet.__super__.step.apply(this, arguments);
  };

  return Bullet;

})(Entity);
