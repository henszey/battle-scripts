class Effect extends Entity
  constructor: ->
    @life = 90*5


  
  step: ->
    @life--

    
  draw: (ctx) ->
    if explosion[90 - Math.floor(@life/5)]?
      ctx.save()
      ctx.translate(@x,768-@y)
      ctx.translate(-64/2,-48/2) 
      ctx.drawImage(explosion[90 - Math.floor(@life/5)],
        0,0,
        64,48,
        0,0,
        64,48)
      ctx.restore()

      
class EngineEffect extends Entity
  constructor: ->
    super
    @sprite = spriteManager.sprites["exhaust"]
    @life = 18
    @superLife=18

  step: ->
    @superLife -= 0.3
    @life = Math.round(@superLife)
    @frame = 18 - @life
    super

