class ShipController
  
  constructor: () ->
    @thrust = false
    @facing = 0   
    @shooting = false
    @turning = 0
    
  step: (@myShip, @ships, @bullets) ->

    
  thrustOn: ->
    @thrust = true
  thrustOff: ->
    @thrust = false
  
  sheildsOn: ->
  sheildsOff: ->
  
  face: (angle) ->
    @facing = angle
  
  turnLeft: ->
    @turning = -1
  turnRight: ->
    @turning = 1
  turnOff: ->
    @turning = 0
  
  shootingOn: ->
    @shooting = true
  shootingOff: ->
    @shooting = false
    
  drawLineTo: (target) ->
#    ctx = world.ctx
#    ctx.globalAlpha=0.2
#    ctx.beginPath();
#    ctx.strokeStyle = "gray"
#    ctx.moveTo(@myShip.x,768-@myShip.y);
#    ctx.lineTo(target.x,768-target.y);
#    ctx.closePath();
#    ctx.stroke();

  
class ComputerController extends ShipController
  constructor: () ->
    super
    console.log("Helloz?")
    
  step: (@myShip, @ships, @bullets) ->
    console.log("Hello?")
    @thrustOn()
    
    # find closest objects of interest
    cBullet = @findClosestToShip(@bullets)
    cShip = @findClosestToShip(@ships)
    
    @drawLineTo(cBullet)
    @drawLineTo(cShip)
    
    

    # will there be enough energy to even shoot? otherwise run.
    if(@myShip.energy >= 10 && (cBullet == 0 || UTIL.distance(@myShip,cBullet) > 200))
      @face UTIL.angle(@myShip,cShip)
      @shootingOn()
    else
      @face UTIL.angle(@myShip,cBullet) - Math.PI/2
      @shootingOff()
    

  findClosestToShip: (entities) ->
    closestShipDistance = 1000000   
    closestEntity = 0
    for entity in entities
      if entity.ownerId != @myShip.id
        distance = UTIL.distance(@myShip,entity)
        if distance < closestShipDistance
          closestShipDistance = distance
          closestEntity = entity
    closestEntity


class NetworkController extends ShipController
  constructor: (@id,@ship) ->
    super()
    @nextData = null
    socket.on 'ship-' + @id, (data) =>
      @nextData = data
#      

      console.log data
    
  step: (@myShip, @ships, @bullets) ->
    if @nextData
      @ship.x = @nextData.x
      @ship.y = @nextData.y
      @ship.heading = @nextData.heading
      @ship.facing = @nextData.facing
      @ship.speed = @nextData.speed
      @ship.accel = @nextData.accel

      @facing = @nextData.facing
      @thrust = @nextData.thrust
      @turning = @nextData.turning
      @shooting = @nextData.shooting
      @nextData = null


class SittingDuckController extends ShipController
  constructor: () ->
    super()
    
  step: (@myShip, @ships, @bullets) ->
    @thrustOff()
    
class HumanController extends ShipController

  constructor: () ->
    super()
    @lastUpdate = new Date().getTime();
    @keys = {}
    keydownHandler = (e) =>
      @keys[e.which] = true
    keyupHandler = (e) =>
      @keys[e.which] = false

    ($ document).keydown keydownHandler
    ($ document).keyup keyupHandler

  step: (@myShip, @ships, @bullets) ->
    if @keys[87] == true
      @thrustOn()
    else
      @thrustOff()
 
    if @keys[68]
      @turnLeft()
    else if @keys[65]
      @turnRight()
    else
      @turnOff()
    
    if @keys[32]
      @shootingOn()
    else
      @shootingOff()
      
    if new Date().getTime() - @lastUpdate > 100
      socket.emit 'ship', {
        x: @myShip.x
        y: @myShip.y
        heading: @myShip.heading
        facing: @myShip.facing
        speed: @myShip.speed
        accel: @myShip.accel
        thrust: @thrust
        turning: @turning
        shooting: @shooting
      }
      @lastUpdate = new Date().getTime()
      
    
    
    
    