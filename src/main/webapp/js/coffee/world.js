var World;

World = (function() {
  var clone, cloneArray;

  function World(ctx) {
    var num, ship, shipController, shipCount;
    this.ctx = ctx;
    this.tick = 0;
    this.ships = [];
    this.effects = [];
    this.bullets = [];
    shipCount = $("#slider").slider("value");
    for (num = 1; 1 <= shipCount ? num <= shipCount : num >= shipCount; 1 <= shipCount ? num++ : num--) {
      ship = new Ship();
      ship.sprite = spriteManager.sprites["Astro" + ((num % 10) + 1)];
      shipController = new ExampleController();
      ship.shipController = shipController;
      ship.x = Math.random() * 1024;
      ship.y = Math.random() * 768;
      ship.facing = Math.random() * Math.PI * 2;
      ship.accel = 0.05;
      this.ships.push(ship);
    }
  }

  World.prototype.step = function(delta) {
    var bullet, clonedBullets, clonedShips, effect, i, idx, removed, ship, sidx, textEffect, _i, _len, _ref, _ref2;
    for (i = 1, _ref = delta / 10; 1 <= _ref ? i <= _ref : i >= _ref; 1 <= _ref ? i++ : i--) {
      if (this.ships.length <= 1) this.constructor(this.ctx);
      clonedShips = cloneArray(this.ships);
      clonedBullets = cloneArray(this.bullets);
      _ref2 = this.ships;
      for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
        ship = _ref2[_i];
        try {
          ship.shipController.step(ship, this.ships, this.bullets);
          ship.facing = ship.shipController.facing;
          if (isNaN(ship.facing)) ship.facing = 0;
          if (ship.shipController.shooting && ship.energy > 10 && ship.weaponCooldown <= 0) {
            ship.weaponCooldown = 1;
            ship.energy -= 10;
            bullet = new Bullet();
            bullet.sprite = spriteManager.sprites["Bullet11"];
            bullet.ownerId = ship.id;
            bullet.x = ship.x;
            bullet.y = ship.y;
            bullet.heading = ship.facing;
            bullet.facing = ship.facing;
            bullet.speed = 2;
            this.bullets.push(bullet);
          }
          ship.step();
          if (this.tick % 10 === 0) {
            effect = new EngineEffect();
            effect.x = ship.x;
            effect.y = ship.y;
            this.effects.push(effect);
          }
        } catch (error) {

        }
      }
      idx = 0;
      while (idx < this.bullets.length) {
        bullet = this.bullets[idx];
        bullet.step();
        if (bullet.life < 0) {
          this.bullets.splice(idx, 1);
        } else {
          removed = false;
          sidx = 0;
          while (sidx < this.ships.length) {
            ship = this.ships[sidx];
            if (ship.id !== bullet.ownerId && UTIL.distance(ship, bullet) < 22) {
              textEffect = new TextEffect("-10");
              textEffect.x = bullet.x;
              textEffect.y = bullet.y;
              this.effects.push(textEffect);
              ship.health -= 10;
              if (ship.health <= 0) {
                this.ships.splice(sidx, 1);
                sidx--;
                effect = new Effect();
                effect.x = ship.x;
                effect.y = ship.y;
                this.effects.push(effect);
              }
              this.bullets.splice(idx, 1);
              removed = true;
              break;
            }
            sidx++;
          }
          if (!removed) idx += 1;
        }
      }
      idx = 0;
      while (idx < this.effects.length) {
        effect = this.effects[idx];
        effect.step();
        if (effect.life < 0) {
          this.effects.splice(idx, 1);
        } else {
          idx++;
        }
      }
    }
    return this.tick++;
  };

  World.prototype.draw = function() {
    var bullet, effect, ship, _i, _j, _k, _len, _len2, _len3, _ref, _ref2, _ref3, _results;
    this.ctx.globalAlpha = 1.0;
    this.ctx.drawImage(backImage, 0, 0);
    _ref = this.effects;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      effect = _ref[_i];
      effect.draw(this.ctx);
    }
    _ref2 = this.ships;
    for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
      ship = _ref2[_j];
      ship.draw(this.ctx);
    }
    _ref3 = this.bullets;
    _results = [];
    for (_k = 0, _len3 = _ref3.length; _k < _len3; _k++) {
      bullet = _ref3[_k];
      _results.push(bullet.draw(this.ctx));
    }
    return _results;
  };

  cloneArray = function(ary) {
    var newAry, obj, _i, _len;
    newAry = [];
    for (_i = 0, _len = ary.length; _i < _len; _i++) {
      obj = ary[_i];
      newAry.push(clone(obj));
    }
    return newAry;
  };

  clone = function(obj) {
    var key, newInstance;
    if (!(obj != null) || typeof obj !== 'object' || obj instanceof NamedNodeMap || obj instanceof Image || obj instanceof ShipController) {
      return obj;
    }
    newInstance = new obj.constructor();
    for (key in obj) {
      newInstance[key] = clone(obj[key]);
    }
    return newInstance;
  };

  return World;

})();
