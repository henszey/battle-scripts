<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
  <head>
    <script type="text/javascript" src="http://caja.appspot.com/caja.js"></script>
     
    <script type="text/javascript" src="js/lib/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="js/lib/jquery-ui-1.8.18.custom.min.js"></script>
    <script type="text/javascript" src="js/lib/coffee-script.js"></script>
    
    
    <link href="/css/le-frog/jquery-ui-1.8.18.custom.css" rel="stylesheet" type="text/css" />
    
    <!--
    <link href="http://alexgorbatchev.com/pub/sh/current/styles/shThemeDefault.css" rel="stylesheet" type="text/css" />
    <script src="http://alexgorbatchev.com/pub/sh/current/scripts/shCore.js" type="text/javascript"></script>
    <script src="http://alexgorbatchev.com/pub/sh/current/scripts/shAutoloader.js" type="text/javascript"></script>
    <script src='http://alexgorbatchev.com/pub/sh/current/scripts/shBrushXml.js' type='text/javascript'></script>
    <script src='http://alexgorbatchev.com/pub/sh/current/scripts/shBrushJScript.js' type='text/javascript'></script>
    <script src='http://alexgorbatchev.com/pub/sh/current/scripts/shBrushRuby.js' type='text/javascript'></script>
     -->
    <script type="text/javascript" src="js/lib/stats.js"></script>
    
    <script type="text/javascript" src="js/custom.js"></script>
    
    <script type="text/javascript" src="js/config/shiptypes.js"></script>
    
    <script type="text/javascript" src="js/coffee/main.js"></script>
    <script type="text/javascript" src="js/coffee/world.js"></script>
    <script type="text/javascript" src="js/coffee/entities/entity.js"></script>
    <script type="text/javascript" src="js/coffee/entities/ship.js"></script>
    <script type="text/javascript" src="js/coffee/entities/bullet.js"></script>
    <script type="text/javascript" src="js/coffee/entities/effect.js"></script>
    <script type="text/javascript" src="js/coffee/entities/texteffect.js"></script>
    <script type="text/javascript" src="js/coffee/spritemanager.js"></script>
    <script type="text/javascript" src="js/coffee/shipcontroller.js"></script>
    
    <link rel="stylesheet" type="text/css" href="css/main.css" >
    <script type="text/javascript">
      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-30632287-1']);
      _gaq.push(['_setDomainName', 'battlescripts.com']);
      _gaq.push(['_trackPageview']);
      (function() {
          var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
          ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
          var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();
    </script>
  </head>

  <body>
    <div id="content">
    <h1>BATTLE SCRIPTS</h1>
    <canvas id="the-canvas" width="1024" height="768" ></canvas>
    <div id="random-controls">
    <div id="slider"></div>
    Ships: <span id="shipCount"> </span>
    <br>
    <input type="button" id="reset" value="Reset" />
    <input type="checkbox" id="pause" /><label for="pause">Pause</label>
    <input type="checkbox" id="firstPerson" /><label for="firstPerson">First Person</label>
    <input type="button" id="saveScript" value="saveScript" />
    </div>
<div style="clear: both;width:1024px;">
<div style="float: left;">
<form id="the-form" action="/ships" method="post">
<input type="hidden" name="uid" value="1" />
<input type="hidden" name="name" value="1" />
<input type="hidden" name="image" value="1" />
<input type="hidden" name="decal" value="1" />
<textarea id="custom-code-area"  name="content" wrap="off">
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
</textarea>
</form>
</div>
<div style="float: left;padding: 10px">
Asdf
</div>

<div style="clear: both;">
</div>
<div>
<h1>About</h1>
</div>
<!-- 
<div id="disqus_thread"></div>
<script type="text/javascript">
    /* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
    var disqus_shortname = 'battlescripts'; // required: replace example with your forum shortname

    /* * * DON'T EDIT BELOW THIS LINE * * */
    (function() {
        var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
        dsq.src = 'http://' + disqus_shortname + '.disqus.com/embed.js';
        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
    })();
</script>
<noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
<a href="http://disqus.com" class="dsq-brlink">blog comments powered by <span class="logo-disqus">Disqus</span></a>
 -->
 </div>
 
 
    <div id="guest"></div>
    
    <script type="text/javascript">
     caja.initialize({
        cajaServer: 'https://caja.appspot.com/',
        debug: true
      });
     
      caja.load(document.getElementById('guest'), undefined, function(frame) {
        var controllers = [];

        var gameService = {
          registerController: function(l) {
            controllers.push(l);
          }
        };
        caja.markReadOnlyRecord(gameService);
        caja.markFunction(gameService.registerController);
        var tamedGameService = caja.tame(gameService);

        function callListeners() { 
          var event = { myShip: {}, ships: [], bullets: [] };
          caja.markReadOnlyRecord(event);
          var tamedEvent = caja.tame(event);
          for (var i = 0; i < controllers.length; i++) {
            var response = controllers[i](tamedEvent); 
          }
        };

        setInterval(callListeners, 1000);

        frame.code('/about','text/html')
             .api({ gameService: tamedGameService })
             .run();
     });
    </script>
    
    
  </body>
</html>