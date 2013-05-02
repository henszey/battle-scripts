
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
/*
window.requestAnimFrame = function( callback ){
            window.setTimeout(callback, 0);
          };
 */   
var stats;

$(function(){
  stats = new Stats();
  stats.getDomElement().style.position = 'absolute';
  stats.getDomElement().style.left = '0px';
  stats.getDomElement().style.top = '0px';

  //document.body.appendChild( stats.getDomElement() );
  
});

var socket = io.connect();
socket.on('player', function(data){
  console.log("id: " + data.id);
  init(data.id);
});

socket.on('news', function (data) {
  console.log(data);
});

socket.on('ping',function(data){
  socket.emit('ping',data);
});
/*
socket.on('players', function(data){
  if(data.join){
    console.log("Player " + data.join + " has joined");
  } 
  else if(data.part) {
    console.log("Player " + data.part + " has left");
  }
});
*/