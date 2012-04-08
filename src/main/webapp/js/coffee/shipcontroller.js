var ExampleController, ShipController,
  __hasProp = Object.prototype.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

ShipController = (function() {

  function ShipController() {}

  ShipController.prototype.step = function(myShip, ships, bullets) {
    this.myShip = myShip;
    this.ships = ships;
    this.bullets = bullets;
    this.thrust = false;
    this.facing = 0;
    return this.shooting = false;
  };

  ShipController.prototype.thrustOn = function() {
    return this.thrust = true;
  };

  ShipController.prototype.thrustOff = function() {
    return this.thrust = false;
  };

  ShipController.prototype.sheildsOn = function() {};

  ShipController.prototype.sheildsOff = function() {};

  ShipController.prototype.face = function(angle) {
    return this.facing = angle;
  };

  ShipController.prototype.turnLeft = function() {};

  ShipController.prototype.turnRight = function() {};

  ShipController.prototype.turnOff = function() {};

  ShipController.prototype.shootingOn = function() {
    return this.shooting = true;
  };

  ShipController.prototype.shootingOff = function() {
    return this.shooting = false;
  };

  return ShipController;

})();

ExampleController = (function(_super) {

  __extends(ExampleController, _super);

  function ExampleController() {
    ExampleController.__super__.constructor.apply(this, arguments);
  }

  ExampleController.prototype.step = function(myShip, ships, bullets) {
    var cBullet, cShip;
    this.myShip = myShip;
    this.ships = ships;
    this.bullets = bullets;
    this.thrustOn();
    cBullet = this.findClosestToShip(this.bullets);
    cShip = this.findClosestToShip(this.ships);
    this.drawLineTo(cBullet);
    this.drawLineTo(cShip);
    if (this.myShip.energy >= 10 && (cBullet === 0 || UTIL.distance(this.myShip, cBullet) > 200)) {
      this.face(UTIL.angle(this.myShip, cShip));
      return this.shootingOn();
    } else {
      this.face(UTIL.angle(this.myShip, cBullet) - Math.PI / 2);
      return this.shootingOff();
    }
  };

  ExampleController.prototype.findClosestToShip = function(ships) {
    var closestShipDistance, closetShip, distance, enemyShip, _i, _len;
    closestShipDistance = 1000000;
    closetShip = 0;
    for (_i = 0, _len = ships.length; _i < _len; _i++) {
      enemyShip = ships[_i];
      if (enemyShip.ownerId !== this.myShip.id) {
        distance = UTIL.distance(this.myShip, enemyShip);
        if (distance < closestShipDistance) {
          closestShipDistance = distance;
          closetShip = enemyShip;
        }
      }
    }
    return closetShip;
  };

  ExampleController.prototype.drawLineTo = function(target) {
    var ctx;
    ctx = world.ctx;
    ctx.globalAlpha = 0.2;
    ctx.beginPath();
    ctx.strokeStyle = "gray";
    ctx.moveTo(this.myShip.x, 768 - this.myShip.y);
    ctx.lineTo(target.x, 768 - target.y);
    ctx.closePath();
    return ctx.stroke();
  };

  return ExampleController;

})(ShipController);
