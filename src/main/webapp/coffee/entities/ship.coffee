class Ship extends Entity
  constructor: ->    
    @health = 100.0
    @shields = 100.0
    @energy = 100.0
    @weaponCooldown = 0
    super
    @ownerId = @id
    
  step: ->
    super
    @speed = 1.0 if @speed > 1.0
    @speed = 0 if @speed < 0
    @speed = @speed - 0.005
    @energy += 0.1 if @energy < 100
    @weaponCooldown -= 0.1 if @weaponCooldown > 0
 
    @x = 1024-20 if @x > 1024-20
    @x = 0+20 if @x < 0+20
    @y = 768-20 if @y > 768-20
    @y = 0+20 if @y < 0+20
    
  draw: (ctx) ->
    super
    ctx.save()
    ctx.translate(@x,768-@y)
    ctx.globalAlpha=0.5;
    ctx.fillStyle = "gray"
    ctx.fillText "Ship " + @id,25,0
    ctx.fillStyle = "blue"
    ctx.fillRect -25,20,50*@shields/100,4
    ctx.fillStyle = "red"
    ctx.fillRect -25,24,50*@health/100,4
    ctx.fillStyle = "green"
    ctx.fillRect -25,28,50*@energy/100,4
    ctx.restore()
    