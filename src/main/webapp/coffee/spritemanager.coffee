

#TODO: hack
backImage = new Image()
backImage.src = "images/mydarktime-calm-space-ipad-wallpaper.jpg"

#TODO: config
explosion = []

class SpriteManager
  constructor: () ->
    @images = {}
    @sprites = {}
    for shipType in shipTypes
      image = @images[shipType.img]
      if not image?
        image = new Image()
        image.src = "images/" + shipType.img
        @images[shipType.img] = image
      sprite = new Sprite image, shipType.x, shipType.y, shipType.w, shipType.h, shipType.xr, shipType.yr
      @sprites[shipType.name] = sprite

   for i in [1..90]
     image = new Image()
     if i <= 9
       image.src = "images/package/png/64x48/explosion1_000" + i + ".png"
     else
       image.src = "images/package/png/64x48/explosion1_00" + i + ".png"
     explosion.push image
   

class Sprite
  constructor: (@image,@x,@y,@w,@h,@xr,@yr) ->
    if !@xr?
      @xr = 1
    if !@yr?
      @yr = 1
    