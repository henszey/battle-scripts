
step = (data) ->
  myShip = data.myShip
  ships = data.ships
  bullets = data.bullets

  cBullet = findClosestToShip(myShip,bullets)
  cShip = findClosestToShip(myShip,ships)

  response = {}

  if(myShip.energy >= 10 && (cBullet == 0 || distance(myShip,cBullet) > 200))
    response.shooting = true
    response.thrust = false
    response.face = angle(myShip,cShip)
  else
    response.shooting = false
    response.thrust = true
    response.face = angle(myShip,cBullet) - Math.PI/2
    
  response

findClosestToShip = (myShip,entities) ->
  closestShipDistance = 1000000   
  closestEntity = 0
  for entity in entities
    if entity.ownerId != myShip.id
      distance = distance(myShip,entity)
      if distance < closestShipDistance
        closestShipDistance = distance
        closestEntity = entity
  closestEntity
  
distance = (a,b) ->
  Math.sqrt((a.x - b.x)*(a.x - b.x) + (a.y - b.y)*(a.y - b.y))
  
angle = (a,b) ->
  Math.atan2(b.y-a.y,b.x-a.x)