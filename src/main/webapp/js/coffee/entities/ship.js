var Ship,
  __hasProp = Object.prototype.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

Ship = (function(_super) {

  __extends(Ship, _super);

  function Ship() {
    this.health = 100.0;
    this.shields = 100.0;
    this.energy = 100.0;
    this.weaponCooldown = 0;
    Ship.__super__.constructor.apply(this, arguments);
    this.ownerId = this.id;
  }

  Ship.prototype.step = function() {
    Ship.__super__.step.apply(this, arguments);
    if (this.speed > 1.0) this.speed = 1.0;
    if (this.speed < 0) this.speed = 0;
    if (this.energy < 100) this.energy += 0.1;
    if (this.weaponCooldown > 0) this.weaponCooldown -= 0.1;
    if (this.x > 1024 - 20) this.x = 1024 - 20;
    if (this.x < 0 + 20) this.x = 0 + 20;
    if (this.y > 768 - 20) this.y = 768 - 20;
    if (this.y < 0 + 20) return this.y = 0 + 20;
  };

  Ship.prototype.draw = function(ctx) {
    Ship.__super__.draw.apply(this, arguments);
    ctx.save();
    ctx.translate(this.x, 768 - this.y);
    ctx.globalAlpha = 0.5;
    ctx.fillStyle = "gray";
    ctx.fillText("Ship " + this.id, 25, 0);
    ctx.fillStyle = "blue";
    ctx.fillRect(-25, 20, 50 * this.shields / 100, 4);
    ctx.fillStyle = "red";
    ctx.fillRect(-25, 24, 50 * this.health / 100, 4);
    ctx.fillStyle = "green";
    ctx.fillRect(-25, 28, 50 * this.energy / 100, 4);
    return ctx.restore();
  };

  return Ship;

})(Entity);
