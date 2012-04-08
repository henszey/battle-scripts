class ShipController
  constructor: () ->

  step: (@myShip, @ships, @bullets) ->
    @thrust = false
    @facing = 0   
    @shooting = false
    
  thrustOn: ->
    @thrust = true
  thrustOff: ->
    @thrust = false
  
  sheildsOn: ->
  sheildsOff: ->
  
  face: (angle) ->
    @facing = angle
  
  turnLeft: ->
  turnRight: ->
  turnOff: ->
  
  shootingOn: ->
    @shooting = true
  shootingOff: ->
    @shooting = false
  
  
class ExampleController extends ShipController
  constructor: () ->
    super
    
  step: (@myShip, @ships, @bullets) ->
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
    

  findClosestToShip: (ships) ->
    closestShipDistance = 1000000   
    closetShip = 0
    for enemyShip in ships
      if enemyShip.ownerId != @myShip.id
        distance = UTIL.distance(@myShip,enemyShip)
        if distance < closestShipDistance
          closestShipDistance = distance
          closetShip = enemyShip
    closetShip
      
      
   drawLineTo: (target) ->
    ctx = world.ctx
    ctx.globalAlpha=0.2
    ctx.beginPath();
    ctx.strokeStyle = "gray"
    ctx.moveTo(@myShip.x,768-@myShip.y);
    ctx.lineTo(target.x,768-target.y);
    ctx.closePath();
    ctx.stroke();
   