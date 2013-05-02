class World
  constructor: (@ctx,@localId) ->
    @config = {}
    @config.width = 1000
    @config.height = 750
    @config.shipCount = 1
    @config.firstPerson = true
    @config.pause = false
    @config.reset = false
    
    @tick = 0
    @ships = []
    @effects = []
    @bullets = []

    @localShip = null

    ### 
    for num in [1..@config.shipCount]
      ship = new Ship()
      ship.sprite = spriteManager.sprites["Astro" + ((num%10)+1)]
      if num == 1
        shipController = new HumanController()
      else 
        shipController = new NetworkController()
      #new SittingDuckController() 
      ship.shipController = shipController
      ship.x = Math.random()*@config.width
      ship.y = Math.random()*@config.height
      @ships.push ship
    ###

    console.log("World Constructed")
    socket.on 'players', (data) =>
      console.log("Joining: " + data.join)
      if data.join
        ship = new Ship()
        ship.id = data.join
        ship.sprite = spriteManager.sprites["Astro" + ((ship.id%10)+1)]
        if data.join == @localId
          ship.shipController = new HumanController()
        else
          ship.shipController = new NetworkController(ship.id,ship)
        ship.x = data.x
        ship.y = data.y
        @ships.push ship





  step: (delta) ->
    for i in [1..delta/10]
      
#      if @ships.length <= 0
#        @constructor(@ctx)
      
      clonedShips = cloneArray(@ships)
      clonedBullets = cloneArray(@bullets)
      
      for ship in @ships
#        try
        ship.shipController.step(ship, @ships, @bullets)
        if ship.shipController.turning < 0
          ship.shipController.facing-=0.05
        else if ship.shipController.turning > 0
          ship.shipController.facing+=0.05
        
        ship.facing = ship.shipController.facing
        ship.facing = 0 if isNaN ship.facing 
        if ship.shipController.thrust
          ship.accel = 0.01
        else
          ship.accel = 0
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
#        catch error
#          console.log error


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
    @ctx.fillStyle = "rgb(0,0,0)" 
    @ctx.fillRect  0, 0, @config.width, @config.height
    
    @ctx.save()
    if @config.firstPerson && @ships[0]
      @ctx.translate(@config.width/2-@ships[0].x,-@config.height/2+@ships[0].y) # @x,@config.height-@y

    @ctx.globalAlpha=1.0
    #@ctx.drawImage(backImage,0,0,1024,768,-512,-384,1024*2,768*2)
    @ctx.drawImage(backImage,0,0)
    
    for effect in @effects
      effect.draw @ctx
    for ship in @ships
      ship.draw @ctx
    for bullet in @bullets
      bullet.draw @ctx
    @ctx.restore()
    
    
  
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