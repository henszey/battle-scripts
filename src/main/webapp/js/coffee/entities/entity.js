var Entity;

Entity = (function() {

  function Entity() {
    this.sprite = spriteManager.sprites["error"];
    this.id = guid++;
    this.x = 0;
    this.y = 0;
    this.heading = 0;
    this.facing = 0;
    this.speed = 0;
    this.accel = 0;
    this.rotSpeed = 0;
    this.frame = 0;
  }

  Entity.prototype.step = function() {
    var sngXComp, sngYComp;
    this.facing += this.rotSpeed;
    sngXComp = this.speed * Math.cos(this.heading) + this.accel * Math.cos(this.facing);
    sngYComp = this.speed * Math.sin(this.heading) + this.accel * Math.sin(this.facing);
    this.speed = Math.sqrt(sngXComp * sngXComp + sngYComp * sngYComp);
    this.heading = Math.atan2(sngYComp, sngXComp);
    this.x = this.x + this.speed * Math.cos(this.heading);
    return this.y = this.y + this.speed * Math.sin(this.heading);
  };

  Entity.prototype.draw = function(ctx) {
    var xOff, yOff;
    ctx.globalAlpha = 1.0;
    xOff = this.frame * this.sprite.w;
    yOff = 0;
    ctx.save();
    ctx.translate(this.x, 768 - this.y);
    ctx.rotate(-this.facing);
    ctx.translate(-this.sprite.w / 2, -this.sprite.h / 2);
    ctx.drawImage(this.sprite.image, this.sprite.x + xOff, this.sprite.y, this.sprite.w, this.sprite.h, 0, 0, this.sprite.w, this.sprite.h);
    ctx.restore();
    this.frame++;
    if (this.frame >= this.sprite.xr) return this.frame = 0;
  };

  return Entity;

})();
