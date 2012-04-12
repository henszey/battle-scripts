<html>
  <head></head>
  <body>
    <div id="output"></div>

    <script type="text/javascript">
      var angle, distance, findClosestToShip, step;
  
      step = function(data) {
        var bullets, cBullet, cShip, myShip, response, ships;
        myShip = data.myShip;
        ships = data.ships;
        bullets = data.bullets;
        cBullet = findClosestToShip(myShip, bullets);
        cShip = findClosestToShip(myShip, ships);
        response = {};
        if (myShip.energy >= 10 && (cBullet === 0 || distance(myShip, cBullet) > 200)) {
          response.shooting = true;
          response.thrust = false;
          response.face = angle(myShip, cShip);
        } else {
          response.shooting = false;
          response.thrust = true;
          response.face = angle(myShip, cBullet) - Math.PI / 2;
        }
        return response;
      };
  
      findClosestToShip = function(myShip, entities) {
        var closestEntity, closestShipDistance, distance, entity, _i, _len;
        closestShipDistance = 1000000;
        closestEntity = 0;
        for (_i = 0, _len = entities.length; _i < _len; _i++) {
          entity = entities[_i];
          if (entity.ownerId !== myShip.id) {
            distance = distance(myShip, entity);
            if (distance < closestShipDistance) {
              closestShipDistance = distance;
              closestEntity = entity;
            }
          }
        }
        return closestEntity;
      };
  
      distance = function(a, b) {
        return Math.sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y));
      };
  
      angle = function(a, b) {
        return Math.atan2(b.y - a.y, b.x - a.x);
      };
    </script>

    <script type="text/javascript">
      gameService.registerController(step);
   </script>
  </body>
</html>