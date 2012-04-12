$ ->
  init()

#globals to clean up....
guid = 0
world = 0
spriteManager = 0

reset = false
pause = false



init = () ->
  ctx = $('#the-canvas')[0].getContext("2d")
  spriteManager = new SpriteManager()
  world = new World ctx
  run()
  

lastTime = new Date().getTime()
run = () ->
  time = new Date().getTime()
  delta = time - lastTime
  lastTime = time - (delta % 10)
  delta = delta - (delta % 10)
  delta = 30 if delta > 30
  if reset
    world.constructor(world.ctx)
    reset = false
  if !pause
    world.draw()
    world.step(delta)
  requestAnimFrame run
  stats.update()
  
  

class Util
  distance: (a,b) ->
    Math.sqrt((a.x - b.x)*(a.x - b.x) + (a.y - b.y)*(a.y - b.y))
  angle: (a,b) ->
    Math.atan2(b.y-a.y,b.x-a.x)
UTIL = new Util()