class TextEffect extends Effect
  constructor: (@text) ->
    @life = 90


  
  step: ->
    @life--

    
  draw: (ctx) ->
    ctx.save()
    ctx.font = 'bold 16px sans-serif'
    ctx.translate(@x,768-@y)
    ctx.fillStyle = "red"
    ctx.globalAlpha=0.75;
    ctx.fillText @text, 0, 0
    ctx.restore()
  