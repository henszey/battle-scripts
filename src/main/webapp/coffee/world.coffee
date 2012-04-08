class World
  constructor: (@ctx) ->
    @tick = 0
    @ships = []
    @effects = []
    @bullets = []
    shipCount = $("#slider").slider("value")
    for num in [1..shipCount]
      ship = new Ship()
      ship.sprite = spriteManager.sprites["Astro" + ((num%10)+1)]
      shipController = new ExampleController()
      ship.shipController = shipController
      ship.x = Math.random()*1024
      ship.y = Math.random()*768
      ship.facing = Math.random()*Math.PI*2
      ship.accel = 0.05
      #ship.rotSpeed = 0.0001
      @ships.push ship

  step: (delta) ->
    for i in [1..delta/10]
      #TODO: Clone ships
      
      if @ships.length <= 1
        @constructor(@ctx)
      
      clonedShips = cloneArray(@ships)
      clonedBullets = cloneArray(@bullets)
      
      for ship in @ships
        try
          ship.shipController.step(ship, @ships, @bullets)
          ship.facing = ship.shipController.facing
          ship.facing = 0 if isNaN ship.facing 
          if ship.shipController.shooting and ship.energy > 10 and ship.weaponCooldown <= 0
            ship.weaponCooldown = 1
            ship.energy -= 10
            bullet = new Bullet()
            bullet.sprite = spriteManager.sprites["Bullet11"]
            bullet.ownerId = ship.id
            bullet.x = ship.x
            bullet.y = ship.y
            bullet.heading = ship.facing
            bullet.facing = ship.facing
            bullet.speed = 2
            @bullets.push(bullet)
          ship.step()
          if @tick % 10 == 0
            effect = new EngineEffect()
            effect.x = ship.x #+ Math.cos(ship.facing-Math.PI) * 10
            effect.y = ship.y #+ Math.sin(ship.facing-Math.PI) * 10
            #effect.heading = ship.heading
            #effect.speed = ship.speed
            @effects.push effect
        catch error
          #uh oh....


      idx = 0
      while idx < @bullets.length
        bullet = @bullets[idx]
        bullet.step()
        if bullet.life < 0
          @bullets.splice(idx, 1)
        else
          removed = false
          sidx = 0      
          while sidx < @ships.length
            ship = @ships[sidx]
            if ship.id != bullet.ownerId && UTIL.distance(ship,bullet) < 22
              textEffect = new TextEffect("-10")
              textEffect.x = bullet.x
              textEffect.y = bullet.y
              @effects.push textEffect
              ship.health-=10
              if ship.health <= 0
                @ships.splice(sidx, 1)
                sidx--
                effect = new Effect()
                effect.x = ship.x
                effect.y = ship.y
                @effects.push effect
                #new Audio("/sounds/explosion1.ogg").play()
              @bullets.splice(idx, 1)
              removed = true
              break
            sidx++
          idx += 1 if !removed
      
      idx = 0
      while idx < @effects.length
        effect = @effects[idx]
        effect.step()
        if effect.life < 0
          @effects.splice(idx, 1)
        else
          idx++
           
    @tick++ 
      
  draw: () ->
#   @ctx.fillStyle = "rgb(0,0,0)" 
#   @ctx.fillRect  0, 0, 1024, 768
    @ctx.globalAlpha=1.0
    @ctx.drawImage(backImage,0,0)
    for effect in @effects
      effect.draw @ctx
    for ship in @ships
      ship.draw @ctx
    for bullet in @bullets
      bullet.draw @ctx
    
    
  
  cloneArray = (ary) ->
    newAry = []
    newAry.push(clone(obj)) for obj in ary
    return newAry
    
  clone = (obj) ->
    if not obj? or typeof obj isnt 'object' or obj instanceof NamedNodeMap or obj instanceof Image or obj instanceof ShipController
      return obj
    newInstance = new obj.constructor()
    for key of obj
      newInstance[key] = clone obj[key]
    return newInstance