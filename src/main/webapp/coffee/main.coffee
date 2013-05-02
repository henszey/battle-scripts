#$ ->
#  init()

#globals to clean up....
guid = 0
world = 0
spriteManager = 0





init = (id) ->
  ctx = $('#the-canvas')[0].getContext("2d")
  spriteManager = new SpriteManager()
  world = new World ctx,id
  run()
  

lastTime = new Date().getTime()
run = () ->
  time = new Date().getTime()
  delta = time - lastTime
  lastTime = time - (delta % 10)
  delta = delta - (delta % 10)
  delta = 30 if delta > 30
  if world.config.reset
    world.constructor(world.ctx)
    reset = false
  if !world.config.pause
    world.step(delta)
  world.draw()
  requestAnimFrame run
  stats.update()
  
  

class Util
  distance: (a,b) ->
    Math.sqrt((a.x - b.x)*(a.x - b.x) + (a.y - b.y)*(a.y - b.y))
  angle: (a,b) ->
    Math.atan2(b.y-a.y,b.x-a.x)
UTIL = new Util()