var UTIL, Util, guid, init, lastTime, pause, reset, run, spriteManager, world;

$(function() {
  return init();
});

guid = 0;

world = 0;

spriteManager = 0;

reset = false;

pause = false;

init = function() {
  var ctx;
  ctx = $('#the-canvas')[0].getContext("2d");
  spriteManager = new SpriteManager();
  world = new World(ctx);
  return run();
};

lastTime = new Date().getTime();

run = function() {
  var delta, time;
  time = new Date().getTime();
  delta = time - lastTime;
  lastTime = time - (delta % 10);
  delta = delta - (delta % 10);
  if (reset) {
    world.constructor(world.ctx);
    reset = false;
  }
  if (!pause) {
    world.draw();
    world.step(delta);
  }
  requestAnimFrame(run);
  return stats.update();
};

Util = (function() {

  function Util() {}

  Util.prototype.distance = function(a, b) {
    return Math.sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y));
  };

  Util.prototype.angle = function(a, b) {
    return Math.atan2(b.y - a.y, b.x - a.x);
  };

  return Util;

})();

UTIL = new Util();
