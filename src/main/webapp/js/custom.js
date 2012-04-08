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
	  reset = true;
  });
  $("#pause").button();
  $("#pause").change(function(){
	  pause = $(this).is(':checked');
  });
  
});

