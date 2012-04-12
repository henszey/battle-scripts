window.requestAnimFrame = (function(){
  return  window.requestAnimationFrame       || 
          window.webkitRequestAnimationFrame || 
          window.mozRequestAnimationFrame    || 
          window.oRequestAnimationFrame      || 
          window.msRequestAnimationFrame     || 
          function( callback ){
            window.setTimeout(callback, 0);
          };
})();
    
    
var stats;

$(function(){
  stats = new Stats();
  stats.getDomElement().style.position = 'absolute';
  stats.getDomElement().style.left = '0px';
  stats.getDomElement().style.top = '0px';

  document.body.appendChild( stats.getDomElement() );
  
  //SyntaxHighlighter.all();
  
  $( "#slider" ).slider({
      range: "min",
      value: 10,
      min: 2,
      max: 50,
      slide: function( event, ui ) {
        $( "#shipCount" ).html(ui.value );
      }
    });
  $( "#shipCount" ).html(  $( "#slider" ).slider( "value" ) );
  $("#reset").button();
  $("#reset").click(function(){
	  
	  try{
		  var customController = $("#custom-code-area").val();
		  var result = CoffeeScript.compile(customController, {bare: true});
		  eval(result);
		  alert(ExampleController2);
		  //alert(result);
	  }
	  catch(e){
		  alert(e);
		  return;
	  }
	  
	  world.config.reset = true;
  });
  $("#pause").button();
  $("#pause").change(function(){
	  world.config.pause = $(this).is(':checked');
  });
  $("#firstPerson").button();
  $("#firstPerson").change(function(){
	  world.config.firstPerson = $(this).is(':checked');
  });
  
});

