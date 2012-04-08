class Entity
  constructor: () ->
    @sprite = spriteManager.sprites["error"]
    @id = guid++
    
    @x = 0
    @y = 0
    @heading = 0
    @facing = 0
    @speed = 0
    @accel = 0
  
    @rotSpeed = 0
    
    @frame = 0
  
  step: () ->
    @facing += @rotSpeed
  
    sngXComp = (@speed * Math.cos(@heading) + @accel * Math.cos(@facing))
    sngYComp = (@speed * Math.sin(@heading) + @accel * Math.sin(@facing))

    @speed = (Math.sqrt(sngXComp * sngXComp + sngYComp * sngYComp))
    @heading = (Math.atan2(sngYComp, sngXComp))
    

    
    @x = (@x + @speed * Math.cos(@heading))
    @y = (@y + @speed * Math.sin(@heading))
    
#    @x = 0 if @x > 1024
#    @x = 1024 if @x < 0
#    @y = 0 if @y > 768
#    @y = 768 if @y < 0
    

  draw: (ctx) ->
    ctx.globalAlpha=1.0;
    xOff = @frame*@sprite.w
    yOff = 0
    ctx.save()
    ctx.translate(@x,768-@y)
    ctx.rotate(-@facing)
    ctx.translate(-@sprite.w/2,-@sprite.h/2) 
    ctx.drawImage(
      @sprite.image,
      @sprite.x+xOff,@sprite.y,
      @sprite.w,@sprite.h,
      0,0,
      @sprite.w,@sprite.h)
    ctx.restore()
    @frame++
    if @frame >= @sprite.xr
      @frame = 0
      
      
      