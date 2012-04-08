var Sprite, SpriteManager, backImage, explosion;

backImage = new Image();

backImage.src = "images/mydarktime-calm-space-ipad-wallpaper.jpg";

explosion = [];

SpriteManager = (function() {
  var i, image;

  function SpriteManager() {
    var image, shipType, sprite, _i, _len;
    this.images = {};
    this.sprites = {};
    for (_i = 0, _len = shipTypes.length; _i < _len; _i++) {
      shipType = shipTypes[_i];
      image = this.images[shipType.img];
      if (!(image != null)) {
        image = new Image();
        image.src = "images/" + shipType.img;
        this.images[shipType.img] = image;
      }
      sprite = new Sprite(image, shipType.x, shipType.y, shipType.w, shipType.h, shipType.xr, shipType.yr);
      this.sprites[shipType.name] = sprite;
    }
  }

  for (i = 1; i <= 90; i++) {
    image = new Image();
    if (i <= 9) {
      image.src = "images/package/png/64x48/explosion1_000" + i + ".png";
    } else {
      image.src = "images/package/png/64x48/explosion1_00" + i + ".png";
    }
    explosion.push(image);
  }

  return SpriteManager;

})();

Sprite = (function() {

  function Sprite(image, x, y, w, h, xr, yr) {
    this.image = image;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.xr = xr;
    this.yr = yr;
    if (!(this.xr != null)) this.xr = 1;
    if (!(this.yr != null)) this.yr = 1;
  }

  return Sprite;

})();
