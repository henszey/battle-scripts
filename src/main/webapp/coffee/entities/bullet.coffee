class Bullet extends Entity
  constructor: () ->
    @life = 500
    super

  
  step: () ->
    @life--
    super 

